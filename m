From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v6] serial: spi: add spi-uart driver for Maxim 3110
Date: Fri, 5 Mar 2010 11:48:28 +0800
Message-ID: <20100305114828.18b9081d@feng-i7>
References: <20100304152524.56055828@feng-i7>
	<201003041845.o24IjlHQ028291@imail.sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10664 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194Ab0CEDpd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Mar 2010 22:45:33 -0500
In-Reply-To: <201003041845.o24IjlHQ028291@imail.sm.sony.co.jp>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>


Hi Mokuno,

Thanks for the thorough review and good comments!
Some of your comments are answered inline, others will be addressed in future
 patch submission.

I would give v6 of this patch more time to be reviewed by community, so that
more comments can come and I can handle them altogether.

Thanks,
Feng

On Fri, 5 Mar 2010 02:46:07 +0800
Masakazu Mokuno <mokuno@sm.sony.co.jp> wrote:

> Hi Feng,
> 
> My comments inlined.
> 
> On Thu, 4 Mar 2010 15:25:24 +0800
> Feng Tang <feng.tang@intel.com> wrote:
> 

> > +     wait_queue_head_t wq;
> > +     struct task_struct *main_thread;
> > +     struct task_struct *read_thread;
> > +     spinlock_t lock;
> 
> checkpatch.pl complained:
> 
> CHECK: spinlock_t definition without comment
> #119: FILE: drivers/serial/max3110.c:53:
> +       spinlock_t lock;

A little strange, I'm using checkpatch.pl in kernel source, which doesn't
generate any warning. Which version are you using?



> > +
> > +     /* If caller doesn't provide a buffer, then handle received
> > char */
> > +     pbuf = rxbuf ? rxbuf : valid_str;
> > +
> > +     for (i = 0, j = 0; i < M3110_RX_FIFO_DEPTH; i++) {
> > +             if (ibuf[i] & MAX3110_READ_DATA_AVAILABLE)
> > +                     pbuf[j++] = ibuf[i] & 0xff;
> 
>                 else
>                         break;
> 
> Can be added in order to optimize a bit :)
> There are other similar places where search valid received chars.

Reading Max3110 buffer is asynchronous operation, like for the reader thread,
spi controller will write 8 words of 0 to max3110, and read 8 words back, the
first word doesn't have a valid data doesn't mean the following don't, and we
need to check them all


> > +static int max3110_main_thread(void *_max)
> > +{
> > +     struct uart_max3110 *max = _max;
> > +     wait_queue_head_t *wq = &max->wq;
> > +     int ret = 0;
> > +     struct circ_buf *xmit = &max->con_xmit;
> > +
> > +     init_waitqueue_head(wq);
> > +     pr_info(PR_FMT "start main thread\n");
> > +
> > +     do {
> > +             wait_event_interruptible(*wq,
> > +                             max->flags || kthread_should_stop());
> > +             test_and_set_bit(0, &max->mthread_up);
> 
> The result of testing ignored. Why testing?

Andrew mentioned a race condition for using set/test_bit for mthread_up
flag, which I don't quiet follow due to my lack of SMP race experience,
mthread_up is not designed to make some code exclusive. And whether the main
thread can be woken up to run depends on the max->flags setting.

> 
> > +
> > +             if (use_irq && test_bit(M3110_IRQ_PENDING,
> > &max->flags)) {
> > +                     max3110_con_receive(max);
> > +                     clear_bit(M3110_IRQ_PENDING, &max->flags);
> > +             }
> 
> test_and_clear_bit()?
You mean 
	if (use_irq && test_and_clear_bit(..))
		max3110_con_receive(max);
?

Yes, it's better. I put clear_bit() after max3110_con_receive() because
I test that bit to decide whether we need wakeup the main thread again
in the ISR in old version submission.

> > +
> > +     /* As we use thread to handle tx/rx, need set low latency */
> > +     port->state->port.tty->low_latency = 1;
> > +
> > +     if (use_irq) {
> > +             ret = request_irq(max->irq, serial_m3110_irq,
> > +                                     IRQ_TYPE_EDGE_FALLING,
> > "max3110", max);
> 
> According to the manufacturer's datasheet, it looks like MAX3110'irq
> is level interrupt. Refer Figure 6 of the datasheet.

Yep, good catch here, if there is RX data in buffer, the IRQ pin will
be asserted low always. But the IRQ line will usually be connected to
system through a GPIO pin, we use falling edge for GPIO pin IRQ trigger,
when 3110's IRQ is asserted, that GPIO pin will be changed from high to low,
the ISR and following handler will try to read all the RX data out to
make 3110's IRQ go back to high, waiting for another IRQ. 

> > +             if (baud == 230400)
> > +                     clk_div = WC_BAUD_DR1;
> 
> This if statement can be omitted as WC_BAUD_DR1 is 0 and clk_div
> becomes (-1 + 1).
Nice trick, but it may confuse readers without any explanation :)


> > +     max->port.type = PORT_MAX3110;
> > +     max->port.fifosize = 2;         /* Only have 16b buffer */
> 
> I guess MAX3110 has 8 chars RX FIFO and no TX FIFO.  If so, value 2 is
> OK here?
> 
If you check the Figure 1 of the data sheet, there is still a TX buffer
there tough only one word :) or should I change it to 1? 

> 
> 
> > +
> > +     max->main_thread = kthread_run(max3110_main_thread,
> > +                                     max, "max3110_main");
> > +     if (IS_ERR(max->main_thread)) {
> > +             ret = PTR_ERR(max->main_thread);
> > +             goto err_kthread;
> > +     }
> > +
> > +     pmax = max;
> 
> If this driver supports only one instance of devices, how about
> declaring a global struct uart_m3100 instead of kmallc()?
If using global struct, the space will be allocated no matter the system
really have a Max3110, putting the allocation in probe() is flexible


