package  {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.text.Font;
	
	import F4SE.ICodeObject;
	
	public class CoordiSaverMenu extends MovieClip implements ICodeObject {
		private var debugMode:Boolean = false;

		public function CoordiSaverMenu() {
        	super();

			Shared.Root = this;

			if (debugMode) {
				Shared.Localizations = new Object();
			
				var font_urlRequest:URLRequest = new URLRequest();
				font_urlRequest.url = "fonts_en.swf";
				
				var font_loader:Loader = new Loader();
				font_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
				font_loader.load(font_urlRequest);
			}
		}

		public function onF4SEObjCreated(codeObject:*) : void {
			Shared.F4SEObject = codeObject;
         	Shared.F4SEPlugin = codeObject.plugins.CoordiSaver;

			var initData = Shared.F4SEPlugin.GetInitializationData();
			if (!initData || !initData.Language || !initData.Localizations) {
				Shared.F4SEPlugin.Throw("No initialization data");
				return;
			}

			Shared.Localizations = initData.Localizations;
			
			var font_urlRequest:URLRequest = new URLRequest();
			font_urlRequest.url = "fonts_" + initData.Language + ".swf";
			
			var font_loader:Loader = new Loader();
			font_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			font_loader.load(font_urlRequest);
		}
		
		private function onLoadComplete(e:Event):void {
			var mainFontClass:Class = e.target.applicationDomain.getDefinition("$MAIN_Font") as Class;
			var mainFontBoldClass:Class = e.target.applicationDomain.getDefinition("$MAIN_Font_Bold") as Class;
			
			Font.registerFont(mainFontClass);
			Font.registerFont(mainFontBoldClass);
			
			Shared.MainFont = new mainFontClass;
			Shared.MainFontBold = new mainFontBoldClass;
			
			if (Shared.F4SEPlugin)
				Shared.F4SEPlugin.InitializationComplete();
			else
				ShowMenu();
		}

		public function ProcessKeyEvent(keyCode:uint, isDown:Boolean) : void {
			if (!Shared.ShouldHandleKey(keyCode, isDown))
				return;
			
			if (keyCode == Keyboard.TAB) {
				Shared.CloseView(1, true);
			}
			else {
				if (Shared.CurrentView)
					Shared.CurrentView.ProcessKeyEvent(keyCode);
			}
		}
		
		public function ShowMenu() : void {
			var mainView = new MainView();
			Shared.ShowView(mainView);
		}
	}
}