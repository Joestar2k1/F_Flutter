<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\ImportedInvoice;
use Illuminate\Http\Request;

class ImportedInvoiceController extends Controller
{
    public function show(){
        return View('admin.imported_invoice.index');
    }

    public function createView(){
        return view('admin.imported_invoice.create');
    }

    public function createDetailView(){
        return View('admin.imported_invoice.create_detail');
    }

    public function create(Request $request)
    {
        $countPrd = ImportedInvoice::all()->count();
        $randomID = 'f23112001pr' .  $countPrd;

        $products = new ImportedInvoice;

        $products->id = $randomID;
        $products->sku = $request->sku;
        $products->name = $request->name;
        $products->description = $request->description;
        $products->stock = $request->stock;
        $products->price = $request->price;
        $products->type = $request->type;
        $products->image = $request->image;
        $products->unit = $request->unit;
        $products->status = $request->status;
        $products->save();
        return view('admin.imported_invoice', compact('data'));
    }
}