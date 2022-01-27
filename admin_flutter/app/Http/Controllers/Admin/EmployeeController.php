<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EmployeeController extends Controller
{
    public function loadEmployee(){
        $data =DB::table('employees')->paginate(4);
        return view('admin.employee.index',compact('data'));
    }

    public function createEmployee(Request $request){
        $data = DB::table('employees')->paginate(4);

        $countEMP = Employee::all()->count();
        $date= Date('Ymd');
        $randomID = 'EMP' .$date. $countEMP;

        $employees = new Employee;
        $employees->id = $randomID;
        $employees->username = $request->username;
        $employees->fullName = $request->fullName;
        $employees->identifyID = $request->identifyID;
        $employees->email = $request->email;
        $employees->password = $request->password;
        $employees->address = $request->address;
        $employees->phone = $request->phone;
        $employees->position = $request->position;
        $employees->salary = $request->salary;
        $employees->avatar = $request->avatar;
        $employees->status = $request->status;
        $employees->save();
        return redirect()->route('admin.employee.index');
    }
}