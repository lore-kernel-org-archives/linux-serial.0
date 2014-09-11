From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] tty: serial: core: Only invoke ->start_tx() if there
 is data to send
Date: Thu, 11 Sep 2014 10:03:58 +0200
Message-ID: <5411576E.204@linutronix.de>
References: <1410377601-26794-1-git-send-email-bigeasy@linutronix.de> <5410AC1B.9000700@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5410AC1B.9000700@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/10/2014 09:52 PM, Peter Hurley wrote:
> The serial core can't assume that start_tx() does not need invoking
> because hardware that can stop_tx() with data in the transmitter
> won't restart if the ring buffer is empty but data is still in the
> transmitter. [Note that the 16C950 port type does this in the 8250 dr=
iver.]

oh, not sure how I missed this=E2=80=A6 But now that I look at this, it=
 is also
that ->x_char that could be use for flow control which would have to be
sent even with an empty xmit buffer.
And 8250 in DMA mode does not look at x_char at all. But it would be
better if it would, right? However if the TX side does a 2 KiB transfer
not sure what should be done=E2=80=A6

> So this has to be handled in the 8250 driver.
>=20
> What is the actual issue? Are you trying not to unnecessarily wake
> the omap hardware if runtime-PM is on?

no, it is actually the extra interrupt for no reason that looked like
not needed at all. But I guess it is only during "startup" while the
init-script do fancy things and not during "normal" operations.

> Regards,
> Peter Hurley

Sebastian
