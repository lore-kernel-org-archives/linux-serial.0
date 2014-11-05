From: Johan Hovold <johan@kernel.org>
Subject: Re: usbserial / ftdi_sio (+ others) bug?
Date: Wed, 5 Nov 2014 10:58:39 +0100
Message-ID: <20141105095839.GO31358@localhost>
References: <CAHdUje_wc+-SwUTDsNHg8HkD2ynJDtOE18VXe5616UpFYyAU0Q@mail.gmail.com>
 <20141029085128.GC7841@localhost>
 <20141103234609.03842d21@sauron>
 <20141104081449.GI31358@localhost>
 <20141104202913.4b0d6cd2@sauron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:50054 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaKEKBv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 05:01:51 -0500
Content-Disposition: inline
In-Reply-To: <20141104202913.4b0d6cd2@sauron>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janne Huttunen <jahuttun@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org

On Tue, Nov 04, 2014 at 08:29:13PM +0200, Janne Huttunen wrote:
> On Tue, 4 Nov 2014 09:14:49 +0100
> Johan Hovold <johan@kernel.org> wrote:
> > > 2. The chip responds with single correct character followed by a few
> > >    hundred or so replies containing only the overrun status (no
> > > data) which are then converted to a bunch of binary zeroes by the
> > > ldisc because of the bug I mentioned earlier. After that the chip
> > > starts responding with proper data again and works until closed.
> > 
> > Note that the only "bug" is that the application cannot disable the
> > overrun reporting, but why would you want that?
> 
> The merits of doing so may be debatable, but if using the quotes
> around "bug" is supposed to indicate that it isn't one, I have
> to respectfully disagree. I know it is not the most important
> thing in the world and without the hardware fault I probably
> would not have seen it at all, but I would still call it a bug.

And so have I. It is a bug, but it's not what causing your problems
here. In fact, I would argue that you do not even want to disable
overrun reporting. That was my point.

> > What's on the other side of the FTDI chip?
> 
> Some kind of an optical receiver circuit (the link is optically
> isolated). On the other side of that is then the device that sends
> periodical data packets (a couple of times per second 17 bytes
> each) to the computer. The computer doesn't send anything i.e.
> the tx functionality of the chip is not used at all.

What baudrates? Have you verified the RS232 signals?

> > It still sounds like your hardware is broken, but at least you
> > seem to have found a work-around.
> 
> Like I said, the hw is the real culprit here, there's no doubt
> about it. But I also doubt that it's just the individual chip
> in my device that has this issue. The device is practically
> brand new and while that is no guarantee that there won't be any
> faults, I find it much more likely that what I am seeing here is
> a quirk of the implementation and there are lots of these chips
> with the same issue out there.

Your device behaving this way is the first one I hear of. 

> The real questions that remain are then; 1. is the chip real or
> counterfeit and how am I supposed to know it,

No idea.

I have three FT232R plugged in as we speak and they have the same
descriptors as yours (bcdDevice etc). Haven't had any issues with them.

> 2. how much the driver can or even should try to accommodate the
> quirks of the hw, and

Without knowing for sure that this is an issue with a class of devices,
there's not much we can do.

> 3. does the answer to #2 depend on the answer to #1.

Yes.

> > Perhaps you can report it to the logging-device (?) manufacturer
> > or FTDI.
> 
> Sure, if I can find someone that cares, which is doubtful.

If the chip is sold as part of the logging device, I would hope the
manufacturer would.

Johan
