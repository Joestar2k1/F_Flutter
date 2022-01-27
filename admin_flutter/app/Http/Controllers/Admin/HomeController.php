<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Invoice;
use Illuminate\Support\Facades\DB;

class HomeController extends Controller
{
    public function index(){
        $countInv = Invoice::All()->count();
        $countUser = DB::table('employees')
        ->where('type','LIKE','%NV%')->count();
        return view('admin.dashboard',['countInv'=> $countInv,'countUser'=>$countUser]);
    }
    
}
