Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0423024C;
	Fri, 21 Mar 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581294; cv=none; b=Kyg3ZTO2lcVk4Jn7KTO/kJpPqLJ2L4IKHP5lATisuYdzA9rp9DVbUD7U25Luj33Yz74CM+hDAUvZLj6NLGNnLu5HwgyZU2Q402tVj+Qnj5aNRmm+jCk5qLyJCKIICnr0ROJRL8AVPJ6K+VGMTuJRtZxB9mOemr8Blb26qUnkMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581294; c=relaxed/simple;
	bh=HfUyjAeNkMQbSIhZ4RNqjqKd/mMVsN76s8xFenDTwr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqbGALaoIpWQJxIRHFmoDYYATN547rK8FrzrcXyuF12IMpj5l0VSls/aonTDUe1Icd/4MH9rf0LLN2EQ1rAcXXMDy/yFG7VWHxiP/737zYLvhL4EpQDu2tID/BYSOmpCLsSTY2AHe9XThO/qI8+FtJ4gY55Db/fnbtc6RxOqRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkH5W2Oo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkH5W2Oo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742581292; x=1774117292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HfUyjAeNkMQbSIhZ4RNqjqKd/mMVsN76s8xFenDTwr0=;
  b=UkH5W2Oo8J0Yx0jkfsWxBc3zVp27ASxfHhhBZUaqqlDqBHZx2LeNzUcy
   wBbf8W8qAXHo9BO4tU13BTae0QjsrmLJd3dy/u7CpOgYVUpU5Or29qhcU
   NvwBXSIa2Zl7D3GKbJ35jq4OFWHv/u4D4eEYn0IS3dYajqLK6ExGENcHG
   q26wJIDkV+HrRvvxrcFgJxSOh4IctTuUHVfSh/Xp2ERK6pjzRYeOkzRgo
   WOJ2w1SiPdy+wcxhIhIleu/VTZsn54sFpfxBqBuEXJsU2QNSnXxRmTofb
   rJTSGW2xob+f6L7BaD67UpECBQ0wSVpOZ3EhFP73nSCek5GVNqv51jcrM
   g==;
X-CSE-ConnectionGUID: CKu4JEBVTdy8ashozaivPQ==
X-CSE-MsgGUID: k6doNIWgSwazlat+k3Iukg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44046760"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="44046760"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:21:30 -0700
X-CSE-ConnectionGUID: +KItHubUSdS0t9v3NeifzQ==
X-CSE-MsgGUID: Y5zFeKbETmaRpZkww8pfaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123433917"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 Mar 2025 11:21:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E45AA6D4; Fri, 21 Mar 2025 20:21:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 5/7] serial: 8250_ni: use serial_port_in()/serial_port_out() helpers
Date: Fri, 21 Mar 2025 20:20:16 +0200
Message-ID: <20250321182119.454507-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
References: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are serial_port_in()/serial_port_out() helpers to be used
instead of direct p->serial_in()/p->serial_out().

Use them in various 8250 drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ni.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index 8bb8bb7bb4f2..15bee1b7dc2a 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -90,10 +90,10 @@ static int ni16550_disable_transceivers(struct uart_port *port)
 {
 	u8 pcr;
 
-	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr = serial_port_in(port, NI16550_PCR_OFFSET);
 	pcr &= ~NI16550_PCR_TXVR_ENABLE_BIT;
 	dev_dbg(port->dev, "disable transceivers: write pcr: 0x%02x\n", pcr);
-	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+	serial_port_out(port, NI16550_PCR_OFFSET, pcr);
 
 	return 0;
 }
@@ -105,7 +105,7 @@ static int ni16550_rs485_config(struct uart_port *port,
 	struct uart_8250_port *up = container_of(port, struct uart_8250_port, port);
 	u8 pcr;
 
-	pcr = serial_in(up, NI16550_PCR_OFFSET);
+	pcr = serial_port_in(port, NI16550_PCR_OFFSET);
 	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
 
 	if ((rs485->flags & SER_RS485_MODE_RS422) ||
@@ -120,7 +120,7 @@ static int ni16550_rs485_config(struct uart_port *port,
 	}
 
 	dev_dbg(port->dev, "config rs485: write pcr: 0x%02x, acr: %02x\n", pcr, up->acr);
-	serial_out(up, NI16550_PCR_OFFSET, pcr);
+	serial_port_out(port, NI16550_PCR_OFFSET, pcr);
 	serial_icr_write(up, UART_ACR, up->acr);
 
 	return 0;
-- 
2.47.2

