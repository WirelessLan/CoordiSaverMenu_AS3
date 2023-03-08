package  {
	import UIComponent.View;
	import UIComponent.ListBox;
	import UIComponent.Button;
	import UIComponent.UIEvent;
	
	public class MainView extends View {		
		private var _menuWidth:uint = 300;
		private var _menuHeight:uint = 620;

		private var _slotArr:Array;
	
		private var slotListBox:ListBox;
		private var addBtn:Button;

		public function MainView() {
			var titleText = "_$CoordiSaverMenuTitle";
			if (Shared.Localizations.$CoordiSaverMenuTitle)
				titleText = Shared.Localizations.$CoordiSaverMenuTitle;
				
			super(this._menuWidth, this._menuHeight, titleText);
			
			this._slotArr = GetSlotList();
			this.slotListBox.SetItems(this._slotArr);
		}
		
		public function GetSlotList() : Array {
			if (Shared.F4SEPlugin)
				return Shared.F4SEPlugin.GetSlotList();
			else {
				var retArr:Array = new Array();
				for (var ii = 0; ii < 20; ii++)
					retArr.push(ii);
				return retArr;
			}
		}

		protected override function InitializeView() : void {
			super.InitializeView();
			
			this.slotListBox = new ListBox(this._menuWidth - 20, this._menuHeight - 116);
			this.slotListBox.x = 10;
			this.slotListBox.y = 66;
			this.slotListBox.addEventListener(UIEvent.ACTIVATE, slotListBox_Activated);
			this.AddComponent(this.slotListBox);
			
			this.addBtn = new Button(this._menuWidth - 20, 32);
			this.addBtn.x = 10;
			this.addBtn.y = this.slotListBox.y + this.slotListBox.height + 5;
			this.addBtn.text = "_$CoordiSaverMenuAddSlot";
			if (Shared.Localizations.$CoordiSaverMenuAddSlot)
				this.addBtn.text = Shared.Localizations.$CoordiSaverMenuAddSlot;
			this.addBtn.addEventListener(UIEvent.ACTIVATE, addBtn_Acitivated);
			this.AddComponent(this.addBtn);
		}
		
		private function slotListBox_Activated(evn:UIEvent) : * {
			if (!this.slotListBox.SelectedItem)
				return;
				
			var slotOptionView = new SlotOptionView(this.slotListBox.SelectedItem);
			Shared.ShowView(slotOptionView);
		}
		
		private function addBtn_Acitivated(evn:UIEvent) : * {
			var addSLotView = new AddSlotView();
			Shared.ShowView(addSLotView);
		}
	}
}