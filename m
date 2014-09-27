From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] serial: mxs-auart: use mctrl_gpio helpers for
	handling modem signals
Date: Sat, 27 Sep 2014 13:18:14 +0100
Message-ID: <20140927121814.GE5182@n2100.arm.linux.org.uk>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl> <1411811197-12638-3-git-send-email-j.uzycki@elproma.com.pl> <5426926C.60402@elproma.com.pl> <20140927105408.GD5182@n2100.arm.linux.org.uk> <54269C34.8040702@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:44808 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752130AbaI0MS1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Sep 2014 08:18:27 -0400
Content-Disposition: inline
In-Reply-To: <54269C34.8040702@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>

On Sat, Sep 27, 2014 at 01:15:00PM +0200, Janusz U=C5=BCycki wrote:
> It means it is possible but not in Linux today?

It depends on your maximum interrupt latency.

> I think the problem is not interrupt delay, which is often much below=
 100us
> (we get ~10us delay on DCD).

http://archive.arm.linux.org.uk/lurker/message/20130724.145238.44ad37b5=
=2Een.html

   I can believe why this all happens, when you see USB interrupts taki=
ng
   upwards of 3ms to complete:

   Longest time: 3247506ns
   Longest irq: 24
   Longest handler: usb_hcd_irq+0x0/0x68

This no longer seems to be the case - the maximum interrupt time I'm se=
eing
on recent kernels is:

   Longest time: 382236ns
   Longest irq: 62
   Longest handler: mv_interrupt+0x0/0x948

My Dove kernel runs permanently with my own maximum interrupt latency
tracking enabled.

> Isn't the problem rather how to break DMA transmission fast?

There are two factors there.  The first is being able to tell the DMA
engine to stop, the second is the UART hardware FIFO draining.

> Hardware flow control not always requires to stop transmission
> immediately.

No.  Hardware flow control is normally implemented at the UART, and
CTS is normally implemented to prevent the transmitter starting a new
character.  Any in-progress character is completed before the transmitt=
er
stops, so that there are no errors.

At least, this is the behaviour found on the UARTs which I've seen
implementing hardware flow control, and it is the only sane way to do
it.

> Usually delay of some chars is acceptable if remote receiver
> implements low/high water mark (overflow trigger lower than RX FIFO s=
ize).

The receiver you may be communicating with may have a receive FIFO of
only 16 characters.  It may deassert CTS when it reaches half-full stat=
e.
That leaves you with only 8 characters to send before it overflows.  At
115200 baud, you will have started to send the 9th characters by 700us.

However, that isn't the full picture.  The full picture is that CTS is
normally controlled by software as well, and depends on the availabilit=
y
of buffers to store characters.  There's latency at the remote end to
deassert CTS in software when the software buffers reach their high
watermark, and there's the hope that there is sufficient room in those
buffers to take the excess characters that the remote end may continue
to send.

--=20
=46TTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
