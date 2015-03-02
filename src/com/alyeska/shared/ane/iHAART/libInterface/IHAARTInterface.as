/*
 * Copyright 2014 Bree Alyeska.
 *
 * This file is part of the IHAART Library, developed in conjunction with and distributed with iHAART/CollaboRhythm.
 *
 * iHAART and CollaboRhythm are free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * iHAART and CollaboRhythm are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with iHAART and CollaboRhythm. If not, see
 * <http://www.gnu.org/licenses/>.
 */

package com.alyeska.shared.ane.iHAART.libInterface
{
	import com.alyeska.shared.ane.iHAART.libInterface.events.IHAARTEvent;

	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class IHAARTInterface extends EventDispatcher
	{

		private var _context:ExtensionContext;

		static public const NO_MESSAGE:String = "false";

		static public const LOGGED_IN:String = "true";
		static public const NOT_LOGGED_IN:String = "false";
		static public const LOGIN_SUCCESSFUL:String = "loginSuccessful";
		static public const ERROR:String = "error";
		static public const RECOVERABLE_ERROR:String = "recoverableError";

		public function IHAARTInterface()
		{
			super();

			// First parameter is native extension package id defined in extension.xml, second parameter is behavior
			_context = ExtensionContext.createExtensionContext("com.alyeska.shared.ane.IHAARTExt", "");
			if (!_context)
			{
				throw new Error("Volume native extension is not supported on this platform.");
			}
			_context.addEventListener(StatusEvent.STATUS, handleStatus);
		}

//		mapped
		public function showProgress():String
		{
			return String(_context.call("showProgress"));
		}

//		mapped
		public function startPasscodeActivity():String
		{
			var result:String = String(_context.call("startPasscodeActivity"));
			return result;
		}

//		mapped
		public function startClockActivity(medicationJSON:String):String
		{
			var result:String = String(_context.call("startClockActivity", medicationJSON));
			return result;
		}

//		mapped
		public function testStuff():String
		{
			return String(_context.call("testStuff"));
		}

//		mapped
		public function initIHAART():Boolean
		{
			init();
			return true;
		}

		private function handleStatus(e:StatusEvent):void
		{

			switch (e.code)
			{
				case LOGIN_SUCCESSFUL :
					dispatchEvent(new IHAARTEvent(IHAARTEvent.LOGIN_SUCCESSFUL, LOGGED_IN, false, false));
					break;
				case RECOVERABLE_ERROR :
					dispatchEvent(new IHAARTEvent(IHAARTEvent.RECOVERABLE_ERROR, e.level, false, false));
					break;
				default :
					dispatchEvent(new IHAARTEvent(IHAARTEvent.ERROR, e.level, false, false));
					// statements
					break;
			}
		}

		public function dispose():void
		{
			_context.dispose();
		}

		private function init():void
		{
			_context.call("initUtilities");
		}
	}
}
