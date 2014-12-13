From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: ch341.c does not work with new ch34x devices
Date: Sat, 13 Dec 2014 08:23:39 -0500
Message-ID: <20141213132339.GA21462@kroah.com>
References: <CAJ23o9j48MmoFuiveWs=kdLnfPu9GZgGD4Ep2VJo6Y0KVx+33g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ23o9j48MmoFuiveWs=kdLnfPu9GZgGD4Ep2VJo6Y0KVx+33g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liangent <liangent-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sat, Dec 13, 2014 at 01:15:07PM +0800, Liangent wrote:
> Hello,
> 
> I bought a new USB-RS232 cable and the system loads ch341.ko for me
> (Debian with kernel 3.14-2-amd64 and 3.16.0-4-amd64). However this
> module does not work with my cable (/dev/ttyUSB0 appears but the
> serial device doesn't work properly) while the driver provided by chip
> vendor[1] works (this driver doesn't compile on kernel 3.16 anymore
> but 3.14 is fine).
> 
> This is dmesg output with the vendor-provided driver.
> 
> [ 1900.070021] usb 2-1.4: new full-speed USB device number 5 using ehci-pci
> [ 1900.163218] usb 2-1.4: New USB device found, idVendor=1a86, idProduct=7523
> [ 1900.163227] usb 2-1.4: New USB device strings: Mfr=0, Product=2,
> SerialNumber=0
> [ 1900.163232] usb 2-1.4: Product: USB2.0-Ser!
> [ 1900.163887] ch34x 2-1.4:1.0: ch34x converter detected
> [ 1900.165052] usb 2-1.4: ch34x converter now attached to ttyUSB0
> 
> For the record I've used an old cable which works fine with the
> built-in ch341.ko driver, but unfortunately that cable is not in my
> hand anymore.
> 
> [1] http://wch.cn/downloads.php?name=pro&proid=177

That device should "just work" with the in-kernel driver.  The fact that
it is autoloaded is a good sign something is right.

So no data flows through the device at all when using it, or are there
other symptoms of "not working"?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
