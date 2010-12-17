From: Johannes Reif <reif@corscience.de>
Subject: sc16is7x2 driver bug (fix)
Date: Fri, 17 Dec 2010 16:22:18 +0100
Message-ID: <4D0B802A.1090002@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56928 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab0LQPWF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Dec 2010 10:22:05 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org, manuel.stahl@iis.fraunhofer.de

Hi,

I'm using the sc16is7x2 driver (SPI<-> 2x UART) written by Manuel Stahl.
While operating one UART channel everything seems fine. But if I use 
both channels the driver runs into an "unresponsive state" after some time.
In this state I figured out that the /IRQ pin of the chip stays low 
(active) although the IIR of both channels indicates that there is no 
interrupt pending.

Can someone reproduce this bug?

I want to make clear that there are 2 interrupt handler which share one 
IRQ. So i.e. let's say the following happens:

- RX-timeout interrupt on channel 2
- IRQ Pin high -> low (active)
- kernel gets notice of IRQ and starts thread(s)
- work thread ch. 1 starting
- work thread ch. 2 starting
- work thread ch. 1 reads IIR over SPI and figures out that ch. 1 has no 
interrupt
- work thread ch. 2 reads IIR over SPI, sees that ch
- work thread ch. 1 finished (returns IRQ_HANDLED)
- work thread ch. 2 reads out RX data --> IIR gets cleared (also IRQ pin 
goes high)
(what happens when ch. 1 gets data now and generates an IRQ before 
worker of ch. 2 has finished)
- work thread ch. 2. finished /returns IRQ_HANDLED)

Is it possible that last IRQ_HANDLED makes the Kernel wait for /IRQ pin 
going high and low again, because the Kernel thinks that the first 
IRQ_HANDLED managed the IRQ and the second one that of ch. 1 which didn't?

For those who don't have the driver right now here's the work routine.

static irqreturn_t sc16is7x2_work(int irq, void *data)
{
     struct sc16is7x2_channel *chan = data;
     struct sc16is7x2_chip *ts = chan->chip;
     struct spi_message *m = &(chan->fifo_message);
     unsigned ch = (chan == ts->channel) ? 0 : 1;
     bool rx, tx;

     dev_dbg(&ts->spi->dev, "%s (%i)\n", __func__, ch);

     sc16is7x2_read_status(ts, ch);

     while ((chan->iir & UART_IIR_NO_INT) == 0x00
&& !ts->force_end_work) {
         sc16is7x2_handle_modem(ts, ch);

         spi_message_init(m);
         rx = sc16is7x2_msg_add_fifo_rx(ts, ch);
         tx = sc16is7x2_msg_add_fifo_tx(ts, ch);

         if (rx || tx)
             spi_sync(ts->spi, m);

         if (rx)
             sc16is7x2_handle_fifo_rx(chan);
         if (tx)
             sc16is7x2_handle_fifo_tx(chan);

         sc16is7x2_read_status(ts, ch);
     }
     dev_dbg(&ts->spi->dev, "%s finished (iir = 0x%02x)\n",
             __func__, chan->iir);

     return IRQ_HANDLED;
}


The following patch is a workaround for that bug which does also check 
the gpio pin of the IRQ line.

--- a/drivers/serial/sc16is7x2.c
+++ b/drivers/serial/sc16is7x2.c
@@ -1042,7 +1042,7 @@ static irqreturn_t sc16is7x2_work(int irq, void *data)

         sc16is7x2_read_status(ts, ch);

-       while ((chan->iir & UART_IIR_NO_INT) == 0x00
+       while (((chan->iir & UART_IIR_NO_INT) == 0x00 || 
gpio_get_value(irq_to_gpio(ts->spi->irq)) == 0)
&& !ts->force_end_work) {
                 sc16is7x2_handle_modem(ts, ch);

Johannes Reif
