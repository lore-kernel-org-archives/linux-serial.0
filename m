From: Feng Tang <feng.tang@intel.com>
Subject: Re: [RFC][PATCH v3] serial: spi: add spi-uart driver for Maxim 3110
Date: Thu, 25 Feb 2010 14:39:40 +0800
Message-ID: <20100225143940.40e21ff7@feng-i7>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100208165946.0e4dde83@feng-i7>
	<20100208162010.b1f69728.akpm@linux-foundation.org>
	<fa686aa41002081626i24caff52n15f140d0fffadedd@mail.gmail.com>
	<20100209093644.2dead2d9@feng-i7>
	<20100217225817.GD31557@kroah.com>
	<20100224131130.61530b62@feng-i7>
	<20100224151832.42c699f2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8138 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab0BYGh5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 01:37:57 -0500
In-Reply-To: <20100224151832.42c699f2.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Thu, 25 Feb 2010 07:18:32 +0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> > ...
> >
> > +static int max3110_main_thread(void *_max)
> > +{
> > +	struct uart_max3110 *max = _max;
> > +	wait_queue_head_t *wq = &max->wq;
> > +	int ret = 0;
> > +	struct circ_buf *xmit = &max->con_xmit;
> > +
> > +	init_waitqueue_head(wq);
> > +	pr_info(PR_FMT "start main thread\n");
> > +
> > +	do {
> > +		wait_event_interruptible(*wq,
> > +				max->flags ||
> > kthread_should_stop());
> > +		set_bit(0, &max->mthread_up);
> > +
> > +		if (use_irq && test_bit(M3110_IRQ_PENDING,
> > &max->flags)) {
> > +			max3110_con_receive(max);
> > +			clear_bit(M3110_IRQ_PENDING, &max->flags);
> > +		}
> > +
> > +		/* First handle console output */
> > +		if (test_bit(M3110_CON_TX_NEED, &max->flags)) {
> > +			send_circ_buf(max, xmit);
> > +			clear_bit(M3110_CON_TX_NEED, &max->flags);
> > +		}
> > +
> > +		/* Handle uart output */
> > +		if (test_bit(M3110_UART_TX_NEED, &max->flags)) {
> > +			transmit_char(max);
> > +			clear_bit(M3110_UART_TX_NEED, &max->flags);
> > +		}
> > +		clear_bit(0, &max->mthread_up);
> > +	} while (!kthread_should_stop());
> > +
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t serial_m3110_irq(int irq, void *dev_id)
> > +{
> > +	struct uart_max3110 *max = dev_id;
> > +
> > +	/* max3110's irq is a falling edge, not level triggered,
> > +	 * so no need to disable the irq */
> > +	set_bit(M3110_IRQ_PENDING, &max->flags);
> > +
> > +	if (!test_bit(0, &max->mthread_up))
> > +		wake_up_process(max->main_thread);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> The manipulation of mthread_up here (and in several other places) is
> clearly quite racy.  If you hit that race, the thread will not wake up
> and the driver will sit there not doing anything until some other
> event happens.
> 
> This is perhaps fixable with test_and_set_bit() and
> test_and_clear_bit() (need to think about that) or, of course, by
> adding locking.
> 
> But a simpler fix is just to delete mthread_up altogether.
> wake_up_process() on a running process is an OK thing to do and
> hopefully isn't terribly slow.

Yes, wake_up_process won't harm a running process, our driver's case
is a little special, the console's write() func may call
wake_up_process() for every character in the buffer, thus we will
try to avoid to call it. mthread_up can't be removed as it is also
referenced in read_thread.

I prefer to use the test_and_set/clear_bit for "mthread_up".

Thanks,
Feng

diff --git a/drivers/serial/max3110.c b/drivers/serial/max3110.c
index e8c44fa..d5bd71f 100644
--- a/drivers/serial/max3110.c
+++ b/drivers/serial/max3110.c
@@ -400,7 +400,7 @@ static int max3110_main_thread(void *_max)
 	do {
 		wait_event_interruptible(*wq,
 				max->flags || kthread_should_stop());
-		set_bit(0, &max->mthread_up);
+		test_and_set_bit(0, &max->mthread_up);
 
 		if (use_irq && test_bit(M3110_IRQ_PENDING, &max->flags)) {
 			max3110_con_receive(max);
@@ -418,7 +418,7 @@ static int max3110_main_thread(void *_max)
 			transmit_char(max);
 			clear_bit(M3110_UART_TX_NEED, &max->flags);
 		}
-		clear_bit(0, &max->mthread_up);
+		test_and_clear_bit(0, &max->mthread_up);
 	} while (!kthread_should_stop());
 
 	return ret;

