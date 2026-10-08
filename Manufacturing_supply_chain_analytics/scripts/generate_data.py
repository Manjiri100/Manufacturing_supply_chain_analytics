"""Generate deterministic synthetic manufacturing and supply-chain data."""
import argparse, csv, os, random
from datetime import date, datetime, timedelta
from pathlib import Path

TABLES = {
    'plants':100,'suppliers':5000,'products':20000,'warehouses':500,'customers':250000,
    'purchase_orders':2000000,'production_orders':2000000,'inventory_snapshots':5000000,
    'shipments':3000000,'machine_events':5000000,'quality_inspections':2000000}
START=date(2025,1,1); DAYS=730

def dt(r): return START+timedelta(days=r.randrange(DAYS))
def write_csv(path, header, rows, chunk=100000):
    path.parent.mkdir(parents=True,exist_ok=True)
    with path.open('w',newline='',encoding='utf-8') as f:
        w=csv.writer(f); w.writerow(header); w.writerows(rows)

def scaled(n,s): return max(1,int(n*s))
def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--scale-factor',type=float,default=1.0); ap.add_argument('--output-dir',default='data/generated'); a=ap.parse_args()
    s=a.scale_factor; out=Path(a.output_dir); out.mkdir(parents=True,exist_ok=True); r=random.Random(42)
    write_csv(out/'plants.csv',['plant_id','plant_name','region'],((i,f'Plant {i:03d}',r.choice(['North','South','East','West','Central'])) for i in range(1,scaled(100,s)+1)))
    write_csv(out/'suppliers.csv',['supplier_id','supplier_name','region'],((i,f'Supplier {i:05d}',r.choice(['UK','EU','APAC','Americas'])) for i in range(1,scaled(5000,s)+1)))
    write_csv(out/'products.csv',['product_id','product_name','category','unit_cost'],((i,f'Product {i:05d}',r.choice(['Components','Finished Goods','Packaging','Raw Materials']),round(r.uniform(2,1500),2)) for i in range(1,scaled(20000,s)+1)))
    write_csv(out/'warehouses.csv',['warehouse_id','warehouse_name','region'],((i,f'Warehouse {i:03d}',r.choice(['North','South','East','West','Central'])) for i in range(1,scaled(500,s)+1)))
    write_csv(out/'customers.csv',['customer_id','customer_name','segment'],((i,f'Customer {i:06d}',r.choice(['Enterprise','SMB','Retail','Distributor'])) for i in range(1,scaled(250000,s)+1)))
    plants=scaled(100,s); suppliers=scaled(5000,s); products=scaled(20000,s); warehouses=scaled(500,s); customers=scaled(250000,s)
    def rows_po():
        for i in range(1,scaled(2000000,s)+1):
            od=dt(r); promised=od+timedelta(days=r.randint(5,45)); status=r.choice(['Received','Received','Received','Late','Open','Cancelled']); rec=promised+timedelta(days=r.randint(-5,20)) if status in ('Received','Late') else ''
            if i%10007==0: rec=promised-timedelta(days=2)
            yield [i,r.randint(1,suppliers),r.randint(1,plants),r.randint(1,products),od,promised,rec,r.randint(1,5000),round(r.uniform(2,1500),2),status]
    def rows_prod():
        for i in range(1,scaled(2000000,s)+1):
            ps=dt(r); ae=ps+timedelta(days=r.randint(1,20)); planned=ps+timedelta(days=r.randint(1,10)); status=r.choice(['Completed','Completed','In Progress','Delayed','Cancelled']); qty=r.randint(50,5000); produced=max(0,qty+r.randint(-500,300));
            yield [i,r.randint(1,plants),r.randint(1,products),ps,ps,planned,ae,qty,produced,status]
    def rows_inv():
        for i in range(1,scaled(5000000,s)+1):
            snap=dt(r); on=max(0,r.randint(-50,10000)); alloc=max(0,min(on+r.randint(-500,1000),on+1000)); reorder=r.randint(100,4000); yield [i,snap,r.randint(1,warehouses),r.randint(1,products),on,alloc,reorder,round(on*r.uniform(2,1500),2)]
    def rows_ship():
        for i in range(1,scaled(3000000,s)+1):
            sd=dt(r); promised=sd+timedelta(days=r.randint(1,15)); status=r.choice(['Delivered','Delivered','Delivered','Delayed','In Transit','Cancelled']); actual=promised+timedelta(days=r.randint(-2,12)) if status in ('Delivered','Delayed') else ''; yield [i,r.randint(1,warehouses),r.randint(1,customers),sd,promised,actual,r.randint(1,1000),status]
    def rows_machine():
        types=['Breakdown','Maintenance','Temperature','Vibration','Power','Inspection']; sev=['Low','Medium','High','Critical']
        for i in range(1,scaled(5000000,s)+1): yield [i,r.randint(1,plants),f'M-{r.randint(1,5000):05d}',datetime.combine(dt(r),datetime.min.time())+timedelta(minutes=r.randint(0,1439)),r.choice(types),r.randint(-20,480),r.choice(sev)]
    def rows_quality():
        defects=['None','Dimensional','Surface','Material','Assembly','Contamination']
        for i in range(1,scaled(2000000,s)+1):
            ins=r.randint(10,5000); fail=r.randint(0,min(ins,300)); result='Pass' if fail==0 else r.choice(['Fail','Rework']); yield [i,r.randint(1,scaled(2000000,s)),r.randint(1,plants),r.randint(1,products),dt(r),ins,fail,r.choice(defects),result]
    specs=[('purchase_orders.csv',['po_id','supplier_id','plant_id','product_id','order_date','promised_date','received_date','quantity','unit_cost','status'],rows_po),('production_orders.csv',['production_order_id','plant_id','product_id','planned_start','actual_start','planned_end','actual_end','planned_quantity','produced_quantity','status'],rows_prod),('inventory_snapshots.csv',['snapshot_id','snapshot_date','warehouse_id','product_id','on_hand_quantity','allocated_quantity','reorder_point','inventory_value'],rows_inv),('shipments.csv',['shipment_id','warehouse_id','customer_id','ship_date','promised_delivery_date','actual_delivery_date','quantity','status'],rows_ship),('machine_events.csv',['event_id','plant_id','machine_id','event_timestamp','event_type','duration_minutes','severity'],rows_machine),('quality_inspections.csv',['inspection_id','production_order_id','plant_id','product_id','inspection_date','inspected_quantity','failed_quantity','defect_type','result'],rows_quality)]
    for name,header,fn in specs: write_csv(out/name,header,fn())
    print(f'Generated {sum(scaled(v,s) for v in TABLES.values()):,} records in {out.resolve()}')
if __name__=='__main__': main()
