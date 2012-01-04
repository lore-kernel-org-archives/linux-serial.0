From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: USB disconnect -> kernel panic
Date: Wed, 4 Jan 2012 10:01:57 +0100
Message-ID: <201201041001.57080.oneukum@suse.de>
References: <87mxahk3d1.fsf@gag.com> <20120102182255.GC8562@xanatos> <20120103235847.GF21311@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120103235847.GF21311-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Oliver Neukum <oliver-Q6YOFhsQ4GZ7tPAFqOLdPg@public.gmane.org>, Bdale Garbee <bdale-wvU4uTqWWAI@public.gmane.org>, keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Am Mittwoch, 4. Januar 2012, 00:58:47 schrieb Greg KH:
> On Mon, Jan 02, 2012 at 10:22:55AM -0800, Sarah Sharp wrote:
> > On Sat, Dec 24, 2011 at 03:32:26PM -0700, Bdale Garbee wrote:
> > > Hi Sarah!  Merry Christmas!
> > > 
> > > I've been working on another production run of Altus Metrum products
> > > today, and in the process of flashing and calibrating a pile of our
> > > TeleDongle units, I've been seeing sporadic kernel panics when
> > > unplugging them from my notebook USB.  Has now happened three times this
> > > morning. 
> > > 
> > > I'm running 3.1.6 now, but I saw this under 3.1.5 too, at least once.
> > > The notebook is an HP 2540p.
> > > 
> > > Keith suggested I send you the attached photo of my screen showing the
> > > panic info. 
> > 
> > It's somewhere in the tty layer, and doesn't look USB related.  I think
> > Greg KH is the tty maintainer right now, so you might want to ask him.
> 
> We've had some cdc_acm driver problems in the past, but I thought they
> were all resolved.  3.1.3 should have fixed those problems.  We have
> some more cleanups queued up for 3.3, but nothing that should be fixing
> something like this.
> 
> Oliver, any thoughts about this (see the original post on linux-usb for
> the crash dump.)

Do you have a pointer? I assumed this to be this issue:
http://www.spinics.net/lists/linux-usb/msg55779.html
And I am waiting for the announced patch.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
