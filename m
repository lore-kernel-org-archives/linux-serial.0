Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B922FE578;
	Fri, 23 Jan 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189293; cv=none; b=bceqLGqV9hIBlNFExohRxudLAw+jOoeEab01vatCXDFwMMPx0AAItsEAY3eJ5L/c2YaGszbKUb9phfNQCLBg1yXMu51zm7p97KRhtT9XFdA7Zi0YIL/dcYm8XrPoyu8zQg5CU0f0FF/A0IGpZFKXyY8rCaP0ZmkWBLoFaqsBIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189293; c=relaxed/simple;
	bh=jiuK9aLZnkoNECfZhRCc43h+6qeyyruzMVhcy2p1Dsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqAtIqZU7tMLOLwFnWVfI8dLJmzbQ8Mbr43PBGPaeE2X1ocEstlC9puK6hxX8CmiEcBvG3qyI7l5S+4EfdYzTLX3ME8oa3V5FRnvOR0N02Q3i7UqBDOOAgtHACAcJPI2xn5uIeALj88L2zD8dAQHClu+MXN0ZcOsU5s68Ibs81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqYbuDKU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqYbuDKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769189292; x=1800725292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jiuK9aLZnkoNECfZhRCc43h+6qeyyruzMVhcy2p1Dsk=;
  b=VqYbuDKU0GcSu+ajUEKRq8XziWhI2tDkMI99TvQSSPExe3eRhD0UOqTp
   FdnJkpQhcMnXMovXzNgub0Ciy27BLr1tFtt/E06fji7CNBCKvLShxn19m
   CBHdZoFJIJkje2CbuhYPj727kJKDSU3xKKoin1kJ3glJu66f5U7fa+MsA
   exUGBdbHYRk/R8pcUrM9AYXChaLhF1n2trHo+4CwxVimRs5GxjG1oP8YM
   K5KYA9unG3vnWQ9RufGcKEf0rU2uIWNKOGRdr9o8xv8PzqtcBX+y0m7Vx
   BEX/6kLI8TpIJdc2tfECmpoW3LZPzq1EGc5QQNR1s5mbTMDd+dhBh3JTR
   A==;
X-CSE-ConnectionGUID: 07d5gw/YR3WEFBxZ4mFK3w==
X-CSE-MsgGUID: 9O5hL9XORs2CZLbD1Lm9Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="88020940"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="88020940"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:28:11 -0800
X-CSE-ConnectionGUID: pHBumbBsRzmTystauVFoyQ==
X-CSE-MsgGUID: 5l9DrbmBT/OIa43TzhN8Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211580968"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.164])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:28:07 -0800
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
Subject: [PATCH 2/6] serial: 8250_dw: Avoid unnecessary LCR writes
Date: Fri, 23 Jan 2026 19:27:35 +0200
Message-Id: <20260123172739.13410-3-ilpo.jarvinen@linux.intel.com>
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

When DW UART is configured with BUSY flag, LCR writes may not always
succeed which can make any LCR write complex and very expensive.
Performing write directly can trigger IRQ and the driver has to perform
complex and distruptive sequence while retrying the write.

Therefore, it's better to avoid doing LCR write that would not change
the value of the LCR register. Add LCR write avoidance code into the
8250_dw driver's serial_out functions.

Reported-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 27af83f0ff46..57a760b43da9 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -181,6 +181,23 @@ static void dw8250_check_lcr(struct uart_port *p, unsigned int offset, u32 value
 	 */
 }
 
+/*
+ * With BUSY, LCR writes can be very expensive (IRQ + complex retry logic).
+ * If the write would not change the value of the LCR register, skip write
+ * entirely.
+ */
+static bool dw8250_can_skip_reg_write(struct uart_port *p, unsigned int offset, u32 value)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	u32 lcr;
+
+	if (offset != UART_LCR || d->uart_16550_compatible)
+		return false;
+
+	lcr = serial_port_in(p, offset);
+	return lcr == value;
+}
+
 /* Returns once the transmitter is empty or we run out of retries */
 static void dw8250_tx_wait_empty(struct uart_port *p)
 {
@@ -207,12 +224,18 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 static void dw8250_serial_out(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writeb(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
 
 static void dw8250_serial_out38x(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	/* Allow the TX to drain before we reconfigure */
 	if (offset == UART_LCR)
 		dw8250_tx_wait_empty(p);
@@ -237,6 +260,9 @@ static u32 dw8250_serial_inq(struct uart_port *p, unsigned int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
@@ -248,6 +274,9 @@ static void dw8250_serial_outq(struct uart_port *p, unsigned int offset, u32 val
 
 static void dw8250_serial_out32(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writel(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
@@ -261,6 +290,9 @@ static u32 dw8250_serial_in32(struct uart_port *p, unsigned int offset)
 
 static void dw8250_serial_out32be(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	iowrite32be(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
-- 
2.39.5

