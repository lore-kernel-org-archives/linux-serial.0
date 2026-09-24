Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FB47A0DE;
	Thu, 24 Sep 2026 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252757; cv=none; b=o/pIJ43gt/utXqp6v6UrKH7iTYTaS0hq3S5KMoq+X7gvvYe82lUWPG0yXTbyIpx8NfMNe9vzoFP7PAjisEPqJqahISO4CNhWf3W6c3/cjiJAX98RpIaJCAFbd13+28YphKWMkhxYTau5N/rKDOk2ToAvvEfzHy0wI+ys97O7tEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252757; c=relaxed/simple;
	bh=XreMc2Q/ZPAaIdZ4AUBZ13ynfzFPuPpk7A3paWT+Y1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBU4d1t7jWwSdHfTZ162oBRT6Y3YL4ZHJfVg/4uCquuXx3jtJZJ7/kMJFA9MWv+dLCS48HdBco4CnBjjE/3UUg0bbi/+GFVPks85ymucicMrCNTQeDutApkFbRLSH3qXAnqrybklqPuVAWHceCpC9aewcXXzdBkQSV8v2QikuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWD5I8Ld; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWD5I8Ld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790252756; x=1821788756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XreMc2Q/ZPAaIdZ4AUBZ13ynfzFPuPpk7A3paWT+Y1o=;
  b=DWD5I8LdV6vpYUIq09+WOKLfzFLT7N54eIhYzch218jhHjPrtqhCLMfk
   0RMyEG/STPIwyjfjNQ1iGZa2H1nxBqC9tIYa7+H6epRXdHlPcEfTHOQE+
   5Odtlt97drrUAZs+Mo+q5BzV7BmaIiX9QA6e46NdxpdjxrtDYr5y/KY3Q
   R16yIhtQRfPLhk3bZImRM4CoA6lMMtKrZwV3F9a6v8dA+ohm/d6uCYsWB
   Y8eOpBWqEbQi0OjXwd1IGEGdJ+r44NfXE584L/WNQCn5w4Qjx5uctAHbd
   VhNBtCTOxWio3bhBn7coNtbrdcPXAqYA6idTny28rlRenon81noxl/8Mq
   g==;
X-CSE-ConnectionGUID: bE73HhnrROew+YTQesB2GQ==
X-CSE-MsgGUID: YRuPW2POQNKrTBHW8TbWAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89926559"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89926559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:25:53 -0700
X-CSE-ConnectionGUID: VZ6CvS9OTCWD5FVmuvKjYw==
X-CSE-MsgGUID: b++0Skp1SdKrsoIMrBoeow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311926429"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:25:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id C1CA59D; Thu, 24 Sep 2026 14:25:50 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] serial: 8250_port: properly handle runtime PM in IRQ
Date: Thu, 24 Sep 2026 14:24:20 +0200
Message-ID: <20260924122549.668680-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924122549.668680-1-andriy.shevchenko@linux.intel.com>
References: <20260924122549.668680-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_port.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c0bcc0742a60..1e62460b19ab 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1878,13 +1878,22 @@ EXPORT_SYMBOL_GPL(serial8250_handle_irq);
 
 static int serial8250_default_handle_irq(struct uart_port *port)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
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

