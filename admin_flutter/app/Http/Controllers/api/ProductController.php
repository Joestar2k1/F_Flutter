<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Product;
use Illuminate\Support\Collection;
class ProductController extends Controller
{
    function getAllProduct(){
        $data = DB::table('products')->get();
        return json_encode(
            $data,
        );
    }
    function viewDetailsProduct($id)
    {
        $data =  DB::table('products')->find($id);       
        if($data !=null){       
            return  json_encode([
             $data,
            ],
            );  
        }       
        else{
            return  json_encode([
                "message" => "Không tìm thấy sản phẩm có id là $id",
            ]);}
    }
   
    function createProduct(Request $request)
    {
        $countPrd = Product::all()->count();
        $randomID = 'f23112001pr' .  $countPrd;

        $products = new Product;
        
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
        $products->created_at =Date('Y-m-d H:i:s');
        $products->updated_at = Date('Y-m-d H:i:s');
        $products->save();
        
        if($products ==null){
            return  json_encode([
                "message" => "Lỗi",
                 "data" => "Thêm không thành công",
            ]);
        }
        return  json_encode([
            "message" => "Thành công",
             "data" => $products,
        ]);
    }
    function editProduct(Request $request,$id)
    {
        $products = Product::find($id);       
        if($products !=null){       
            $products->sku = $request->sku;
            $products->name = $request->name;
            $products->description = $request->description;
            $products->stock = $request->stock;
            $products->price = $request->price;
            $products->type = $request->type;
            $products->image = $request->image;
            $products->unit = $request->unit;
            $products->status = $request->status; 
            $products->update();  
            return  json_encode([
                "message" => "Thành công",
                "data" => $products,
            ],
        );  
               }       
        else{
            return  json_encode([
                "message" => "Lỗi",
                 "data" => "Sửa không thành công",
            ]);}
    }
    function deleteProduct(Request $request,$id)
    {
        $products = Product::find($id);       
        if($products !=null){       
            $products->truncate();  
            return  json_encode([
                "message" => "Thành công",
            ],
        );  
               }       
        else{
            return  json_encode([
                "message" => "Lỗi",
            ]);}
    }
    function showAllCategory()
    {
        $products = DB::table('products')->select('type')->distinct()->get();       
        if($products !=null){       
            return  json_encode(
                $products,
        );  
        }
    }
    function showProductByTypeCategory($dataFormClient)
    {
        $products = DB::table('products')->where('type',$dataFormClient)->get();       
        if($products !=null){       
            return  json_encode(
                $products,
        );  
        }
    }

    function getProductBestSeller(){
            $data = DB::table('invoice_details')
            ->join('products','invoice_details.productID','=','products.id')
            ->groupBy('invoice_details.productID',)
            ->select('invoice_details.productID')
            ->havingRaw('SUM(invoice_details.quantity) > 10')
            ->get();
            foreach($data as $item){
                $list = DB::table('products')->where('id',$item->productID)->get();
            }
            dd($list);
            return response()->json(
               $data,
            );
    }
}