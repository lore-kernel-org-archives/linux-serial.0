From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH] tty: serial: core: Only invoke ->start_tx() if there
 is data to send
Date: Thu, 11 Sep 2014 08:48:54 -0400
Message-ID: <54119A36.5000001@hurleysoftware.com>
References: <1410377601-26794-1-git-send-email-bigeasy@linutronix.de> <5410AC1B.9000700@hurleysoftware.com> <5411576E.204@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5411576E.204@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/11/2014 04:03 AM, Sebastian Andrzej Siewior wrote:
> On 09/10/2014 09:52 PM, Peter Hurley wrote:
>> The serial core can't assume that start_tx() does not need invoking
>> because hardware that can stop_tx() with data in the transmitter
>> won't restart if the ring buffer is empty but data is still in the
>> transmitter. [Note that the 16C950 port type does this in the 8250 d=
river.]
>=20
> oh, not sure how I missed this=E2=80=A6 But now that I look at this, =
it is also
> that ->x_char that could be use for flow control which would have to =
be
> sent even with an empty xmit buffer.
> And 8250 in DMA mode does not look at x_char at all. But it would be
> better if it would, right? However if the TX side does a 2 KiB transf=
er
> not sure what should be done=E2=80=A6

Yeah, 8250 dma doesn't send x_char at all; at a minimum 8250 dma should
at least send the x_char.

The preferred solution is to:
1. Stop DMA
2. Enable interrupt mode, which will automatically send the x_char
3. Restart DMA (presumably from the interrupt handler if UART_LSR_THRE)

The issue is whether 8250 dma hardware in general can stop and restart
dma without losing where the dma transfer was.

Regards,
Peter Hurley
