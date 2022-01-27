@extends('admin.app')
@section('title') Theo dõi hóa đơn @endsection
@section('content')

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="container">
<div style="color:green;text-align:center">
        <h3>Danh sách hóa đơn đang theo dõi</h3>
</div>
<div style="height:50px"></div>
<div class="row">
  <div class="col"></div>
  <div class="col"> 
      <form class="d-flex" method="GET" action= "" >     
            <input class="form-control me-2"  name="keyWord" type="text" placeholder="vd:Mã HĐ..">
            <button class="btn btn-success" type="submit">Tìm kiếm</button>
        </form> </div>
  <div class="col">
        <div class="col-sm-4 text-white"> 
        <div class="dropdown dropend">
            <button type="button" class="btn btn-success dropdown-toggle"   data-bs-toggle="dropdown">
                Xem hóa đơn
            </button>
            <ul class="dropdown-menu">             
                <li><a class="dropdown-item" href="">Tất cả</a></li>          
                <li><a class="dropdown-item" href="">Mới nhất</a></li>          
                <li><a class="dropdown-item" href="">Đang giao hàng</a></li> 
                <li><a class="dropdown-item" href="">Chờ xác nhận</a></li>                   
            </ul>
        </div>
        
    </div>
  </div>
</div>
<div style="height:50px"></div>
<div class="container-fluid">
    <div class="container mt-3">
        <table class="table table-bordered">
            <thead>
                <tr class="success">
                    <th>
                       Mã hóa đơn
                    </th>
                    <th>
                       Nhân viên
                    </th>
                    <th>
                      Khách hàng
                    </th> 
                    <th>
                        Ngày tạo
                    </th>                                                        
                    <th>
                        Tổng
                    </th>   
                    <th>
                       Thanh toán
                    </th> 
                    
                    <th>
                       Trạng thái
                    </th>       
                </tr>
            </thead>
            <tbody>   
                @foreach($invoices as $item)
                <tr>                        
                    <td>{{$item->id}}</td>
                    <td>{{$item->employeeID}}</td>
                    <td>{{$item->fullName}}</td>
                     <td> {{$item->dateCreated}}</td>                           
                     <td> {{$item->total}}</td>
                   <td>   
                        @if($item->isPaid ==0)
                         <span>   <i class="fa fa-close" style="color:red"></i>Chưa</span>
                        @endif                    
                    </td>
                    <td>
                       @if($item->status==1)
                        <a href="{{route('admin.invoice.confirmStatus',$item->id)}}" class="btn btn-success">Xác nhận?</a>
                       @endif
                       @if($item->status==2)
                       <div class="dropdown">
                            <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
                              Đã xác nhận
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="{{route('admin.invoice.confirmStatus',$item->id)}}">Đang lấy hàng</a></li>
                            </ul>
                        </div>
                       @endif
                       @if($item->status==3)
                       <div class="dropdown">
                            <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
                              Đang lấy hàng
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="{{route('admin.invoice.confirmStatus',$item->id)}}">Đang vận chuyển</a></li>
                            </ul>
                        </div>
                       @endif
                       @if($item->status==4)
                       <div class="dropdown">
                            <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
                             Đang vận chuyển
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="{{route('admin.invoice.confirmStatus',$item->id)}}">Thành công</a></li>
                            </ul>
                        </div>
                       @endif
                       @if($item->status==5)
                        <a href="" class="btn btn-success">Thành công</a>
                       @endif
                    </td>
                </tr>    
                @endforeach           
            </tbody>
        </table>
     
    </div>
</div>
@endsection