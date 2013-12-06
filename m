From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH RFC] tty_ldisc: add more limits to the @write_wakeup
Date: Fri, 6 Dec 2013 18:34:51 +0800
Message-ID: <52A1A84B.80409@freescale.com>
References: <1384327803-5925-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:51501
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754481Ab3LFKcY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Dec 2013 05:32:24 -0500
In-Reply-To: <1384327803-5925-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, marcel@holtmann.org, linux-bluetooth@vger.kernel.org

=D3=DA 2013=C4=EA11=D4=C213=C8=D5 15:30, Huang Shijie =D0=B4=B5=C0:
> In the uart_handle_cts_change(), uart_write_wakeup() is called after
> we call @uart_port->ops->start_tx().
>
> The Documentation/serial/driver tells us:
> -----------------------------------------------
>   start_tx(port)
> 	Start transmitting characters.
>
> 	Locking: port->lock taken.
> 	Interrupts: locally disabled.
> -----------------------------------------------
>
> So when the uart_write_wakeup() is called, the port->lock is taken by
> the upper. See the following callstack:
>
> 	|_ uart_write_wakeup
> 	   |_ tty_wakeup
> 	      |_ ld->ops->write_wakeup
>
> With the port->lock held, we call the @write_wakeup. Some implemetati=
on of
> the @write_wakeup does not notice that the port->lock is held, and it=
 still
> tries to send data with uart_write() which will try to grab the prot-=
>lock.
> A dead lock occurs, see the following log caught in the Bluetooth by =
uart:
>
> --------------------------------------------------------------------
> BUG: spinlock lockup suspected on CPU#0, swapper/0/0
>  lock: 0xdc3f4410, .magic: dead4ead, .owner: swapper/0/0, .owner_cpu:=
 0
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W    3.10.17-16839-ge=
4a1bef #1320
> [<80014cbc>] (unwind_backtrace+0x0/0x138) from [<8001251c>] (show_sta=
ck+0x10/0x14)
> [<8001251c>] (show_stack+0x10/0x14) from [<802816ac>] (do_raw_spin_lo=
ck+0x108/0x184)
> [<802816ac>] (do_raw_spin_lock+0x108/0x184) from [<806a22b0>] (_raw_s=
pin_lock_irqsave+0x54/0x60)
> [<806a22b0>] (_raw_spin_lock_irqsave+0x54/0x60) from [<802f5754>] (ua=
rt_write+0x38/0xe0)
> [<802f5754>] (uart_write+0x38/0xe0) from [<80455270>] (hci_uart_tx_wa=
keup+0xa4/0x168)
> [<80455270>] (hci_uart_tx_wakeup+0xa4/0x168) from [<802dab18>] (tty_w=
akeup+0x50/0x5c)
> [<802dab18>] (tty_wakeup+0x50/0x5c) from [<802f81a4>] (imx_rtsint+0x5=
0/0x80)
> [<802f81a4>] (imx_rtsint+0x50/0x80) from [<802f88f4>] (imx_int+0x158/=
0x17c)
> [<802f88f4>] (imx_int+0x158/0x17c) from [<8007abe0>] (handle_irq_even=
t_percpu+0x50/0x194)
> [<8007abe0>] (handle_irq_event_percpu+0x50/0x194) from [<8007ad60>] (=
handle_irq_event+0x3c/0x5c)
> --------------------------------------------------------------------
>
> This patch adds more limits to the @write_wakeup, the one who wants t=
o
> implemet the @write_wakeup should follow the limits which avoid the d=
eadlock.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  include/linux/tty_ldisc.h |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
> index f15c898..539ccc5 100644
> --- a/include/linux/tty_ldisc.h
> +++ b/include/linux/tty_ldisc.h
> @@ -91,7 +91,10 @@
>   *	This function is called by the low-level tty driver to signal
>   *	that line discpline should try to send more characters to the
>   *	low-level driver for transmission.  If the line discpline does
> - *	not have any more data to send, it can just return.
> + *	not have any more data to send, it can just return. If the line
> + *	discipline does have some data to send, please arise a tasklet
> + *	or workqueue to do the real data transfer. Do not send data in
> + *	this hook, it may leads to a deadlock.
>   *
>   * int (*hangup)(struct tty_struct *)
>   *
just a ping.

In actually, this is a BUG in the tty code or BT code.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
