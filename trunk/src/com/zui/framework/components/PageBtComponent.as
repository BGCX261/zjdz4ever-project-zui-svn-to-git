package com.zui.framework.components
{
   
    import flash.display.*;
    import flash.text.*;
    

    public class PageBtComponent extends Object
    {
        private var curPage:int = 0;
        private var maxPage:int;
        private var pageTxt:TextField;
        private var nextPageBt:ZMcButton;
        private var prevPageBt:ZMcButton;
        private var callBack:Function;

        public function PageBtComponent()
        {
            this.nextPageBt = new ZMcButton();
            this.prevPageBt = new ZMcButton();
            this.nextPageBt.addActionEventListener(this.adjPageIndex, 1);
            this.prevPageBt.addActionEventListener(this.adjPageIndex, -1);
        }

        public function getPageIndex() : int
        {
            return this.curPage;
        }

		/**
		 *	设置皮肤 
		 * @param prePageBtSkin
		 * @param nextPageBtSkin
		 * @param pageTxt
		 * 
		 */		
        public function setSkin(prePageBtSkin:MovieClip, nextPageBtSkin:MovieClip, pageTxt:TextField) : void
        {
            this.nextPageBt.setSkin(nextPageBtSkin);
            this.prevPageBt.setSkin(prePageBtSkin);
            this.pageTxt = pageTxt;
            if (pageTxt != null)
            {
				pageTxt.text = "";
            }
        }

		/**
		 *	设置显示的页数和翻页回调函数 
		 * @param curPage
		 * @param maxPage
		 * @param callBack
		 * 
		 */		
        public function setData(curPage:int, maxPage:int, callBack:Function) : void
        {
            this.maxPage = maxPage;
            this.callBack = callBack;
            this.curPage = curPage;
            this.adjPageIndex(0);
        }

        private function adjPageIndex(num:int) : void
        {
            this.curPage = this.curPage + num;
            if (this.curPage <= 0)
            {
                this.curPage = 0;
                this.prevPageBt.enabled = false;
            }
            else
            {
                this.prevPageBt.enabled = true;
            }
            if (this.curPage >= (this.maxPage - 1))
            {
                this.curPage = this.maxPage - 1;
                this.nextPageBt.enabled = false;
            }
            else
            {
                this.nextPageBt.enabled = true;
            }
            if (this.callBack != null)
            {
                this.callBack(this.curPage);
            }
            if (this.pageTxt != null)
            {
                this.pageTxt.text = "第" + (this.curPage + 1) + "页/共" + this.maxPage + "页";
            }
        }

        public function dispose() : void
        {
            this.prevPageBt.dispose();
            this.nextPageBt.dispose();
            this.callBack = null;
        }

    }
}
