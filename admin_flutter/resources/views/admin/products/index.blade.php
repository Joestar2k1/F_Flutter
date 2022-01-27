@extends('admin.app')
@section('title') Admin-product @endsection
@section('content')

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<div class="row">
<div class="col-sm-4  text-white">
        <a href="{{route('admin.product.create.index')}}" class="btn btn-success">Tạo sản phẩm</a>
    </div>
    <div class="col-sm-4 text-white"> 
        <form class="d-flex" method="GET" action= "{{route('admin.product.search')}}" >     
            <input class="form-control me-2"  name="keyWord" type="text" placeholder="Search">
            <button class="btn btn-primary" type="submit">Tìm kiếm</button>
        </form>
    </div>
    <div class="col-sm-4 text-white"> 
        <div class="dropdown dropend">
            <button type="button" class="btn btn-primary dropdown-toggle"   data-bs-toggle="dropdown">
                Sắp xếp
            </button>
            <ul class="dropdown-menu">             
                <li><a class="dropdown-item" href="{{route('admin.product')}}">Tất cả</a></li>          
                <li><a class="dropdown-item" href="{{route('admin.product.request','price_down')}}">Giá 50.000đ trở xuống</a></li> 
                <li><a class="dropdown-item" href="{{route('admin.product.request','price_up')}}">Giá 50.000đ trở lên</a></li>                   
                <li><a class="dropdown-item" href="{{route('admin.product.request','stock')}}">Số lượng TK tăng dần</a></li>          
            </ul>
        </div>
        
    </div>
  </div>
</div>
<div class="container-fluid">
    <div class="container mt-3">
        <table class="table table-bordered">
            <thead>
                <tr>                 
                    <th>
                        Tên sản phẩm
                    </th>   
                    <th>
                        Số lượng TK
                    </th>   
                    <th>
                       Giá
                    </th>       
                    <th>
                       Mô tả
                    </th>     
                    <th>
                        Ảnh minh họa
                    </th>                  
                    <th>
                     Đơn vị tính
                    </th> 
                    <th>
                        Trạng thái
                    </th> 
                    <th>
                       Sửa
                    </th>     
                    <th>
                       Xóa
                    </th>             
                </tr>
            </thead>
            <tbody>   
                @foreach($data as $item)
                <tr>                        
                   <td> {{$item->name}}</td>
                   <td> {{$item->stock}}</td>
                   <td> {{$item->price}}</td>
                   <td> {{$item->description}}</td>
                  
                   <td> <img style="background:white" src="{{asset('backend/assets/img/products/'.$item->image)}}" class="rounded" alt="Ảnh" width="70" height="70"> </td>               
                   <td> {{$item->unit}}</td>
                   <td> {{$item->status}}</td>
                   <td>
                        <a class="btn btn-success" href="" >Edit</a>
                    </td>
                    <td>
                        <a class="btn btn-danger" href="{{route('admin.product.delete',$item->id)}}">Delete</a>
                    </td>
                </tr>    
                @endforeach           
            </tbody>
        </table>
        {{$data->links()}}
    </div>
</div>


@endsection
