From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Tue, 26 Jul 2016 08:08:56 -0700
Message-ID: <20160726150856.GA15676@kroah.com>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
 <20160725174712.GA5752@kroah.com>
 <b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <mstaudt@suse.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 26, 2016 at 01:42:13PM +0200, Max Staudt wrote:
> On 07/25/2016 07:47 PM, Greg KH wrote:
> > On Mon, Jul 25, 2016 at 07:36:15PM +0200, Max Staudt wrote:
> >> Some serial ports may not emit IRQs properly, or there may be a defect
> >> in their routing on the motherboard.
> >>
> >> This patch allows these ports to be used anyway (or until a better
> >> workaround is known for a specific platform), though with no guarantees.
> >>
> >> If you have such a buggy UART, boot Linux with 8250.force_polling=1 .
> > 
> > Ick, don't add new module parameters if at all possible.
> 
> I agree, I'd rather not add a parameter either, but...
> 
> - It's a hardware issue
> - It needs to be handled at boot time

Why?

> - It can't be auto-detected (AFAIK)

Why not?  Can't you have a quirk for this specific, broken, device?

> The idea is that this parameter allows for a workaround until someone comes
> up with a workaround or autodetection (if ever). And it can be used to
> debug future buggy hardware.

module paramters are horrid, they don't scale (which uart is this for?),
and no one ever changes them.

> >> It is essentially the kernel level version of:
> >>
> >>   setserial /dev/ttySn irq 0
> > 
> > Why can't you just do this instead?
> 
> Because it's too late by the time we reach userspace.
> 
> In case of "console=ttyS0" the decision to use polling needs to happen before
> ttyS0 is opened from userspace, as the system will otherwise hang for up to
> 30 seconds at a time. Input is mostly dropped, thus I can't even use BREAK+B
> to force reboot it.
> 
> As it stands now, I can't even boot the system with "rdinit=/bin/bash".
> The force_polling option makes the system somewhat usable, albeit the serial
> output is very slow.
> 
> Curiously, the kernel's printk() is as fast as it should be. It's just
> userspace that is slow. Any idea why that is the case?

Ah, then something else might be wrong here, I suggest you track this
down please.

thanks,

greg k-h
