From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB disconnect -> kernel panic
Date: Tue, 3 Jan 2012 15:58:47 -0800
Message-ID: <20120103235847.GF21311@kroah.com>
References: <87mxahk3d1.fsf@gag.com>
 <20120102182255.GC8562@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120102182255.GC8562@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Oliver Neukum <oliver-Q6YOFhsQ4GZ7tPAFqOLdPg@public.gmane.org>
Cc: Bdale Garbee <bdale-wvU4uTqWWAI@public.gmane.org>, keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 02, 2012 at 10:22:55AM -0800, Sarah Sharp wrote:
> On Sat, Dec 24, 2011 at 03:32:26PM -0700, Bdale Garbee wrote:
> > Hi Sarah!  Merry Christmas!
> > 
> > I've been working on another production run of Altus Metrum products
> > today, and in the process of flashing and calibrating a pile of our
> > TeleDongle units, I've been seeing sporadic kernel panics when
> > unplugging them from my notebook USB.  Has now happened three times this
> > morning. 
> > 
> > I'm running 3.1.6 now, but I saw this under 3.1.5 too, at least once.
> > The notebook is an HP 2540p.
> > 
> > Keith suggested I send you the attached photo of my screen showing the
> > panic info. 
> 
> It's somewhere in the tty layer, and doesn't look USB related.  I think
> Greg KH is the tty maintainer right now, so you might want to ask him.

We've had some cdc_acm driver problems in the past, but I thought they
were all resolved.  3.1.3 should have fixed those problems.  We have
some more cleanups queued up for 3.3, but nothing that should be fixing
something like this.

Oliver, any thoughts about this (see the original post on linux-usb for
the crash dump.)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
