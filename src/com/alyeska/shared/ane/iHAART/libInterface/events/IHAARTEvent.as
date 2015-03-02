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

package com.alyeska.shared.ane.iHAART.libInterface.events
{

	import flash.events.Event;

	public class IHAARTEvent extends Event
	{
		public var message:String;
		public var errorCode:String;
		public var statusCode:String;

		static public const LOGIN_SUCCESSFUL:String = "IHAARTEvent.LOGIN_SUCCESSFUL";
		static public const ERROR:String = "IHAARTEvent.ERROR";
		static public const RECOVERABLE_ERROR:String = "IHAARTEvent.RECOVERABLE_ERROR";


		/**
		 * Constructor.
		 *
		 * @param type Event type.
		 * @param message The message returned from jar.
		 * @param bubbles Whether or not the event bubbles.
		 * @param cancelable Whether or not the event is cancelable.
		 */
		public function IHAARTEvent(type:String, message:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);

			switch (type)
			{
				case LOGIN_SUCCESSFUL :
					this.message = message;
					break;
				case RECOVERABLE_ERROR :
					this.errorCode = message;
					break;
				default :
					break;
			}
		}
	}
}
