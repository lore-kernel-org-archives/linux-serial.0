From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH v3] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 24 Feb 2010 15:18:32 -0800
Message-ID: <20100224151832.42c699f2.akpm@linux-foundation.org>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100208165946.0e4dde83@feng-i7>
	<20100208162010.b1f69728.akpm@linux-foundation.org>
	<fa686aa41002081626i24caff52n15f140d0fffadedd@mail.gmail.com>
	<20100209093644.2dead2d9@feng-i7>
	<20100217225817.GD31557@kroah.com>
	<20100224131130.61530b62@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36916 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758187Ab0BXXTf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Feb 2010 18:19:35 -0500
In-Reply-To: <20100224131130.61530b62@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Greg KH <greg@kroah.com>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Wed, 24 Feb 2010 13:11:30 +0800 Feng Tang <feng.tang@intel.com> wrote:

> Hi All,
> 
> Here is a driver for Maxim 3110 SPI-UART device, please help to review.
> 
> It has been validated with Designware SPI controller (drivers/spi: dw_spi.c &
> dw_spi_pci.c). It supports polling and IRQ mode, supports batch read, and
> provides a console.
> 
> change log:
>  since v2:
> 	* Address comments from Andrew Morton
> 	* Use test/set_bit to avoid race condition for SMP/preempt case
> 	* Fix bug related with endian order
> 
>  since v1:
>         * Address comments from Alan Cox
>         * Use a "use_irq" module parameter to runtime check whether
>           to use IRQ mode
>         * Add the suspend/resume implementation
> 
> Thanks!
> Feng
> 
> >From 93455ea6fbf0bfb6494b88ea83296f26f29f7eee Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Tue, 23 Feb 2010 17:52:00 +0800
> Subject: [PATCH] serial: spi: add spi-uart driver for Maxim 3110
> 
> This is the driver for Max3110 SPI-UART device, which connect
> to host with SPI interface. It supports baud rates from 300 to
> 230400, and supports both polling and IRQ mode, as well as
> providing a console for system use
> 
> Its datasheet could be found here:
> http://datasheets.maxim-ic.com/en/ds/MAX3110E-MAX3111E.pdf
> 
> ...
>
> +static int max3110_main_thread(void *_max)
> +{
> +	struct uart_max3110 *max = _max;
> +	wait_queue_head_t *wq = &max->wq;
> +	int ret = 0;
> +	struct circ_buf *xmit = &max->con_xmit;
> +
> +	init_waitqueue_head(wq);
> +	pr_info(PR_FMT "start main thread\n");
> +
> +	do {
> +		wait_event_interruptible(*wq,
> +				max->flags || kthread_should_stop());
> +		set_bit(0, &max->mthread_up);
> +
> +		if (use_irq && test_bit(M3110_IRQ_PENDING, &max->flags)) {
> +			max3110_con_receive(max);
> +			clear_bit(M3110_IRQ_PENDING, &max->flags);
> +		}
> +
> +		/* First handle console output */
> +		if (test_bit(M3110_CON_TX_NEED, &max->flags)) {
> +			send_circ_buf(max, xmit);
> +			clear_bit(M3110_CON_TX_NEED, &max->flags);
> +		}
> +
> +		/* Handle uart output */
> +		if (test_bit(M3110_UART_TX_NEED, &max->flags)) {
> +			transmit_char(max);
> +			clear_bit(M3110_UART_TX_NEED, &max->flags);
> +		}
> +		clear_bit(0, &max->mthread_up);
> +	} while (!kthread_should_stop());
> +
> +	return ret;
> +}
> +
> +static irqreturn_t serial_m3110_irq(int irq, void *dev_id)
> +{
> +	struct uart_max3110 *max = dev_id;
> +
> +	/* max3110's irq is a falling edge, not level triggered,
> +	 * so no need to disable the irq */
> +	set_bit(M3110_IRQ_PENDING, &max->flags);
> +
> +	if (!test_bit(0, &max->mthread_up))
> +		wake_up_process(max->main_thread);
> +
> +	return IRQ_HANDLED;
> +}

The manipulation of mthread_up here (and in several other places) is
clearly quite racy.  If you hit that race, the thread will not wake up
and the driver will sit there not doing anything until some other event
happens.

This is perhaps fixable with test_and_set_bit() and
test_and_clear_bit() (need to think about that) or, of course, by
adding locking.

But a simpler fix is just to delete mthread_up altogether.  wake_up_process()
on a running process is an OK thing to do and hopefully isn't terribly slow.

> +/* If don't use RX IRQ, then need a thread to polling read */
> +static int max3110_read_thread(void *_max)
> +{
> +	struct uart_max3110 *max = _max;
> +
> +	pr_info(PR_FMT "start read thread\n");
> +	do {
> +		if (!test_bit(0, &max->mthread_up))
> +			max3110_con_receive(max);
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout_interruptible(HZ / 20);

The set_current_state(TASK_INTERRUPTIBLE) is unneeded.

> +	} while (!kthread_should_stop());
> +
> +	return 0;
> +}

