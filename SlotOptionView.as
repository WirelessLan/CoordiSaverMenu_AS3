package {
	import UIComponent.View;
	import UIComponent.Button;
	import UIComponent.UIEvent;

	public class SlotOptionView extends View {		
		private var _menuWidth:uint = 600;
		private var _menuHeight:uint = 150;
		
		private var _slotName:String;
		
		private var loadSlotBtn:Button;
		private var deleteSlotBtn:Button;
		
		public function SlotOptionView(slotName:String) {
			var titleText = "_$CoordiSaverMenuSlotOptionTitle";
			if (Shared.Localizations.$CoordiSaverMenuSlotOptionTitle)
				titleText = Shared.Localizations.$CoordiSaverMenuSlotOptionTitle;
			titleText += " : " + slotName;

			this._slotName = slotName;

        	super(this._menuWidth, this._menuHeight, titleText);
		}
		
		protected override function InitializeView() : void {
			super.InitializeView();
			
			this.loadSlotBtn = new Button(this._menuWidth - 20, 30);
			this.loadSlotBtn.x = 10;
			this.loadSlotBtn.y = 65;
			this.loadSlotBtn.text = "_$CoordiSaverMenuLoadSlot";
			if (Shared.Localizations.$CoordiSaverMenuLoadSlot)
				this.loadSlotBtn.text = Shared.Localizations.$CoordiSaverMenuLoadSlot;
			this.loadSlotBtn.addEventListener(UIEvent.ACTIVATE, loadSlotBtn_Activated);
			this.AddComponent(this.loadSlotBtn);
			
			this.deleteSlotBtn = new Button(this._menuWidth - 20, 30);
			this.deleteSlotBtn.x = 10;
			this.deleteSlotBtn.y = 105;
			this.deleteSlotBtn.text = "_$CoordiSaverMenuDeleteSlot";
			if (Shared.Localizations.$CoordiSaverMenuDeleteSlot)
				this.deleteSlotBtn.text = Shared.Localizations.$CoordiSaverMenuDeleteSlot;
			this.deleteSlotBtn.addEventListener(UIEvent.ACTIVATE, deleteSlotBtn_Activated);
			this.AddComponent(this.deleteSlotBtn);
		}
		
		private function loadSlotBtn_Activated(evn:UIEvent) : * {
			if (Shared.F4SEObject)
				Shared.F4SEObject.CallGlobalFunctionNoWait("CoordiSaver", "LoadSlot", this._slotName);
		}
		
		private function deleteSlotBtn_Activated(evn:UIEvent) : * {
			var deleteSlotView = new DeleteSlotView(this._slotName);
			Shared.ShowView(deleteSlotView);
		}
	}
}