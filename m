From: Greg KH <greg@kroah.com>
Subject: Re: ark3116: receive returns negative
Date: Thu, 17 May 2007 07:58:49 -0700
Message-ID: <20070517145849.GA3282@kroah.com>
References: <Pine.LNX.4.61.0705161743250.9570@yvahk01.tjqt.qr>
	<20070517124525.GC20055@kroah.com>
	<Pine.LNX.4.61.0705171529570.3231@yvahk01.tjqt.qr>
	<Pine.LNX.4.61.0705171646130.3231@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0705171646130.3231@yvahk01.tjqt.qr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: ark3116_driver@auctionant.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-serial@vger.kernel.org

On Thu, May 17, 2007 at 04:51:09PM +0200, Jan Engelhardt wrote:
> 
> On May 17 2007 16:10, Jan Engelhardt wrote:
> >Hi Greg,
> >
> >>But does the driver seem to work properly?
> >>Do you get data through the device properly?
> 
> I have taken a voltmeter and an appropriate testcase program - and yes,
> at least transmit works.
> 
> >USB-RS232-GenderChanger-RS232-USB.
> 
> A faulty setup that is. My bad.

You forgot the NULL modem inverter :)

thanks,

greg k-h

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
