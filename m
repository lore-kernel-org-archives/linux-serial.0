From: Holger Schurig <holgerschurig@gmail.com>
Subject: BUG: serial: imx: imprecise data abort
Date: Mon, 26 Sep 2016 16:12:58 +0200
Message-ID: <87y42eoil1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi all,

on an i.MX6Q we had a situation where we got "Imprecise Data Aborts".
The backtraces of those aborts were useless, all over the place.

But we found out that we can trigger this bug with this procedure:

- make some external PC send constantly through the serial port
  to the i.MX6Q.
- run a serial program on the i.MX6Q that receives the data and
  echos it back
- let this program terminate and restart every over second (we
  used a 4 second interval)

Chances were good that we reproduced the issue with various kernels
(up to 4.7.2).


In the drivers/tty/serial/tty/imx.c I disabled all DMA, because this was
my first suspicion. But to no avail. Eventually we asked some company
to help us. They produced the following patch. With this patch, we can
now run for a long time without any imprecise data abort (actually we
run into another issue, but according to
https://lkml.org/lkml/2016/5/16/452 "tty crash in Linux 4.6" this is
already in the working).

It's entirely clear to me that below WIP-patch has ZERO chance of being
added. It's not just checkpatch that will barf over it. :-)

My goal is to make the more knowledgeable people aware of the issue and
to give them a pointer, so that they can tell me how to fix the issue
in a correct way.


Holger




--- linux-4.6.orig/drivers/tty/serial/imx.c
+++ linux-4.6/drivers/tty/serial/imx.c
@@ -234,6 +234,9 @@
 	unsigned int	ucr3;
 };
 
+static unsigned int DBG_Starttx = 0;
+atomic_t imx_uart_is_in_irq = ATOMIC_INIT(0);
+
 static struct imx_uart_data imx_uart_devdata[] = {
 	[IMX1_UART] = {
 		.uts_reg = IMX1_UTS,
@@ -386,8 +389,8 @@
 		}
 	}
 
-	temp = readl(sport->port.membase + UCR2);
-	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
+	//temp = readl(sport->port.membase + UCR2);
+	//writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
 
 	/* disable the `Receiver Ready Interrrupt` */
 	temp = readl(sport->port.membase + UCR1);
@@ -577,6 +580,7 @@
 	}
 
 	if (!sport->dma_is_enabled) {
+		//DBG_Starttx++;
 		temp = readl(sport->port.membase + UCR1);
 		writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
 	}
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	while (readl(sport->port.membase + USR2) & USR2_RDR) {
+		//skip if not enabled 
+		if(((readl(sport->port.membase + UCR2) & UCR2_RXEN) ==0 )
+		   || ((readl(sport->port.membase + UCR1) & UCR1_UARTEN) ==0 ))
+			goto out;
+		
 		flg = TTY_NORMAL;
 		sport->port.icount.rx++;
+
+		
 
 		rx = readl(sport->port.membase + URXD0);
 
@@ -735,6 +746,7 @@
 	unsigned int sts;
 	unsigned int sts2;
 
+	atomic_add(1,&imx_uart_is_in_irq);
 	sts = readl(sport->port.membase + USR1);
 	sts2 = readl(sport->port.membase + USR2);
 
@@ -761,7 +773,7 @@
 		sport->port.icount.overrun++;
 		writel(USR2_ORE, sport->port.membase + USR2);
 	}
-
+	atomic_sub(1,&imx_uart_is_in_irq);
 	return IRQ_HANDLED;
 }
 
@@ -896,6 +908,7 @@
 	struct imx_port *sport = (struct imx_port *)data;
 	unsigned long flags;
 
+	atomic_add(1,&imx_uart_is_in_irq);
 	if (sport->port.state) {
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_mctrl_check(sport);
@@ -903,6 +916,7 @@
 
 		mod_timer(&sport->timer, jiffies + MCTRL_TIMEOUT);
 	}
+	atomic_sub(1,&imx_uart_is_in_irq);
 }
 
 #define RX_BUF_SIZE	(PAGE_SIZE)
@@ -1251,7 +1267,7 @@
 		}
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_stop_tx(port);
-		imx_stop_rx(port);
+//		imx_stop_rx(port);
 		imx_disable_dma(sport);
 		spin_unlock_irqrestore(&sport->port.lock, flags);
 		imx_uart_dma_exit(sport);
@@ -1261,7 +1277,7 @@
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	temp = readl(sport->port.membase + UCR2);
-	temp &= ~(UCR2_TXEN);
+	//temp &= ~(UCR2_TXEN);
 	writel(temp, sport->port.membase + UCR2);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
@@ -1276,13 +1292,16 @@
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	temp = readl(sport->port.membase + UCR1);
-	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
+	//temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
+	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN);
 
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable_unprepare(sport->clk_per);
-	clk_disable_unprepare(sport->clk_ipg);
+	while(atomic_read(&imx_uart_is_in_irq) == 1);
+
+	//clk_disable_unprepare(sport->clk_per);
+	//clk_disable_unprepare(sport->clk_ipg);
 }
 
 static void imx_flush_buffer(struct uart_port *port)
@@ -1732,8 +1750,8 @@
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable(sport->clk_ipg);
-	clk_disable(sport->clk_per);
+	//clk_disable(sport->clk_ipg);
+	//clk_disable(sport->clk_per);
 }
 
 /*
@@ -1834,7 +1852,7 @@
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
-	clk_disable(sport->clk_ipg);
+	/*clk_disable(sport->clk_ipg);
 	if (retval) {
 		clk_unprepare(sport->clk_ipg);
 		goto error_console;
@@ -1843,7 +1861,7 @@
 	retval = clk_prepare(sport->clk_per);
 	if (retval)
 		clk_disable_unprepare(sport->clk_ipg);
-
+	*/
 error_console:
 	return retval;
 }
@@ -2034,7 +2052,7 @@
 		 UCR1_TXMPTYEN | UCR1_RTSDEN);
 	writel_relaxed(reg, sport->port.membase + UCR1);
 
-	clk_disable_unprepare(sport->clk_ipg);
+	//clk_disable_unprepare(sport->clk_ipg);
 
 	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
@@ -2136,7 +2154,7 @@
 
 	serial_imx_save_context(sport);
 
-	clk_disable(sport->clk_ipg);
+	//clk_disable(sport->clk_ipg);
 
 	return 0;
 }
@@ -2153,7 +2171,7 @@
 
 	serial_imx_restore_context(sport);
 
-	clk_disable(sport->clk_ipg);
+	//clk_disable(sport->clk_ipg);
 
 	return 0;
 }
