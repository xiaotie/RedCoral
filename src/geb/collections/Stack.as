/**
 * @author xiaotie@geblab.com 
 */

package geb.collections
{
	public class Stack
	{
		/**
		 * The internal array of the collection.
		 */
		private var m_cache:Array;

		/**
		 * Creates a new SimpleStack instance.
		 * @param ar an array to fill the Stack
		 */
		public function Stack(ar:Array=null)
		{
			if (ar == null)
			{
				m_cache=new Array();
			}
			else
			{
				m_cache=ar;
			}
		}

		/**
		 * Looks at the object at the top of this stack without removing it from the stack.
		 */
		public function peek():Object
		{
			return m_cache[m_cache.length - 1];
		}

		/**
		 * Removes the object at the top of this stack and returns that object as the value of this function.
		 * @return the removed object value.
		 */
		public function pop():Object
		{
			return isEmpty() ? null : m_cache.pop();
		}
		
		public function get head():Object
		{
			return isEmpty() ? null : m_cache[m_cache.length-1];
		}

		/**
		 * Pushes an item into the top of this stack.
		 */
		public function push(o:Object):void
		{
			m_cache.push(o);
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
		 * Returns the array representation of all the elements of this Stack.
		 * @return the array representation of all the elements of this Stack.
		 */
		public function toArray():Array
		{
			var aReverse:Array=m_cache.slice();
			aReverse.reverse();
			return aReverse;
		}

		/**
		 * Removes all of the elements from this collection (optional operation).
		 */
		public function clear():void
		{
			m_cache.splice(0);
		}
		
		/**
		 * Returns {@code true} if this collection contains no elements.
		 * @return {@code true} if this collection contains no elements.
		 */
		public function isEmpty():Boolean
		{
			return m_cache.length == 0;
		}

		/**
		 * Returns the number of elements in this collection.
		 * @return the number of elements in this collection.
		 */
		public function size():Number
		{
			return m_cache.length;
		}

	}
}