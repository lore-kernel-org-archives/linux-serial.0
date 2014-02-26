From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: API to flush rx fifo?
Date: Wed, 26 Feb 2014 12:14:23 -0500
Message-ID: <530E20EF.7070609@hurleysoftware.com>
References: <kpak75$9ko$1@ger.gmane.org> <51BB2C2A.9050601@hurleysoftware.com> <kpfc5k$5u4$1@ger.gmane.org> <51BB3AD0.50201@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:34847 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752493AbaBZROZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Feb 2014 12:14:25 -0500
In-Reply-To: <51BB3AD0.50201@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

Hi Grant,

I know this is old but I had marked this for re-review in my mail,
and after re-looking at this problem, I realized I gave you some bad info.

Since you were referring to uart_ops, I'll assume this is for your
serial-core mini-driver(s).


On 06/14/2013 11:46 AM, Peter Hurley wrote:
> On 06/14/2013 11:17 AM, Grant Edwards wrote:
>> On 2013-06-14, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 06/12/2013 04:03 PM, Grant Edwards wrote:
>>>> I see the uart_ops.flush_buffer method which is used to flush the
>>>> UART's tx fifo (presumably when the user calls tcflush(TCOFLUSH)).

The N_TTY ldisc calls tty->ops->flush_buffer() for TCOFLUSH _and TCIOFLUSH_.

[ For a serial-core mini-driver, tty->ops->flush_buffer() is uart_flush_buffer(),
   which calls uart_ops.flush_buffer().
]

>>>>
>>>> How does the rx fifo get flushed when the user calls tcflush(TCIFLUSH)?
>>>
>>> It doesn't.

The ioctl(TCIFLUSH) does in fact flush the tty buffers.

If you want to flush your hardware rx fifo, you can define the .ioctl()
method in your struct uart_ops and handle TCIFLUSH there.

Note: be sure to return -ENOIOCTLCMD so that TCIFLUSH processing still
gets seen by the ldisc!

Like this (apologies in advance for formatting; my mailer is dain-bramaged),

/* called with port->mutex held */
static int xxxxxx_ioctl(struct uart_port *port, unsigned int cmd,
			unsigned long arg)
{
	if (cmd == TCFLSH) {
		switch (arg) {
		case TCIFLUSH:
		case TCIOFLUSH:
			spin_lock_irq(&port->lock);
			xxxxxx_empty_rx_fifo(port);
			spin_unlock_irq(&port->lock);
			/* fall-through */
		}
	}
	return -ENOIOCTLCMD;
}


Sorry, hope this isn't too late :(

Regards,
Peter Hurley

