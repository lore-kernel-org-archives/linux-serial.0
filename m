Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5630C62C;
	Fri, 23 Jan 2026 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189323; cv=none; b=b7HrjTOlOpwkT+R7dFACtx4GVYG6TSUTObVxvplxIymAS11cko+CogKDXuY20Mz1eLCWDNRCrSmnh8W98rlqKkFnE9ac5Lt81a65hbDFM6rAu3sDI+xltuy3c5N7QwGwsSjJ+71xov1i9sN/Up/6kaTWTDpbjJIT6Q8iETtud/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189323; c=relaxed/simple;
	bh=2dWnNmzb7kdoYu/PD6pyiEJIiUwlYW1/0OhxE1NbIxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzjQRSC04YeXl6zGERg6bfJl13dad2uuwsH+uvjD1UPLY4wNC64YiDE8s/bourHrVtGoVK+p9Ub1IIHB0tbY0CoqRBT7wL44hnn8iiZXHXirT0L/cFT5f9ueAvwkaJjLRbOr/jOEEqKPoyw2XNfvYr/C1N8iiZ8CNHK1zIlX1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IleKDwGh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IleKDwGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769189322; x=1800725322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2dWnNmzb7kdoYu/PD6pyiEJIiUwlYW1/0OhxE1NbIxE=;
  b=IleKDwGhhOSpj2092+CzP+fLvMbmRqzKVVDKWhhH2GPwfMe9uJz/KAlN
   wJuQngatiHCWCHyO79cPrt5ZxfT6fkN1zeJ1rCZgTFbpYoUHmD5/PX2hn
   7sXfSQt64jChoD37WVSGJw/WGYkY5ri0UtqZzKY+NShYWME/aRAerOsG7
   5hVfzq5KtidZXqnupgWRo9uD8HycWnXe6NHk0JRvldj8R7qc5uqs0kGCx
   K1FhNutjPLcwS2D2+1J0LxtH0/AV0vXNY4NgztMggG/IuiA8Tgh8Y+g1i
   Ghn4q8RUhxJMo+n3XWrZXQbtD0p/uuzCled0HJAwJAJXV42+PD04tkBwP
   w==;
X-CSE-ConnectionGUID: 3z0hbM/fTW2H7R37Vyxblw==
X-CSE-MsgGUID: ultqInyLTpiKhpdrle92tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="73034689"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="73034689"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:28:41 -0800
X-CSE-ConnectionGUID: 4OntvpuESQuTzmcsf2KtGw==
X-CSE-MsgGUID: b5mrnIYwRISuOQsPV+fjzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206326631"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.164])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:28:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: [PATCH 5/6] serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY
Date: Fri, 23 Jan 2026 19:27:38 +0200
Message-Id: <20260123172739.13410-6-ilpo.jarvinen@linux.intel.com>
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

Reported-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 02576ed30abb..fa982e5cbe90 100644
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

