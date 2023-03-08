package  {
	import UIComponent.View;
	import UIComponent.TextInput;
	import UIComponent.Button;
	import UIComponent.UIEvent;
	
	public class AddSlotView extends View {		
		private var _menuWidth:uint = 400;
		private var _menuHeight:uint = 160;

		private var slotNameInput:TextInput;
		private var addSlotBtn:Button;

		public function AddSlotView() {
			var titleText = "_$CoordiSaverMenuAddSlotTitle";
			if (Shared.Localizations.$CoordiSaverMenuAddSlotTitle)
				titleText = Shared.Localizations.$CoordiSaverMenuAddSlotTitle;

        	super(this._menuWidth, this._menuHeight, titleText);
		}
		
		protected override function InitializeView() : void {
			super.InitializeView();
			
			this.slotNameInput = new TextInput(this._menuWidth - 20, 40, 30);
			this.slotNameInput.x = 10;
			this.slotNameInput.y = 70;
			this.AddComponent(this.slotNameInput);
						
			this.addSlotBtn = new Button(this._menuWidth - 20, 30);
			this.addSlotBtn.x = 10;
			this.addSlotBtn.y = 120;
			this.addSlotBtn.text = "_$CoordiSaverMenuAddSlotButton";
			if (Shared.Localizations.$CoordiSaverMenuAddSlotButton)
				this.addSlotBtn.text = Shared.Localizations.$CoordiSaverMenuAddSlotButton;
			this.addSlotBtn.addEventListener(UIEvent.ACTIVATE, addSlotBtn_Activated);
			this.AddComponent(this.addSlotBtn);
		}
		
		private function addSlotBtn_Activated(evn:UIEvent) : * {
			var errTitle = "_$CoordiSaverMenuErrorTitle";
			if (Shared.Localizations.$CoordiSaverMenuErrorTitle)
				errTitle = Shared.Localizations.$CoordiSaverMenuErrorTitle;
			var errMessage:String;
			
			var slotName:String = this.slotNameInput.text.replace(/^\s+|\s+$/g, '');
			if (slotName.length == 0) {
				errMessage = "_$CoordiSaverMenuErrorEmptySlotName";
				if (Shared.Localizations.$CoordiSaverMenuErrorEmptySlotName)
					errMessage = Shared.Localizations.$CoordiSaverMenuErrorEmptySlotName;
				Shared.ShowMessageBox(errTitle, errMessage);
				return;
			}
			
			var invalidChars:String = "<>:\"/\\|?*";
			for (var ii = 0; ii < invalidChars.length; ii++) {
				if (slotName.indexOf(invalidChars.charAt(ii)) >= 0) {
					errMessage = "_$CoordiSaverMenuErrorInvalidSlotName";
					if (Shared.Localizations.$CoordiSaverMenuErrorInvalidSlotName)
						errMessage = Shared.Localizations.$CoordiSaverMenuErrorInvalidSlotName;
					Shared.ShowMessageBox(errTitle, errMessage);
					return;
				}
			}

			if (Shared.F4SEPlugin) {
				if (Shared.F4SEPlugin.AddSlot(slotName)) {
					Shared.CloseView(0, false);
					
					var mainView = new MainView();
					Shared.ShowView(mainView);
				}
				else {
					errMessage = "_$CoordiSaverMenuErrorSaveSlot";
					if (Shared.Localizations.$CoordiSaverMenuErrorSaveSlot)
						errMessage = Shared.Localizations.$CoordiSaverMenuErrorSaveSlot;
					Shared.ShowMessageBox(errTitle, errMessage);
				}
			}

		}
	}
}