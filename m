From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: serial device name for smart card reader that is integrated to
 Anysee DVB USB device
Date: Tue, 4 Oct 2011 21:59:17 -0700
Message-ID: <20111005045917.GB4700@kroah.com>
References: <4E8B7901.2050700@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E8B7901.2050700-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn-yOkvZcmFvRU@public.gmane.org>, James Courtier-Dutton <james.dutton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, HoP <jpetrous-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Istv=E1n_V=E1radi?= <ivaradi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 05, 2011 at 12:22:09AM +0300, Antti Palosaari wrote:
> I have been looking for correct device name for serial smart card
> reader that is integrated to Anysee DVB USB devices. Consider it
> like old so called Phoenix reader. Phoenix is de facto protocol used
> for such readers and there is whole bunch of different RS232
> (/dev/ttyS#) or USB-serial (/dev/ttyUSB#) readers using that
> protocol.
> 
> Anyhow, that one is integrated to DVB USB device that is driven by
> dvb_usb_anysee driver. As I understand, I need reserve new device
> name and major number for my device. See Documentation/devices.txt

Why not just use the usb-serial core and then you get a ttyUSB* device
node "for free"?  It also should provide a lot of the basic tty
infrastructure and ring buffer logic all ready to use.

thanks,

greg k-h



> 
> Current proof-of-concept driver can be found from:
> http://git.linuxtv.org/anttip/media_tree.git/shortlog/refs/heads/anysee-sc
> Don't review code since it is not ready for release yet, it even
> lacks locking.
> 
> There have been some proposes about names, mainly whether to
> register it under the DVB adapter it is physically
> (/dev/dvb/adapterN/sc#) or to the root of /dev (/dev/sc#). I used sc
> as name, SC=SmartCard.
> 
> Could someone who have enough knowledge point out which one is
> correct or better?
> 
> 
> regards
> Antti
> 
> -- 
> http://palosaari.fi/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
