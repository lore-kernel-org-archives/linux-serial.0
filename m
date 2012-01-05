From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB disconnect -> kernel panic
Date: Thu, 5 Jan 2012 12:04:37 -0800
Message-ID: <20120105200437.GA29154@kroah.com>
References: <87mxahk3d1.fsf@gag.com>
 <20120102182255.GC8562@xanatos>
 <20120103235847.GF21311@kroah.com>
 <87fwfwmaeo.fsf@gag.com>
 <20120104230149.GA16655@kroah.com>
 <87mxa2ww0f.fsf@gag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87mxa2ww0f.fsf-wvU4uTqWWAI@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bdale Garbee <bdale-wvU4uTqWWAI@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Oliver Neukum <oliver-Q6YOFhsQ4GZ7tPAFqOLdPg@public.gmane.org>, keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 04, 2012 at 10:36:48PM -0700, Bdale Garbee wrote:
> On Wed, 4 Jan 2012 15:01:49 -0800, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > Ok, can you try the patch below and let me know if it solves the problem
> > or not?
> 
> It's hard to prove a negative, but after applying the patch to 3.2.0-rc7
> and running with it for a while doing frequent power cycles on our
> devices attached via USB, abruptly disconnecting USB during active
> serial connections, etc .. I haven't seen the panic again.
> 
> Will report if it happens again with the patch in place, but so far so good.

Thanks, I'll queue this up then, and work to solve this in the "correct"
way in a week or so.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
