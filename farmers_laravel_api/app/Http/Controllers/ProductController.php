<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rule;

class ProductController extends Controller
{
    public function addproduct(Request $request){
        try {
            $productData = $request->validate([
                'product_name' => 'required|string',
                'quantity' => 'required|integer',
                'price' => 'required|integer',
                'location' => 'string',
                'username' => 'required|string',
            ]);
            //get user id using username
            $user = User::query()->where('username',$productData['username'])->first();
            if (!$user)  throw new \Exception("User reference not found");
            Product::create([
                'name' => $productData['product_name'],
                'quantity' => $productData['quantity'],
                'price' => $productData['price'],
                'location' => $productData['location']??null,
                'farmer_id'=>$user->id
            ]);
        }catch (\Exception $e){
            return response(['message' => $e->getMessage()], 201);//successful but something is wrong
        }
        Log::info($request);
        return response()->json(['message' => 'product added successful']);
    }

    public function getProducts(Request $request){
        \Log::error($request);        try {

            $metaData = $request->validate([
                'username' => 'required|string',
            ]);
            //get user id using username
            $user = User::query()->where('username',$metaData['username'])->first();
            if (!$user)  throw new \Exception("User reference not found");
            $products = Product::where('farmer_id',$user->id)->get();
        }catch (\Exception $e){
            return response()->json(['message'=>$e->getMessage()],404);
        }
        return response()->json(['farmer_products'=>$products],200);
    }
}
