package
{
   import com.bit101.components.CheckBox;
   import com.bit101.components.Label;
   import com.bit101.components.Panel;
   import com.bit101.components.Slider;
   import com.bit101.components.Style;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BlurFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class Main extends Sprite
   {
       
      
      private const size:uint = 600;
      
      private var total:int;
      
      private var bmp:Bitmap;
      
      private var b:BitmapData;
      
      private var count1:Number = 2;
      
      private var count2:Number = 2;
      
      private var count3:Number = 2;
      
      private var color:Color;
      
      private var p:Point;
      
      private var bl:BlurFilter;
      
      private var s:Shape;
      
      private var COUNT_2:Number = 0.00002;
      
      private var COUNT_3:Number = 8e-7;
      
      private var FILL_TYPE_1:int = 2;
      
      private var FILL_TYPE_2:int = 2;
      
      private var FUZZ_1:Number = 2;
      
      private var FUZZ_2:Number = 2;
      
      private var ENABLE_SHAPE_1:Boolean = false;
      
      private var ENABLE_SHAPE_2:Boolean = false;
      
      private var ENABLE_RAINBOW:Boolean = true;
      
      private var OBJ_SIZE:int = 20;
      
      private var BLUR_BEFORE:Boolean = false;
      
      private var globalLabel:Label;
      
      private var bitmapRect:Rectangle;
      
      private var vec:Vector.<uint>;
      
      private var sin:Array;
      
      private var globalCount:int;
      
      public function Main()
      {
         // method body index: 1 method index: 1
         this.total = int(255);
         this.color = new Color(0);
         this.p = new Point();
         this.bl = new BlurFilter(2,2,1);
         this.s = new Shape();
         this.sin = [];
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      private function init(param1:Event = null) : void
      {
         // method body index: 2 method index: 2
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         stage.scaleMode = StageScaleMode.NO_SCALE;
         this.bmp = new Bitmap(new BitmapData(this.size,this.size,false,0));
         this.addChild(this.bmp);
         this.b = this.bmp.bitmapData;
         this.bitmapRect = this.b.rect;
         addEventListener(Event.ENTER_FRAME,this.update);
         Style.setStyle(Style.DARK);
         this.addComponents();
         this.s.graphics.clear();
         this.s.graphics.beginFill(0,0.2);
         this.s.graphics.drawRect(0,0,this.size,this.size);
         this.vec = this.b.getVector(this.bitmapRect);
         this.vec.fixed = true;
      }
      
      private function addComponents() : void
      {
         // method body index: 3 method index: 3
         var _loc1_:Panel = new Panel(this,this.bmp.x + this.bmp.width,0);
         _loc1_.setSize(220,this.size);
         var _loc2_:Label = new Label(_loc1_,10,10,"Total particles");
         var _loc3_:Slider = new Slider(Slider.HORIZONTAL,_loc1_,100,10);
         _loc3_.minimum = 50;
         _loc3_.maximum = 25 * 60;
         _loc3_.value = this.total;
         _loc3_.tick = 1;
         _loc3_.addEventListener(Event.CHANGE,this.onAmountChange);
         var _loc4_:Label = new Label(_loc1_,10,30,"Speed 1");
         var _loc5_:Slider;
         (_loc5_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc4_.y)).minimum = 8e-8;
         _loc5_.maximum = 0.000008;
         _loc5_.tick = 1e-9;
         _loc5_.value = this.COUNT_3;
         _loc5_.addEventListener(Event.CHANGE,this.onCount3Change);
         var _loc6_:Label = new Label(_loc1_,10,50,"Speed 2");
         var _loc7_:Slider;
         (_loc7_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc6_.y)).minimum = 0.000001;
         _loc7_.maximum = 0.0001;
         _loc7_.tick = 0.00001;
         _loc7_.value = this.COUNT_2;
         _loc7_.addEventListener(Event.CHANGE,this.onCount2Change);
         var _loc8_:Label = new Label(_loc1_,10,70,"Blur amount");
         var _loc9_:Slider;
         (_loc9_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc8_.y)).minimum = 1.05;
         _loc9_.maximum = 20;
         _loc9_.tick = 0.1;
         _loc9_.value = this.bl.blurX;
         _loc9_.addEventListener(Event.CHANGE,this.onBlurChange);
         var _loc10_:Label = new Label(_loc1_,10,90,"Apply Blur");
         var _loc11_:CheckBox;
         (_loc11_ = new CheckBox(_loc1_,100,_loc10_.y)).selected = this.BLUR_BEFORE;
         _loc11_.addEventListener(MouseEvent.CLICK,this.onBlurCheckChange);
         var _loc12_:Label = new Label(_loc1_,10,110,"Fade speed");
         var _loc13_:Slider;
         (_loc13_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc12_.y)).minimum = 0;
         _loc13_.maximum = 1;
         _loc13_.tick = 0.01;
         _loc13_.value = 0.2;
         _loc13_.addEventListener(Event.CHANGE,this.onFadeChange);
         var _loc14_:Label = new Label(_loc1_,10,130,"Fill type 1");
         var _loc15_:Slider;
         (_loc15_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc14_.y)).minimum = 1;
         _loc15_.maximum = 6;
         _loc15_.tick = 1;
         _loc15_.value = this.FILL_TYPE_1;
         _loc15_.addEventListener(Event.CHANGE,this.onFillType1Change);
         var _loc16_:Label = new Label(_loc1_,10,150,"Fill type 2");
         var _loc17_:Slider;
         (_loc17_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc16_.y)).minimum = 1;
         _loc17_.maximum = 6;
         _loc17_.tick = 1;
         _loc17_.value = this.FILL_TYPE_2;
         _loc17_.addEventListener(Event.CHANGE,this.onFillType2Change);
         var _loc18_:Label = new Label(_loc1_,10,170,"Shape 1");
         var _loc19_:Slider;
         (_loc19_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc18_.y)).minimum = 1;
         _loc19_.maximum = 10;
         _loc19_.tick = 0.01;
         _loc19_.value = this.FUZZ_1;
         _loc19_.addEventListener(Event.CHANGE,this.onFuzz1Change);
         var _loc20_:CheckBox;
         (_loc20_ = new CheckBox(_loc1_,80,_loc18_.y)).selected = this.ENABLE_SHAPE_1;
         _loc20_.addEventListener(MouseEvent.CLICK,this.onShape1CheckChange);
         var _loc21_:Label = new Label(_loc1_,10,190,"Shape 2");
         var _loc22_:Slider;
         (_loc22_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc21_.y)).minimum = 1;
         _loc22_.maximum = 10;
         _loc22_.tick = 0.01;
         _loc22_.value = this.FUZZ_2;
         _loc22_.addEventListener(Event.CHANGE,this.onFuzz2Change);
         var _loc23_:CheckBox;
         (_loc23_ = new CheckBox(_loc1_,80,_loc21_.y)).selected = this.ENABLE_SHAPE_2;
         _loc23_.addEventListener(MouseEvent.CLICK,this.onShape2CheckChange);
         var _loc24_:Label = new Label(_loc1_,10,210,"Scale");
         var _loc25_:Slider;
         (_loc25_ = new Slider(Slider.HORIZONTAL,_loc1_,100,_loc24_.y)).minimum = 5;
         _loc25_.maximum = 30;
         _loc25_.tick = 1;
         _loc25_.value = this.OBJ_SIZE;
         _loc25_.addEventListener(Event.CHANGE,this.onSizeChange);
         var _loc26_:Label = new Label(_loc1_,10,230,"Color");
         var _loc27_:CheckBox;
         (_loc27_ = new CheckBox(_loc1_,100,_loc26_.y)).selected = this.ENABLE_RAINBOW;
         _loc27_.addEventListener(MouseEvent.CLICK,this.onColorsCheckChange);
         this.globalLabel = new Label(_loc1_,10,_loc1_.height - 24,"");
      }
      
      private function onColorsCheckChange(param1:MouseEvent) : void
      {
         // method body index: 4 method index: 4
         this.ENABLE_RAINBOW = CheckBox(param1.currentTarget).selected;
      }
      
      private function onShape2CheckChange(param1:Event) : void
      {
         // method body index: 5 method index: 5
         this.ENABLE_SHAPE_2 = CheckBox(param1.currentTarget).selected;
      }
      
      private function onShape1CheckChange(param1:Event) : void
      {
         // method body index: 6 method index: 6
         this.ENABLE_SHAPE_1 = CheckBox(param1.currentTarget).selected;
      }
      
      private function onBlurCheckChange(param1:Event) : void
      {
         // method body index: 7 method index: 7
         this.BLUR_BEFORE = CheckBox(param1.currentTarget).selected;
      }
      
      private function onSizeChange(param1:Event) : void
      {
         // method body index: 8 method index: 8
         this.OBJ_SIZE = Slider(param1.currentTarget).value;
      }
      
      private function onFuzz2Change(param1:Event) : void
      {
         // method body index: 9 method index: 9
         this.FUZZ_2 = Slider(param1.currentTarget).value;
      }
      
      private function onFuzz1Change(param1:Event) : void
      {
         // method body index: 10 method index: 10
         this.FUZZ_1 = Slider(param1.currentTarget).value;
      }
      
      private function onFillType2Change(param1:Event) : void
      {
         // method body index: 11 method index: 11
         this.FILL_TYPE_2 = Slider(param1.currentTarget).value;
      }
      
      private function onFillType1Change(param1:Event) : void
      {
         // method body index: 12 method index: 12
         this.FILL_TYPE_1 = Slider(param1.currentTarget).value;
      }
      
      private function onFadeChange(param1:Event) : void
      {
         // method body index: 13 method index: 13
         this.s.graphics.clear();
         this.s.graphics.beginFill(0,Slider(param1.currentTarget).value);
         this.s.graphics.drawRect(0,0,this.size,this.size);
      }
      
      private function onBlurChange(param1:Event) : void
      {
         // method body index: 14 method index: 14
         this.bl.blurX = this.bl.blurY = Slider(param1.currentTarget).value;
      }
      
      private function onCount3Change(param1:Event) : void
      {
         // method body index: 15 method index: 15
         this.COUNT_3 = Slider(param1.currentTarget).value;
      }
      
      private function onCount2Change(param1:Event) : void
      {
         // method body index: 16 method index: 16
         this.COUNT_2 = Slider(param1.currentTarget).value;
      }
      
      private function onAmountChange(param1:Event) : void
      {
         // method body index: 17 method index: 17
         this.total = Slider(param1.currentTarget).value;
      }
      
      private function update(param1:* = null) : void
      {
         // method body index: 18 method index: 18
         this.create();
      }
      
      private function create() : void
      {
         // method body index: 19 method index: 19
         var _loc8_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         this.b.draw(this.s);
         this.vec = this.b.getVector(this.bitmapRect);
         this.b.lock();
         var _loc1_:int = this.globalCount;
         this.globalCount = 0;
         this.count1 += 0.03;
         if(this.ENABLE_RAINBOW)
         {
            this.color.green = 128 + Math.sin(this.count3) * 110;
         }
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         while(_loc10_ < this.total)
         {
            this.count2 += this.COUNT_2;
            _loc4_ += Math.sin(_loc10_ + this.count2) * 20;
            _loc5_ += Math.cos(_loc10_) * 10;
            if(this.ENABLE_RAINBOW)
            {
               this.color.blue = 128 + (this.sin[_loc10_] = this.sin[_loc10_] || Math.sin(_loc10_)) * 110;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc10_ * this.FILL_TYPE_1)
            {
               ++this.globalCount;
               this.count3 += this.COUNT_3;
               _loc2_ = Math.cos(_loc9_ + this.count2) * 15;
               _loc3_ = Math.sin(_loc9_ + this.count3) * 15;
               if(this.ENABLE_RAINBOW)
               {
                  this.color.red = int(128 + (this.sin[_loc9_] = this.sin[_loc9_] || Math.sin(_loc9_)) * 110);
               }
               _loc11_ = int(this.ENABLE_SHAPE_1 ? Math.sin(this.FUZZ_1 * _loc10_) * 2 : 1);
               _loc12_ = int(this.ENABLE_SHAPE_2 ? Math.sin(this.FUZZ_2 + _loc10_ + _loc9_) * 3 : 1);
               _loc13_ = int(_loc11_ + _loc12_);
               _loc6_ = int(5 * 60 + (_loc4_ + _loc2_) / _loc13_ * this.OBJ_SIZE);
               _loc7_ = int(5 * 60 + (_loc5_ + _loc3_) / _loc13_ * this.OBJ_SIZE);
               if(_loc6_ > 0 && _loc6_ < this.size && _loc7_ > 0 && _loc7_ < this.size)
               {
                  this.vec[this.size * _loc7_ + _loc6_] = this.ENABLE_RAINBOW ? uint(this.color.value) : 0xffffff;
               }
               _loc9_ += this.FILL_TYPE_2;
            }
            _loc10_++;
         }
         this.b.setVector(this.bitmapRect,this.vec);
         if(this.BLUR_BEFORE)
         {
            this.b.applyFilter(this.b,this.bitmapRect,this.p,this.bl);
         }
         if(_loc1_ != this.globalCount)
         {
            this.globalLabel.text = this.globalCount + " particles";
         }
         this.b.unlock();
      }
   }
}
