<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\ImportedInvoice;

class Imported_Invoice_Controller extends Controller
{
    // load hóa đơn nhập
    public function loadHoaDonNhap(){
        $data = DB::table('imported_invoices')->paginate(4);
        return View('admin.imported_invoice.index', compact('data'));
    }

    // tạo hóa đơn nhập => Add vào table sản phẩm
    public function createHoaDonNhap(Request $request){
        $data = DB::table('providers')->paginate(4);

        $countImpINV = ImportedInvoice::all()->count();
        $date= Date('Ymd');
        $randomID = 'HDN' .$date. $countImpINV;

        $importedInvoices = new ImportedInvoice;
        $importedInvoices->id = $randomID;
        $importedInvoices->userID = $request->userID;
        $importedInvoices->providerID = $request->providerID;
       $importedInvoices->totalPrice = $request->totalPrice;
        $importedInvoices->save();
        return redirect()->route('admin.provider.index');
    }

}