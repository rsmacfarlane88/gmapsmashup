package custom.Route
{
	
	/**
	 * PolylineEncoder
	 * @author Duncan Hall
	 */
	
	import com.google.maps.LatLng;
	import com.google.maps.interfaces.IPolyline;
	
	public class PolylineEncoder 
	{
		
		
		public function PolylineEncoder(){
			
		}
		
		/**
		 * Converts a list of level values into a single encoded string
		 * 
		 * @param levels	The list of uint level values to encode.
		 * @return			The encoded levels.
		 */
		public function encodeLevels (levels:Array) : String
		{
			var encoded:String = "";
			for each (var level:uint in levels) encoded += encodeUnsigned(level);
			return encoded;
		}
		
		
		
		
		/**
		 * Takes a list of <code>com.google.maps.LatLng</code> points and encodes
		 * them into a single string, for use with the <code>Polyline.fromEncoded()</code>
		 * method.
		 * 
		 * @param points	The list of points to encode.
		 * @return			The encoded string representation.
		 */
		public function fromPoints(points:Array) : String
		{
			var encoded:String = "";
			var pLat:Number = 0;
			var pLng:Number = 0;
			var dLat:Number;
			var dLng:Number;
			var lat_e5:Number;
			var lng_e5:Number;
			
			for each(var point:LatLng in points) 
			{
				lat_e5 = Math.round(point.lat() * 1e5);
				lng_e5 = Math.round(point.lng() * 1e5);
				dLat = lat_e5 - pLat;
				dLng = lng_e5 - pLng;
				pLat = lat_e5;
				pLng = lng_e5;
				
				encoded += encodeSigned(dLat);
				encoded += encodeSigned(dLng);
			}
			
			return encoded;
		}
		
		
		
		
		/**
		 * Converts a <code>com.google.maps.interfaces.IPolyline</code> object
		 * into an encoded string representation for use with the 
		 * <code>Polyline.fromEncoded()</code> method.
		 * 
		 * @param vertices		The IPolyline object containing the points to encode.
		 * return				The encoded string representation.
		 */
		public function fromPolyline(vertices:IPolyline) : String
		{
			var numVertices:int = vertices.getVertexCount();
			var points:Array = new Array;
			for (var i:int = 0; i < numVertices; i++) points.push(vertices.getVertex(i));
			return fromPoints(points);
		}
		
		
		
		
		/**
		 *
		 */
		private function encodeSigned(value:Number) : String
		{
			var leftShift:Number = value << 1;
			return(encodeUnsigned(value < 0 ? ~leftShift : leftShift));
		}
		
		
		
		/**
		 *
		 */
		private function encodeUnsigned(value:Number) : String
		{
			var encodeString:String = "";
			while (value >= 0x20) 
			{
				encodeString += String.fromCharCode((0x20 | (value & 0x1F)) + 63);
				value >>= 5;
			}
			encodeString += String.fromCharCode(value + 63);
			return encodeString;
		}

		
	}
}
