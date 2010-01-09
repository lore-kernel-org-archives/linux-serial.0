From: Mac Lin <mkl0301@hotmail.com>
Subject: =?UTF-8?Q?SMP_issues_with_8250.c=E2=80=8F?=
Date: Sat, 9 Jan 2010 09:03:43 -0800 (PST)
Message-ID: <27090634.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:55611 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab0AIRDo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Jan 2010 12:03:44 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NTej1-0006Q9-AX
	for linux-serial@vger.kernel.org; Sat, 09 Jan 2010 09:03:43 -0800
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


hi,

I had had an issue with serial console in SMP mode.

http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/006650.html

I'm using ARM11 MPCore with 2 CPU, Linux-2.6.31.1, SMP enabled, L1 enabled,
L2 disabled

Under SMP environment, I have observed following issues:

   1. Sometimes, console became extremely slow, print 1 character for 1-2
seconds
      RVDS say that both CPU are idling. kernel seems find because messages
response to inserting USB flash is quick and correct.

   2. Sometimes, the Linux console halt and canot accept any input.
      RVDS say that both CPU are idling. kernel seems find because messages
response to inserting USB flash is quick and correct.

In both cases kernel message seems fine, but user messages is broken.

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-January/007052.html

Thanks for Russell's advice, after some tracing, I found that my IER
(Interrupt Enable Register) of the serial port is 0 under case 1!!

Case 2 is actually the same with case 1. Case 1 would come first, if I don't
keep input things and let it finish its slow printing, it would then become
case 2.

UART_BUG_THRE are detected and enabled on my platform, causing
serial8250_backup_timeout to be used.

There are many places that do ( get IER, clear IER, restore IER ), like
serial8250_console_write called by printk, and serial8250_backup_timeout.
serial8250_backup_timeout is not protected by spinlock, causing the race
condition, and result in wrong IER value.

Following patch fix this issue. Case 3 and Case 4 are still often seen, but
not case 1 and case 2.

    diff --git a/kernels/linux-2.6.31.1-X/drivers/serial/8250.c
b/kernels/linux-2.6.31.1-X/drivers/serial/8250.c
    index 288a0e4..55602c3 100644
    --- a/kernels/linux-2.6.31.1-cavm1/drivers/serial/8250.c
    +++ b/kernels/linux-2.6.31.1-cavm1/drivers/serial/8250.c
    @@ -1752,6 +1758,8 @@ static void serial8250_backup_timeout(unsigned
long data)
      unsigned int iir, ier = 0, lsr;
      unsigned long flags;
     
    +
    + spin_lock_irqsave(&up->port.lock, flags);
      /*
       * Must disable interrupts or else we risk racing with the interrupt
       * based handler.
    @@ -1769,10 +1777,8 @@ static void serial8250_backup_timeout(unsigned
long data)
       * the "Diva" UART used on the management processor on many HP
       * ia64 and parisc boxes.
       */
    - spin_lock_irqsave(&up->port.lock, flags);
      lsr = serial_in(up, UART_LSR);
      up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
    - spin_unlock_irqrestore(&up->port.lock, flags);
      if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
          (!uart_circ_empty(&up->port.info->xmit) || up->port.x_char) &&
          (lsr & UART_LSR_THRE)) {
    @@ -1780,12 +1786,14 @@ static void serial8250_backup_timeout(unsigned
long data)
       iir |= UART_IIR_THRI;
      }
     
    - if (!(iir & UART_IIR_NO_INT))
    -  serial8250_handle_port(up);
    -
      if (is_real_interrupt(up->port.irq))
       serial_out(up, UART_IER, ier);
     
    + spin_unlock_irqrestore(&up->port.lock, flags);
    +
    + if (!(iir & UART_IIR_NO_INT))
    +  serial8250_handle_port(up);
    +
      /* Standard timer interval plus 0.2s to keep the port running */
      mod_timer(&up->timer,
       jiffies + poll_timeout(up->port.timeout) + HZ / 5);

Is there any concern of above patch?

On the other hand, is it normal to have UART_BUG_THRE enabled? My console
work just fine without this workaround (force UART_BUG_THRE disabled, only
test once though, but it doesn't have issues above). If it shouldn't be, I
doubt that somehow the interrupt is serviced, such that the detection of
UART_BUG_THRE failed.

But while I'm tracing, I cannot find where the driver clear the interrupt.
If the driver didn't clear the interrupt, how does the hardware knows that
it is serviced?

Any advice appreciated.

Best Regards,
Mac Lin
-- 
View this message in context: http://old.nabble.com/SMP-issues-with-8250.c%E2%80%8F-tp27090634p27090634.html
Sent from the linux-serial mailing list archive at Nabble.com.

