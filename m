Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D03B28D;
	Mon,  4 May 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907584; cv=none; b=uO9j9IhLai0FkobvYUfEmHU1FQEIIne0GkgpHw1sxkwWhCwQJtooBa82469kKIlGZjvK73pHkaoRS+f07PmmYhI7lE2GL4z5ZxQhOjWSU/7QEdjMF+oyaQpYQ+0PodXCHCXd6YiuDPDfYXnB52DYzUqRigjMitcYNNoF9aXNHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907584; c=relaxed/simple;
	bh=mFxTyYCCqcaLXsUguLJJSxq9TPOtldydAdfVl74XMjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0UdXQ7qzKjwwA0LNoKyA99+6rQdKTtPvD9JALiSRa+i1W0/gqSUKrp2uyR1fZKmnocrZPouTLy3loZmvdweg6Hx5soW9ygRS6JhZc253SakFZ1mDqDGlb8RFmGoSY/3LxOOHy43/ZY0igecSrJ+UngCYRjXfgi+FzlGxBuZBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUS0oeam; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUS0oeam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777907583; x=1809443583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mFxTyYCCqcaLXsUguLJJSxq9TPOtldydAdfVl74XMjo=;
  b=IUS0oeamCCYo2GK3suiq+gXwYVdUctf3l/Gr/Blu3KwwiBzzKVG7NcIA
   Bx8x0WzruksJjxWJPgYzLmb5499LW3flPInTic0KgZ4hBWcUW7GTexSY7
   Pm8LT1wnhYQntMXKixXzKLhemYH1gFkmu/T3si32IBBQDv08JWxdMjkp8
   fi0eGeHBpm+qEM4VHAhGTNH9Nipy0gq5soIVuaDEXenBJWwdwb3AKQ8gU
   Wg9zEBLi+puVda4uuCR1K5EQc9es53L4T1jlTBo0IBOVXk9bjCg0iuX8R
   NRBDBtPZAKpwDI2W9uH4BwR1tenWcDS7buiyp8eien2ccumD8wr5wRGq2
   g==;
X-CSE-ConnectionGUID: 8tKpeOr3RaK/Y5vMzoBAFw==
X-CSE-MsgGUID: twG4gB8xT36xgDAcKEP8oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78666100"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78666100"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:13:02 -0700
X-CSE-ConnectionGUID: /cfLz0zdSr2Ag97Sn7HwUw==
X-CSE-MsgGUID: wx32CZo8RYyhl+vzVrqraQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 04 May 2026 08:13:00 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id C37F698; Mon, 04 May 2026 17:12:59 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] serial: 8250_fsl: Export fsl8250_handle_irq() conditionally
Date: Mon,  4 May 2026 17:12:58 +0200
Message-ID: <20260504151259.483924-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move fsl8250_handle_irq() prototype out of the rest of 8250 generic APIs
in the header and export it conditionally when CONFIG_SERIAL_8250_FSL
is provided.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/serial_8250.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 1be007225b0e..43eb0d15012f 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -197,7 +197,6 @@ void serial8250_do_pm(struct uart_port *port, unsigned int state,
 void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
-int fsl8250_handle_irq(struct uart_port *port);
 void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
@@ -220,6 +219,10 @@ extern int hp300_setup_serial_console(void) __init;
 static inline int hp300_setup_serial_console(void) { return 0; }
 #endif
 
+#if IS_REACHABLE(CONFIG_SERIAL_8250_FSL)
+int fsl8250_handle_irq(struct uart_port *port);
+#endif
+
 #ifdef CONFIG_SERIAL_8250_RT288X
 int rt288x_setup(struct uart_port *p);
 int au_platform_setup(struct plat_serial8250_port *p);
-- 
2.50.1

