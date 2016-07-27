From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Wed, 27 Jul 2016 09:33:48 -0400
Message-ID: <20160727133348.GB20032@thunk.org>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
 <20160725174712.GA5752@kroah.com>
 <b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
 <20160726150856.GA15676@kroah.com>
 <b383129f-b20b-32e3-41d1-e2c4a68665a2@suse.de>
 <20160727130923.4c20524b@lxorguk.ukuu.org.uk>
 <2b140616-c210-e754-a854-cd6a5675277d@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2b140616-c210-e754-a854-cd6a5675277d@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <mstaudt@suse.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 27, 2016 at 02:14:24PM +0200, Max Staudt wrote:
> > If you set the IRQ to 0 it should poll anyway (0 means 'no IRQ') so I
> > don't think the option is needed. At least it seems sufficient to get me
> > by when I meet buggy PC BIOSes and the like
> 
> That's exactly what the patch does - but if there is already a way to set the
> IRQ to 0, I would of course prefer to use that.
> 
> It seems I haven't found the trick you're using - could you please tell me how
> you set the IRQ to 0?  I can't change it in the BIOS, so I have to do it at
> the kernel level at the latest.

So the problem is that you can't use setserial because you want to use
this port for your console?  And so you don't want to set it in an initscript?

The one thing which is really unfortunate with this patch is that it's
a global, so it forces polling for *all* serial ports.  And it may be
that it's only base ports on the motherboard which needs this hack.

I wonder if it would just be simpler to make it be a CONFIG option
which causes the irq value to zero in arch/x86/include/asm/serial.h?

					- Ted
