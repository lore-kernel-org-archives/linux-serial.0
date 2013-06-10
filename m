From: Greg KH <greg@kroah.com>
Subject: Re: Connection to a 3G USB Module using USB-Serial
Date: Mon, 10 Jun 2013 10:23:37 -0700
Message-ID: <20130610172337.GA1934@kroah.com>
References: <CA+y4WrSC0Z5hFodTDNL0KGu2_pZtu3WB98re-yQJOsFCo21nRw@mail.gmail.com>
 <20130608182232.GB5918@kroah.com>
 <CA+y4WrRcrnYNHsFEZ2aTPGyPB1e9z508wzMp0Cf3-kxXPoNEBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46685 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485Ab3FJRXF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Jun 2013 13:23:05 -0400
Content-Disposition: inline
In-Reply-To: <CA+y4WrRcrnYNHsFEZ2aTPGyPB1e9z508wzMp0Cf3-kxXPoNEBg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Fumi <ffumi68@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, Jun 10, 2013 at 03:58:38PM +0200, Fabio Fumi wrote:
> Thanks Greg for taking som etime to answer.
> 
> My kernel is an old 2.6.35.7 and migrating it entirely to 3+ one is a
> real mess (given the number of platfomr customization it includes).

Ick, really old obsolete kernels like that one are not good for trying
to run new hardware with.  I suggest contacting the company that is
forcing you to stick with that version, and getting support from them to
do the needed backporting of this driver.

> So probably the best is to try back-porting the ZTE usb-serial
> driver...  I guess. Is it "drivers/usb/serial/zte_ev.c" what you're
> referring to?  My device is a ZTE MF-210... does the same driver
> really apply for this device too?

I think it does, what is the device/vendor id of it?

> Does the same driver rely on some kernel 3.x-only features?

Yes, all drivers are tied tightly to the specific kernel version they
are released with.

> I can always give it a *blind* try, of course... but better knowing in
> advance, if it won't work.

You can try to backport it, it shouldn't be that hard, but your really
going to be on your own here, sorry.

best of luck,

greg k-h
