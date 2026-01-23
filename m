Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB602F3636;
	Fri, 23 Jan 2026 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189302; cv=none; b=gITcNDuF14qva72qCEY1CP7LleoUdujSrNdW4dunfguuEbstY7xOSs0UJLGOPavsYhvZkR0zQN8ZAEHYsy41iG8+BN+x+aMY/yAjd81JQ1GHv8SmGnySBgR3NEEKkbfux0Trpn8ngzzRcLjkY7IZP3eo/KVvjZGDfWf6Yywnb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189302; c=relaxed/simple;
	bh=6SNlh4FhNzMNTP4/BxETvmSUAkuTbKpUI4iK+ppOzi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkOMgfEVkNcNA0VjCixuknYosKCqg/MN8/M/0YDQjHKIhUUtxYW1pidX2fl80RWqpoWO6jwSOeMeD/dbTcB8NMhdFbsks7NyI3lbKaD15q01Brl+pLjOaDS/pnhcfMEhdafK58VLEM0FWc5k3jxadzsc/bh46KtpvZ3C0PG2NPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGpwpOWb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGpwpOWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769189301; x=1800725301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SNlh4FhNzMNTP4/BxETvmSUAkuTbKpUI4iK+ppOzi8=;
  b=eGpwpOWbFzMZwbOmRTuAjUoxSZE5mINZHn38Qso3b8MwbL5DDTQ/5lEs
   wjrfeut+Axi2SFJGELfyI4iw5Un/eirxOLBx/dCRCwTGjM1kTPqjGAjcE
   h6B9FGTuyOaSLld8cAfq57I8rSDUR9hwaCyJbhfnqZ4LWXlNdAWRes5QM
   7kwoUm2/376iuUBpud+pyXrqxUUt2uCrbblAROC3RSadrQ/baCQlrP/4q
   /Zm6wAd0GZk1JXhThaBFABGCb3b2BieaE1BO5TYOcblHcbZKEXGTDeA0E
   KhuIKb1FdXP0CDoIcwg2NfNrZGa60P2UHMBgaWdnTzM79FBOYBoi78o87
   Q==;
X-CSE-ConnectionGUID: GoJmpA6vQtuINzySdgyoVw==
X-CSE-MsgGUID: IhhK6V58TYaUr6PFjy7jGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="88020974"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="88020974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:28:20 -0800
X-CSE-ConnectionGUID: Zh7IO9GpQiKX5z7KdpR1Mg==
X-CSE-MsgGUID: zpnjGPgdR8qXDtCofnPxdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211581056"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.164])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:28:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: "Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: [PATCH 3/6] serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
Date: Fri, 23 Jan 2026 19:27:36 +0200
Message-Id: <20260123172739.13410-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

dw8250_handle_irq() takes port's lock multiple times with no good
reason to release it in between and calls serial8250_handle_irq()
that also takes port's lock.

As serial8250_handle_irq() takes port's lock itself, create
serial8250_handle_irq_locked() that allows caller to hold port's lock
across the call. Take port's lock only once in dw8250_handle_irq() and
call serial8250_handle_irq_locked() directly.

As IIR_NO_INT check in serial8250_handle_irq() was outside of port's
lock, it has to be done already in dw8250_handle_irq().

DW UART can, in addition to IIR_NO_INT, report BUSY_DETECT (0x7) which
collided with the IIR_NO_INT (0x1) check in serial8250_handle_irq()
(because & is used instead of ==) meaning that no other work is done by
serial8250_handle_irq() during an BUSY_DETECT interrupt.

This allows reorganizing code in dw8250_handle_irq() to do both
IIR_NO_INT and BUSY_DETECT handling right at the start simplifying
the logic.

Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c   | 35 ++++++++++++++++-------------
 drivers/tty/serial/8250/8250_port.c | 24 +++++++++++++-------
 include/linux/serial_8250.h         |  1 +
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 57a760b43da9..7cee89f14179 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -9,6 +9,8 @@
  * LCR is written whilst busy.  If it is, then a busy detect interrupt is
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -40,6 +42,8 @@
 #define RZN1_UART_RDMACR 0x110 /* DMA Control Register Receive Mode */
 
 /* DesignWare specific register fields */
+#define DW_UART_IIR_IID			GENMASK(3, 0)
+
 #define DW_UART_MCR_SIRE		BIT(6)
 
 /* Renesas specific register fields */
@@ -313,7 +317,19 @@ static int dw8250_handle_irq(struct uart_port *p)
 	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
-	unsigned long flags;
+
+	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
+	case UART_IIR_NO_INT:
+		return 0;
+
+	case UART_IIR_BUSY:
+		/* Clear the USR */
+		serial_port_in(p, d->pdata->usr_reg);
+
+		return 1;
+	}
+
+	guard(uart_port_lock_irqsave)(p);
 
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
@@ -326,20 +342,15 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * so we limit the workaround only to non-DMA mode.
 	 */
 	if (!up->dma && rx_timeout) {
-		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
 			serial_port_in(p, UART_RX);
-
-		uart_port_unlock_irqrestore(p, flags);
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
 	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
-		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
-		uart_port_unlock_irqrestore(p, flags);
 
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
 			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
@@ -347,17 +358,9 @@ static int dw8250_handle_irq(struct uart_port *p)
 		}
 	}
 
-	if (serial8250_handle_irq(p, iir))
-		return 1;
-
-	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
-		/* Clear the USR */
-		serial_port_in(p, d->pdata->usr_reg);
+	serial8250_handle_irq_locked(p, iir);
 
-		return 1;
-	}
-
-	return 0;
+	return 1;
 }
 
 static void dw8250_clk_work_cb(struct work_struct *work)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f7a3c5555204..02576ed30abb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/lockdep.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/sysrq.h>
@@ -1782,20 +1783,16 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 }
 
 /*
- * This handles the interrupt from one port.
+ * Context: port's lock must be held by the caller.
  */
-int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
-	unsigned long flags;
 	u16 status;
 
-	if (iir & UART_IIR_NO_INT)
-		return 0;
-
-	uart_port_lock_irqsave(port, &flags);
+	lockdep_assert_held_once(&port->lock);
 
 	status = serial_lsr_in(up);
 
@@ -1828,8 +1825,19 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		else if (!up->dma->tx_running)
 			__stop_tx(up);
 	}
+}
+EXPORT_SYMBOL_GPL(serial8250_handle_irq_locked);
 
-	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+/*
+ * This handles the interrupt from one port.
+ */
+int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+{
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	guard(uart_port_lock_irqsave)(port);
+	serial8250_handle_irq_locked(port, iir);
 
 	return 1;
 }
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 01efdce0fda0..a95b2d143d24 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -195,6 +195,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
+void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
-- 
2.39.5

