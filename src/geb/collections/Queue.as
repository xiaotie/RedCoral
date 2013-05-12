/**
 * @author xiaotie@geblab.com 
 */

package geb.collections
{

	public class Queue
	{
		private var m_cache:Array;

		public function Queue()
		{
			clear();
		}

		/**
		 * Clears the queue.<br><br>
		 */
		public function clear():void
		{
			m_cache=new Array();
		}

		/**
		 * Adds the specified element to the queue.<br><br>
		 * @param o Element to add to the queue.
		 */
		public function enqueue(o:Object):void
		{
			m_cache.push(o);
		}

		/**
		 * Removes and returns the first element added into the queue.<br><br>
		 * @return Object.
		 */
		public function dequeue():Object
		{
			return m_cache.shift();
		}

		/**
		 * Checks if the queue is empty.<br><br>
		 * @return Boolean.
		 */
		public function isEmpty():Boolean
		{
			return m_cache.length == 0;
		}

		/**
		 * Returns the first element added into the queue.<br><br>
		 * @return Object.
		 */
		public function peek():Object
		{
			return m_cache[0];
		}

		/**
		 * Returns the number of elements in this collection.
		 * @return the number of elements in this collection.
		 */
		public function size():Number
		{
			return m_cache.length;
		}

		/**
		 *
		 */
		public function destroy():void
		{
		}
	}
}