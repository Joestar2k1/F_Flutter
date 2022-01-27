<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Invoice;
class InvoiceController extends Controller
{
    public function showInvoice(){
        $invoices = DB::table('invoices')
        ->join('employees','invoices.employeeID','=','employees.id')
        ->join('users','invoices.userID','=','users.id')
        ->select(DB::raw('employees.fullName as nv'),'users.fullName','invoices.id','invoices.dateCreated','total','invoices.status','invoices.shippingAddress','invoices.isPaid')
        ->where('invoices.status',-1)->paginate(3) ;
        return view('admin.invoices.index',compact('invoices'));
    }
    public function orderTracking(){
        $invoices = DB::table('invoices')
        // ->join('employees','invoices.employeeID','=','employees.id')
        ->join('users','invoices.userID','=','users.id')
        ->select('invoices.*','users.fullName')
        ->whereBetween('invoices.status',[1,5])->get();
        return view('admin.invoices.order_tracking',compact('invoices'));
    }
    public function detailsInvoice($invoiceID){
        $invoices = DB::table('invoices')
        ->join('users','invoices.userID','=','users.id')
        ->where('invoices.id',$invoiceID)
        ->select('users.fullName','invoices.id','invoices.dateCreated','invoices.total','invoices.status','invoices.shippingAddress','invoices.shippingPhone','invoices.shippingName','invoices.isPaid')->get();

        $invoice_details = DB::table('invoice_details')
        ->join('products','invoice_details.productID','=','products.id')
        ->where('invoice_details.invoiceID',$invoiceID)->get();

  
        return view('admin.invoices.details',compact('invoices','invoice_details'));
    }
    public function handleConfirmStatus($request){
        $invoices = DB::table('invoices')->where('id',$request)->select('status')->get();
        $invoices->status = $invoices[0]->status+1;
        $invoices->update();
        dd($invoices);
        return  redirect()->route('admin.invoice.orderTracking');
    }
}
