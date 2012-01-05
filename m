From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB disconnect -> kernel panic
Date: Wed, 4 Jan 2012 16:11:22 -0800
Message-ID: <20120105001122.GA9974@kroah.com>
References: <87mxahk3d1.fsf@gag.com>
 <20120102182255.GC8562@xanatos>
 <20120103235847.GF21311@kroah.com>
 <87fwfwmaeo.fsf@gag.com>
 <20120104230149.GA16655@kroah.com>
 <20120104232659.05da01ee@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120104232659.05da01ee-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Bdale Garbee <bdale-wvU4uTqWWAI@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Oliver Neukum <oliver-Q6YOFhsQ4GZ7tPAFqOLdPg@public.gmane.org>, keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 04, 2012 at 11:26:59PM +0000, Alan Cox wrote:
> > Ok, can you try the patch below and let me know if it solves the problem
> > or not?
> 
> If it does the right fix is to stop clearing tty->driver_data. If
> tty->driver_data can go NULL outside of the final release then its
> probably an exploitable hole.

So in acm_tty_close() we shouldn't set driver_data to NULL after we
unregister the device?

Ah, that should happen in tty_operations->cleanup()?  It seems that
cdc_acm.c doesn't have that function, which is causing this problem now,
right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
