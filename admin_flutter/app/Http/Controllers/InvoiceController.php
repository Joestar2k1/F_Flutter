<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Invoice;
use App\Models\InvoiceDetails;
use App\Models\User;
use App\Models\Product;

class InvoiceController extends Controller
{
    function payment(Request $request,$invoiceID){
       
        $data = DB::table('invoices')->where('id',$invoiceID)
        ->update([
            'shippingAddress' => $request->address,
            'status' => 1,
        ]);
        return response()->json([
            "Thanh toán thành công" => true
        ],200);
    }
    function getInvoiceForUser($userID){
        $checkInvoice = DB::table('invoices')
        ->where('invoices.userID',$userID)
        ->Where('invoices.status','=',-1)
      ->exists();
   
        $query = null;
        if( $checkInvoice){
            $query = DB::table('invoices')
            ->join('users','invoices.userID','=','users.id')
            ->select('invoices.*') 
            ->where('invoices.userID',$userID)
            ->Where('invoices.status','=',-1)
            ->addSelect(DB::raw("null as products"))->get();
           
        foreach( $query  as $item){
            $listProduct = DB::table('invoice_details')
            ->join('products','invoice_details.productID','=','products.id')
            ->where('invoiceID',$item->id)
            ->select('products.*','invoice_details.quantity')->get();
            $item->products = $listProduct;
        }
        }
        if($query != null){
            return json_encode(
                $query,
            );
        }else{
            return response()->json([
                "message" => false
            ],201);
        }
    }
    function getInvoiceWaitingToAccept($userID){
        $checkInvoice = DB::table('invoices')
        ->where('invoices.userID',$userID)
        ->Where('invoices.status','=',1)
      ->exists();
   
        $query = null;
        if( $checkInvoice){
            $query = DB::table('invoices')
            ->join('users','invoices.userID','=','users.id')
            ->select('invoices.*') 
            ->where('invoices.userID',$userID)
            ->Where('invoices.status','=',1)
            ->addSelect(DB::raw("null as products"))->get();
           
        foreach( $query  as $item){
            $listProduct = DB::table('invoice_details')
            ->join('products','invoice_details.productID','=','products.id')
            ->where('invoiceID',$item->id)
            ->select('products.*','invoice_details.quantity')->get();
            $item->products = $listProduct;
        }
        }
        if($query != null){
            return json_encode(
                $query,
            );
        }else{
            return response()->json([
                "message" => false
            ],201);
        }
    }

    function getInvoicePickingUpGood($userID){
        $checkInvoice = DB::table('invoices')
        ->where('invoices.userID',$userID)
        ->Where('invoices.status','=',2)
      ->exists();
   
        $query = null;
        if( $checkInvoice){
            $query = DB::table('invoices')
            ->join('users','invoices.userID','=','users.id')
            ->select('invoices.*') 
            ->where('invoices.userID',$userID)
            ->Where('invoices.status','=',1)
            ->addSelect(DB::raw("null as products"))->get();
           
        foreach( $query  as $item){
            $listProduct = DB::table('invoice_details')
            ->join('products','invoice_details.productID','=','products.id')
            ->where('invoiceID',$item->id)
            ->select('products.*','invoice_details.quantity')->get();
            $item->products = $listProduct;
        }
        }
        if($query != null){
            return json_encode(
                $query,
            );
        }else{
            return response()->json([
                "message" => false
            ],201);
        }
    }

    function getInvoiceOnDelivery($userID){
        $checkInvoice = DB::table('invoices')
        ->where('invoices.userID',$userID)
        ->Where('invoices.status','=',3)
      ->exists();
   
        $query = null;
        if( $checkInvoice){
            $query = DB::table('invoices')
            ->join('users','invoices.userID','=','users.id')
            ->select('invoices.*') 
            ->where('invoices.userID',$userID)
            ->Where('invoices.status','=',1)
            ->addSelect(DB::raw("null as products"))->get();
           
        foreach( $query  as $item){
            $listProduct = DB::table('invoice_details')
            ->join('products','invoice_details.productID','=','products.id')
            ->where('invoiceID',$item->id)
            ->select('products.*','invoice_details.quantity')->get();
            $item->products = $listProduct;
        }
        }
        if($query != null){
            return json_encode(
                $query,
            );
        }else{
            return response()->json([
                "message" => false
            ],201);
        }
    }


   
    
}
