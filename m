Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E37311977;
	Tue,  3 Feb 2026 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138716; cv=none; b=AlAJlFDnduddAD3gjECnlvozCUTWq2flK3wC0b/IDfWCXK+H+5VLZ9ri3B5o5iSueamwpqdp1w+3Ii7A3u6EEtYfhtfPYuaX4Zld98BTtyJ7wGwND7F5KL9K+aJbirrEj4xZBRNfOeWp9Xt3jjDiF3ChVHAVmjhQ5o8z0yND/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138716; c=relaxed/simple;
	bh=ejVkCJVGKKIGxoKchNEpNYHMRqXf+Z0GBtuR4yQEOCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWMmnTmzTnk85+dbO1VPFSbPHja44k1N0ITX7HjQNEYi1T5lO9ef7IbUoDlLff6onPRb5W4P5ZaUhdz04iant3s3iVB+X9Nx1cBoSrTRD4lhAZT3bZZ68sDKlqCOjUSIrzItC88Ko/Vj/AX0C6afsvcezbRLebqdNaTstpljmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSeytlDs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSeytlDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770138715; x=1801674715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ejVkCJVGKKIGxoKchNEpNYHMRqXf+Z0GBtuR4yQEOCY=;
  b=RSeytlDsmpmf3lBJavnRkBi49jazOIRYgFeqtoifXg9Kb8Gg0bm6AGr6
   fVdf21YzOCPd5JGWW3BWKXcii3l70nNKinnXhk4h5gemYzZIrlbap1B14
   WbX974uYP2NURYLcdy3EiddjqgNqkiGtlFnrhqcuuTbQ/yK5Qo9Du1wcb
   qGk/W4FXk61tmoMCkb6AmWJ/GrM2qYSQ1T96hePsBw+//AG/YPIEe2BoI
   MFPLQfvs/liDpf+3f7cXvNOMzqJttda9AWqlxPHdQnjrvnAzBXCA8j5Jq
   7oQC2HUv5390L2qIb+Nl1CRORnXQgZoG99D3LewBY+80fmMOKEFlEMnK5
   w==;
X-CSE-ConnectionGUID: 2ho0HajyQX672D4SMSICtA==
X-CSE-MsgGUID: ArmHS/TqQOaqdEuf+rcWaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71295039"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71295039"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:55 -0800
X-CSE-ConnectionGUID: WNHSnHV2RO6g6rJATrXSiw==
X-CSE-MsgGUID: JcMGIqyeROOTNmkv5K62+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210040788"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	Jamie Iles <jamie@jamieiles.com>,
	linux-kernel@vger.kernel.org
Cc: "Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 6/7] serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY
Date: Tue,  3 Feb 2026 19:10:48 +0200
Message-Id: <20260203171049.4353-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
References: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When DW UART is !uart_16550_compatible, it can indicate BUSY at any
point (when under constant Rx pressure) unless a complex sequence of
steps is performed. Any LCR write can run a foul with the condition
that prevents writing LCR while the UART is BUSY, which triggers
BUSY_DETECT interrupt that seems unmaskable using IER bits.

Normal flow is that dw8250_handle_irq() handles BUSY_DETECT condition
by reading USR register. This BUSY feature, however, breaks the
assumptions made in serial8250_do_shutdown(), which runs
synchronize_irq() after clearing IER and assumes no interrupts can
occur after that point but then proceeds to update LCR, which on DW
UART can trigger an interrupt.

If serial8250_do_shutdown() releases the interrupt handler before the
handler has run and processed the BUSY_DETECT condition by read the USR
register, the IRQ is not deasserted resulting in interrupt storm that
triggers "irq x: nobody cared" warning leading to disabling the IRQ.

Add late synchronize_irq() into serial8250_do_shutdown() to ensure
BUSY_DETECT from DW UART is handled before port's interrupt handler is
released. Alternative would be to add DW UART specific shutdown
function but it would mostly duplicate the generic code and the extra
synchronize_irq() seems pretty harmless in serial8250_do_shutdown().

Fixes: 7d4008ebb1c9 ("tty: add a DesignWare 8250 driver")
Cc: stable@vger.kernel.org
Reported-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index bc223eb1f474..fb0b8397cd4b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2401,6 +2401,12 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * the IRQ chain.
 	 */
 	serial_port_in(port, UART_RX);
+	/*
+	 * LCR writes on DW UART can trigger late (unmaskable) IRQs.
+	 * Handle them before releasing the handler.
+	 */
+	synchronize_irq(port->irq);
+
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
-- 
2.39.5

