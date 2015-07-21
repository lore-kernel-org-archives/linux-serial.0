From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Tue, 21 Jul 2015 11:18:38 +0200
Message-ID: <20150721091838.GG20628@localhost>
References: <55AC1883.4050605@svenbrauch.de>
 <20150720172546.GF20628@localhost>
 <55AD38E5.1090807@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55AD38E5.1090807@svenbrauch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Brauch <mail@svenbrauch.de>
Cc: Johan Hovold <johan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>, Peter Hurley <peter@hurleysoftware.com>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 20, 2015 at 08:07:33PM +0200, Sven Brauch wrote:
> On 20/07/15 19:25, Johan Hovold wrote:

> > The idea of adding another layer of buffering in the cdc-acm driver has
> > been suggested in the past but was rejected (or at least questioned).
> > See for example this thread:
> > 
> > 	https://lkml.kernel.org/r/20110608164626.22bc893c@lxorguk.ukuu.org.uk
> Yes, that is indeed pretty much the same problem and the same solution.
> Answering to the questions brought up in that thread:
> 
> > a) Why is your setup filling 64K in the time it takes the throttle
> > response to occur
> As far as I understand, the throttle happens only when there's less than
> 128 bytes of free space in the tty buffer. Data can already be lost
> before the tty even decides it should start throttling, simply because
> the throttle threshold is smaller than the amount of data potentially in
> each urb. Also (excuse my cluelessness) it seems that when exactly the
> throttling happens depends on some scheduling "jitter" as well.
> Additionally, the response of the cdc_acm driver to a throttle request
> is not very prompt; it might have a queue of up to 16kB (16 urbs) pending.

Not really. The n_tty ldisc throttles when *its* buffer space is low,
but there should still be plenty of room in the tty buffers.

Looks like the ldisc processing is being starved.

> > b) Do we care (is the right thing to do to lose bits anyway at
> > that point)
> This I cannot answer, I don't know enough about the architecture or
> standards. I can just say that for my case, there's a lot of losses;
> this it not an issue which happens after hours when the system is under
> heavy load, it happens after just a few seconds reproducably.

In general if data isn't being consumed fast enough we eventually need
to drop it (unless we can throttle the producer).

But this isn't necessarily the case in your setup.

> > The tty buffers are quite large these days, but could possibly be bumped
> > further if needed to give the ldisc some more time to throttle the
> > device at very high speeds.
> I do not like this solution. It will again be based on luck, and you
> will still be unable to rely on the delivery guarantee made by the USB
> stack (at least when using bulk).

See above.

> My suggestion instead stops the host system from accepting any more data
> from the device when its buffers are full, forcing the device to wait
> before sending out more data (which many kinds of devices might very
> well be able to do).

This is what we are supposed to do today, but by relying on the ldisc
and tty buffers rather than forcing every driver to implement another
custom throttling mechanism.

But something obviously isn't working as intended.

Johan
