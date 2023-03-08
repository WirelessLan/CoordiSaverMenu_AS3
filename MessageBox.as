package  {
	import UIComponent.View;
	import UIComponent.Button;
	import UIComponent.Label;
	import UIComponent.UIEvent;
	
	public class MessageBox extends View {		
		private var _menuWidth:uint = 400;
		private var _menuHeight:uint = 160;
		
		private var _message:String;
		
      	private var messageLbl:Label;
		private var confirmBtn:Button;

		public function MessageBox(title:String, msg:String) {
			this._message = msg;

        	super(this._menuWidth, this._menuHeight, title);
		}
		
		protected override function InitializeView() : void {
			super.InitializeView();
			
			this.messageLbl = new Label(this._menuWidth - 20, this._menuHeight - 115, this._message, 24);
			this.messageLbl.x = 10;
			this.messageLbl.y = 65;
			this.messageLbl.width = this._menuWidth - 20;
			this.messageLbl.height = this._menuHeight - 115;			
			this.AddComponent(this.messageLbl);
			
			this.confirmBtn = new Button(this._menuWidth - 20, 30);
			this.confirmBtn.x = 10;
			this.confirmBtn.y = this._menuHeight - 42;
			this.confirmBtn.text = "_$CoordiSaverMenuConfirm";
			if (Shared.Localizations.$CoordiSaverMenuConfirm)
				this.confirmBtn.text = Shared.Localizations.$CoordiSaverMenuConfirm;
			this.confirmBtn.addEventListener(UIEvent.ACTIVATE, confirmBtn_Activated);
			
			this.AddComponent(this.confirmBtn);
		}
		
		private function confirmBtn_Activated(evn:UIEvent) : * {
			Shared.CloseView(1, true);
		}
	}
}