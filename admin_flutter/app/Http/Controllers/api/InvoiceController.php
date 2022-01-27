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
    function showAll(){
        $data = DB::table('invoices')->get();
        return json_encode(
            $data,
        );
    }
    function getInvoiceForUser($userID){
        $data = DB::table('invoices')
            ->join('users','invoices.userID','=','users.id')
            ->join('invoice_details','invoices.id','=','invoice_details.invoiceID')
            ->select('invoices.*','invoice_details.productID','invoice_details.quantity')
            ->where('invoices.userID',$userID)->get();
        return json_encode(
            $data,
        );
    }
    function createInvoice(Request $request)
    {
        $countInv =  DB::table('invoices')->count()+1;
        $randomID = 'f23112001inv' .  $countInv;

        $invoices = new Invoice;
        
        $invoices->id = $randomID;
        $invoices->userID = $request->userID;
        $invoices->shippingName = $request->shippingName;
        $invoices->shippingAddress = $request->shippingAddress;
        $invoices->shippingPhone = $request->shippingPhone;
        $invoices->total = $request->total;
        $invoices->status =true;
        $invoices->dateCreated = Date('Y-m-d H:i:s');
        $invoices->created_at = Date('Y-m-d H:i:s');
        $invoices->updated_at =Date('Y-m-d H:i:s');
        $invoices->save();
        
     
        if($invoices ==null){
            return  json_encode([
                "message" => "Lỗi",
                 "data" => "Thêm không thành công",
            ]);
        }
        return  json_encode([
            "message" => "Thành công",
             "data" => $invoices,
        ]);
    }
    
}
