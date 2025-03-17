Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B257191499;
	Mon, 17 Mar 2025 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204427; cv=none; b=jRHhKVLrgGRHLwUrLjCny1xWzPgASp52RUx0zyBRkEOriYJOJCoHbBd1zs7zaposvbJ8dNLr2TLCij795NtBKo/YUkPdRmn6yFrh1GduVJTxlUfAtlHs4wKX4PU4YaKqyOEdve8PRA4DWqiW6Ce8y5e7wJ3yWG1A2JGAg4zSYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204427; c=relaxed/simple;
	bh=a8FAVZT93WNJIUosFmPxF4OM0ULsyXrBe3/5i39RRq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uI35avQnM2Z/lUo5ZGI4Nj1FJQb1qR1Kt+t8fMlyFLIvUiIPjgrvuHhj2ZukJzuUFk2zavrN/+rUT337QSqGJC6q452kodqU2WeVXltMxfyttypI5rlE3XvXejKoYntHyUtKMgr4yst8ZhUDj0APEEx6BIeio05gGbuDwnBk4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcuzQPna; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcuzQPna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742204426; x=1773740426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8FAVZT93WNJIUosFmPxF4OM0ULsyXrBe3/5i39RRq0=;
  b=HcuzQPnanxahYA6Y1wp/wsp+/HClFlht5+MUYZDleJYMQMU6L1J3Rzcc
   /zd1Y2WWEroD1J26lhNU0FkDCm4fzchHswSHOzh7Gp7QlVFyOO/1FUS4d
   0mkgicCBH2wA2uEOTfum55hxqM9QkPqH4yi/ZXfNoryHQX3eR+b+lqN9a
   3/IUwMzEbJB/bVXq9auM3J8BcaqzWra6E7YWZydCg/KdYcrrWLcwusvfI
   rOFd+UK8qMt/NGoTtrbtnAEJQ1/Z9qFtfVbhEQ9EoDZN/EuEoKnzDzc2R
   4p7Na6AGWUrgVvC4831ChKsuQpYjYkIT9T7XQ5mJJYxhSARG5aOawrlDt
   Q==;
X-CSE-ConnectionGUID: FPgCKXKzQHmKwX2s9iGQZQ==
X-CSE-MsgGUID: VO4DiUfzQa6VWlQ/T3JpVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43157978"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43157978"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:40:25 -0700
X-CSE-ConnectionGUID: rA26HYXrSleqsZMdQPCq2g==
X-CSE-MsgGUID: oqBPdKD0TAyDoQC9gLuXFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="126747205"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2025 02:40:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 02A861D8; Mon, 17 Mar 2025 11:40:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Comment possible corner cases in serial_out() implementation
Date: Mon, 17 Mar 2025 11:40:21 +0200
Message-ID: <20250317094021.1201512-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

8250 DesignWare driver uses a few custom implementations of the serial_out().
These implementations are carefully made to avoid infinite loops. But this is
not obvious from looking at the code. Comment the possible corner cases in
the respective functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index af24ec25d976..49eda7f1fd0e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -107,11 +107,23 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 	return value;
 }
 
+/*
+ * This function is being called as part of the uart_port::serial_out()
+ * routine. Hence, it must not call serial_port_out() or serial_out()
+ * against the modified registers here, i.e. LCR.
+ */
 static void dw8250_force_idle(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int lsr;
 
+	/*
+	 * The following call currently performs serial_out()
+	 * against the FCR register. Because it differs to LCR
+	 * there will be no infinite loop, but if it ever gets
+	 * modified, we might need a new custom version of it
+	 * that avoids infinite recursion.
+	 */
 	serial8250_clear_and_reinit_fifos(up);
 
 	/*
@@ -128,6 +140,11 @@ static void dw8250_force_idle(struct uart_port *p)
 	(void)p->serial_in(p, UART_RX);
 }
 
+/*
+ * This function is being called as part of the uart_port::serial_out()
+ * routine. Hence, it must not call serial_port_out() or serial_out()
+ * against the modified registers here, i.e. LCR.
+ */
 static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-- 
2.47.2

