Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231383A3821;
	Fri, 14 Aug 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706696; cv=none; b=t8XpoEkROGJcjiqFg/498b3XBNq2GACRsJhRc+POSWDTbFqw+keP3Ae9GKscbylQMFaf6WVARKE7BTH5CZNHIFzVc9IKXRcmAfQ3Tm5ckzsQ1UCIQUn2pKgkNovi87h8pvHdLw7yMo5GgL7qvYgyxpapszBN64KwGuLROjREWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706696; c=relaxed/simple;
	bh=2MN5QDzcZRZu9RaVXyC+7LiIMo4UEDsSoXp5/wb9FYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDsc3vT/HTlG31p0cwJk6/2zCd1rYBAFwWPYJsx1f9I7B2mO6loxlVzyAOB+tOE66ZSvdrey8tPwiznN13jgdvwAey0674JKmdqZgtP2q9JPq9hel5ggC1GIG9QtwcMhnerm1TV996igFaf7sW017V8ic3IwPyFRTHDmII2hbAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F02hETXD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F02hETXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786706690; x=1818242690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2MN5QDzcZRZu9RaVXyC+7LiIMo4UEDsSoXp5/wb9FYQ=;
  b=F02hETXDHBnE8enXBltW5TudkzCDUfG9LAD6iXr6bEjNhhqvDYi6aNdb
   qwVBEsax28BSsmLSPpv6HwRORsAxQmNsnW2/ZQLr0NnHxps4+KgAHJPEH
   B2OG6b39rNztss7QH4aB0fQLFNYjPau+/3Wpu6hLurp+Q1/a/nGg1z2Ig
   1VGDHgT2nyyZ5I7lnMTXnz01Y68uzRcXoGQeYGeiyEBXhIvie8KOt3zhU
   9OrK/1oUTXJ0rj4X/+d7XYyyC9zndVBzoYMWuZ2FCyrphowMEXGdPDhDA
   swpMpLuY7rYKPYBdXknBadxRwwRAmHSRUM2kSdfxs/Kjp349zHY94T8la
   w==;
X-CSE-ConnectionGUID: kXGgM6q0Qf6m1PX/fujyNg==
X-CSE-MsgGUID: wUhYO/K7Qf2V98EoWz4k5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86403724"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="86403724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 04:24:39 -0700
X-CSE-ConnectionGUID: 5U9X5yOFReG6WinLMaD10A==
X-CSE-MsgGUID: b0mLCjKWQ7WiIMD62ekYxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="266187692"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 14 Aug 2026 04:24:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5DCAE9D; Fri, 14 Aug 2026 13:24:37 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] serial: 8250_port: properly handle runtime PM in IRQ
Date: Fri, 14 Aug 2026 13:16:30 +0200
Message-ID: <20260814112435.3290545-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260814112435.3290545-1-andriy.shevchenko@linux.intel.com>
References: <20260814112435.3290545-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't and basically don't need to call runtime PM in IRQ handler.
If IRQ is ours, the device must be powered on. Otherwise check if
the device is powered off and return immediately.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c0bcc0742a60..01703a707c22 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1880,11 +1880,21 @@ static int serial8250_default_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int iir;
+	int pm_status;
+	int ret;
 
-	guard(serial8250_rpm)(up);
+	/* if driver suspended, return, probably shared interrupt */
+	pm_status = pm_runtime_get_if_active(port->dev);
+	if (!pm_status)
+		return 0;
 
 	iir = serial_port_in(port, UART_IIR);
-	return serial8250_handle_irq(port, iir);
+	ret = serial8250_handle_irq(port, iir);
+
+	if (pm_status > 0)
+		pm_runtime_put_autosuspend(port->dev);
+
+	return ret;
 }
 
 /*
-- 
2.50.1

