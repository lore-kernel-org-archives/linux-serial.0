Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B86C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 10:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7120E60FBF
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 10:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhI0KXG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Sep 2021 06:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233811AbhI0KXG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Sep 2021 06:23:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 319BD60F6D;
        Mon, 27 Sep 2021 10:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632738088;
        bh=/50m1GCkynOqJBB4hWijNqnaIU/AOeegPWeJoJ3e5os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZHVQ2JKLd1UzpLS+hbpGzPsg/qtIlLklp9bYz+FagRUI7g2ges8aXmY6E5d6gqCAs
         C79XGMaXwVLCjpRiRqwoloRqJA84hPoyZCC7F1ySmb6BUboZfZFuqZkmDKmhkGvILT
         N0daKUmzLcKLHYk3Oa7aZiH1Tuz/oyEQZRjQG5bECJyp3mZc8vnGgXEVandl1oqX/D
         /8Fm3Gu3KSVwJWML/5o380LnaXYkTtgZGGwheR41/ZiXmDWJHzBriLMIJPdI/9+xLD
         Hyf5Y9xrbOphyM+j3A3mna8Gxk7FxxPWMK9PjSu/8DT0d/eFkR0i4EujzIJCuQRfG8
         GY1z2Ke//s7pw==
Received: by pali.im (Postfix)
        id D38DDC83; Mon, 27 Sep 2021 12:21:25 +0200 (CEST)
Date:   Mon, 27 Sep 2021 12:21:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Fix reporting real baudrate value in
 c_ospeed field
Message-ID: <20210927102125.rbvnz7q3phvpog3g@pali>
References: <20210927093704.19768-1-pali@kernel.org>
 <YVGVHzHzhOjUp7b8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVGVHzHzhOjUp7b8@kroah.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Monday 27 September 2021 11:55:43 Greg Kroah-Hartman wrote:
> On Mon, Sep 27, 2021 at 11:37:04AM +0200, Pali Rohár wrote:
> > In most cases it is not possible to set exact baudrate value to hardware.
> 
> Why not?

8250 allows to set only divisor and the final baudrate which hw use is:

  baudrate = clock / (16*divisor)

In most cases base UART clock is fixed, so you can set only baudrates
for divisors 1, 2, 3, ..., N.

> > So fix reporting real baudrate value which was set to hardware via c_ospeed
> > termios field. It can be retrieved by ioctl(TCGETS2) from userspace.
> > 
> > Real baudrate value is calculated from chosen hardware divisor and base
> > clock. It is implemented in a new function serial8250_compute_baud_rate()
> > which is inverse of serial8250_get_divisor() function.
> > 
> > With this change is fixed also UART timeout value (it is updated via
> > uart_update_timeout() function), which is calculated from the now fixed
> > baudrate value too.
> 
> I can not parse this sentence, sorry.  Can you try to rephrase it
> differently?

Kernel uses UART timeout value (stored in port->timeout variable) for
e.g. testing if TX fifo is empty. And uart_update_timeout() function
calculates this timeout from baudrate. Hence this change fixes UART
timeout.

> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> > 
> > I have tested this change on device with 8250 compatible UART. I have not
> > tested it on PORT_NPCM nor on UPF_MAGIC_MULTIPLIER hardware, as I do not
> > have such.
> > 
> > Tested device has 250 MHz base clock for 8250 UART. When I set baudrate to
> > 115200, then ioctl(TCGETS2) reported B115200 CBAUD flag and value 114890 in
> > c_ospeed field.
> > 
> > This result is correct as HW for baudrate 115200 is using UART divisor 136,
> > which results in correct reported baudrate: 250000000/(16*136) = 114890
> 
> So is this going to break all the userspace tools that set a baud rate
> and then read it back and get a different number than what they thought
> they set?

As I wrote in above test, CBAUD Bnnn flag (in my test case B115200) was
still set. So userspace is not going to be broken. Kernel functions in
drivers/tty/tty_baudrate.c reports back to userspace original baudrate
value if is in 2% tolerance.

So, in case userspace ask for baudrate value which is not possible to
set (with 2% tolerance) then kernel would report in CBAUD flag different
value. But in this case UART transfer does not work as 2-3% is the
threshold when transmitter and receiver are de-synced and are not able
correctly receive any byte.

So with this change, userspace is notified in case kernel was not able
to set baudrate value which userspace asked and can report to user
reason why UART transfer does not work.

All above was about CBAUD flag, as this is the only supported kernel
flag by glibc.

Extended ioctl(TCGETS2) provides additional field c_ospeed, for which
glibc does not have API yet. This field is supposed to report current
real baudrate value, not rounded to nearest Bnnn value.

And more serial drivers already reports it. So if you set baudrate
115200 then more serial drivers in c_ospeed report real value (e.g.
114890). This is very useful for userspace as it can decide if the
current baudrate value is suitable for its limits. E.g. you may
construct UART receiver which would be able to detect data even if they
are only in 5% tolerance. So you set baudrate on transmitter and then
check if value set by kernel to hw is in tolerance or not.

> That feels very dangerous.  Why does this matter?

Current problem with this driver is that if userspace ask for baudrate B
and for value B there is no divisor D, then this drivers sets some
nearest divisor D' to hw. But divisor D' drivers different baudrate and
userspace did not receive any information that asked B is not possible
to set.

So, I do not think that this is dangerous. It just starts reporting
correct value via TCGETS2 API, like some other serial drivers are
already doing.

> > ---
> >  drivers/tty/serial/8250/8250_port.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 66374704747e..dc6900b2daa8 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2584,6 +2584,19 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
> >  	return serial8250_do_get_divisor(port, baud, frac);
> >  }
> >  
> > +static unsigned int serial8250_compute_baud_rate(struct uart_port *port,
> > +						 unsigned int quot)
> > +{
> > +	if ((port->flags & UPF_MAGIC_MULTIPLIER) && quot == 0x8001)
> > +		return port->uartclk / 4;
> > +	else if ((port->flags & UPF_MAGIC_MULTIPLIER) && quot == 0x8002)
> > +		return port->uartclk / 8;
> > +	else if (port->type == PORT_NPCM)
> > +		return DIV_ROUND_CLOSEST(port->uartclk - 2 * (quot + 2), 16 * (quot + 2));
> > +	else
> > +		return DIV_ROUND_CLOSEST(port->uartclk, 16 * quot);
> > +}
> 
> Where did these formulas come from?

I wrote it in commit message. I constructed inverse of function
serial8250_get_divisor() which calculated divisor for UART HW, which is
what configures baudrate.

> thanks,
> 
> greg k-h
