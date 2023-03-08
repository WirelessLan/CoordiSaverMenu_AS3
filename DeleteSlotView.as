package  {
	import UIComponent.View;
	import UIComponent.Label;
	import UIComponent.Button;
	import UIComponent.UIEvent;
	
	public class DeleteSlotView extends View {		
		private var _menuWidth:uint = 500;
		private var _menuHeight:uint = 220;
		
		private var _slotName:String;
		
		private var msgLbl:Label;
		private var slotNameLbl:Label;
		private var deleteBtn:Button;
		private var cancelBtn:Button;
		
		public function DeleteSlotView(slotName:String) {
			var titleText = "_$CoordiSaverMenuDeleteSlotTitle";
			if (Shared.Localizations.$CoordiSaverMenuDeleteSlotTitle)
				titleText = Shared.Localizations.$CoordiSaverMenuDeleteSlotTitle;
			
			this._slotName = slotName;
			
        	super(this._menuWidth, this._menuHeight, titleText);
		}
		
		protected override function InitializeView() : void {
			super.InitializeView();
			
			var msgText = "_$CoordiSaverMenuConfirmDeleteSlot"
			if (Shared.Localizations.$CoordiSaverMenuConfirmDeleteSlot)
				msgText = Shared.Localizations.$CoordiSaverMenuConfirmDeleteSlot;
			this.msgLbl = new Label(this._menuWidth - 20, 32, msgText, 24);
			this.msgLbl.x = 10;
			this.msgLbl.y = 65;
			this.AddComponent(this.msgLbl);
			
			this.slotNameLbl = new Label(this._menuWidth - 20, 28, this._slotName, 20);
			this.slotNameLbl.x = 10;
			this.slotNameLbl.y = 100;
			this.AddComponent(this.slotNameLbl);
			
			this.deleteBtn = new Button(150, 28);
			this.deleteBtn.x = this._menuWidth / 2 - this.deleteBtn.width / 2;
			this.deleteBtn.y = 140;
			this.deleteBtn.text = "_$CoordiSaverMenuDeleteSlot"
			if (Shared.Localizations.$CoordiSaverMenuDeleteSlot)
				this.deleteBtn.text = Shared.Localizations.$CoordiSaverMenuDeleteSlot;
			this.deleteBtn.addEventListener(UIEvent.ACTIVATE, deleteBtn_Activated);
			this.AddComponent(this.deleteBtn);
			
			this.cancelBtn = new Button(150, 28);
			this.cancelBtn.x = this._menuWidth / 2 - this.deleteBtn.width / 2;
			this.cancelBtn.y = 175;
			this.cancelBtn.text = "_$CoordiSaverMenuCancelDeleteSlot"
			if (Shared.Localizations.$CoordiSaverMenuCancelDeleteSlot)
				this.cancelBtn.text = Shared.Localizations.$CoordiSaverMenuCancelDeleteSlot;
			this.cancelBtn.addEventListener(UIEvent.ACTIVATE, cancelBtn_Activated);
			this.AddComponent(this.cancelBtn);
		}
		
		private function deleteBtn_Activated(evn:UIEvent) : * {
			if (Shared.F4SEPlugin) {
				if (!Shared.F4SEPlugin.DeleteSlot(this._slotName)) {
					var errTitle = "_$CoordiSaverMenuErrorTitle";
					if (Shared.Localizations.$CoordiSaverMenuErrorTitle)
						errTitle = Shared.Localizations.$CoordiSaverMenuErrorTitle;
					var errMessage = "_$CoordiSaverMenuErrorDeleteSlot";
					if (Shared.Localizations.$CoordiSaverMenuErrorDeleteSlot)
						errMessage = Shared.Localizations.$CoordiSaverMenuErrorDeleteSlot;
					Shared.ShowMessageBox(errTitle, errMessage);
					
					return;
				}
				
				Shared.CloseView(0, false);
					
				var mainView = new MainView();
				Shared.ShowView(mainView);
			}
		}
		
		private function cancelBtn_Activated(evn:UIEvent) : * {
			Shared.CloseView(1, true);
		}
	}
}