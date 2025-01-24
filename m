Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB4F189B83;
	Fri, 24 Jan 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735344; cv=none; b=jjRZMcIk5JNnSW/sCCYRez1EfDUd96RpgY4CBgcq8GVZ/dLmz6xQ3blgDrlx1LibpT3LxeKTzL8f1/+WywZoOkxPppekWdanNXnelH/rpBvg74C5C6KeIFg8pgKtxe7bcrayXnNENVa3z0WO+S5LYWFYBM8tiO57O+EQFcMZBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735344; c=relaxed/simple;
	bh=wasJGmB1EUv6O1UP8Zj6E42g8sSkse/lhLFsfPwH8gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhXrJLFNUdVSC1lhk5ILTB/WH4carbX69q7hIl6XjJNrwCxV3JjVHkQYMw6Nb6gifRr1PD+gI7CaCRb4cf9BlIDwBCR/ZrcO8oP/gcDC09oTmpz574Ns6FmDVmAI63aoXAV3eS3N3v6iRbTZrwwCJ2SAEeYaClm25bkW3VHPNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BITJUGo/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BITJUGo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737735343; x=1769271343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wasJGmB1EUv6O1UP8Zj6E42g8sSkse/lhLFsfPwH8gA=;
  b=BITJUGo/gUkSemlouzdldgWwI+LsO8MU4lFd2eJ+cl1fFMbLbayIXQ20
   cxmHu4vNNDoZsms/JtUR6pmIT1V93fRG2Qd64BeOvyw+6SPlgDoLvY53r
   OYnbgqMoUbcg+3GCREeKfQXschxM3PZb+6jBHMmB6BVtsSexYHAGYYsw+
   KwH7URM44oCC7oemrtTKuJJXKTkteN6TwE87bujhLUf4P25I/jXfGNgkK
   5VAiU5b6Mk8UqQvG1lnVKfrvQWnbNnAuQeeIAKg67yxG6OcyoBtrMx0vU
   tJh4oY5+RJtMEww81MPs+PqCQtwEBIEb4wdYUCzMr9byYs2XMe14Xuefw
   g==;
X-CSE-ConnectionGUID: XKQ1gZTQTSy6G2rTO3iBFQ==
X-CSE-MsgGUID: 42l4fYz/REiful0jWSjmcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38152887"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="38152887"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:15:41 -0800
X-CSE-ConnectionGUID: Xw8K7ejYQ9KyI/H34B5VAQ==
X-CSE-MsgGUID: sfpIvmzaQbKCD95lTIobqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="107612354"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jan 2025 08:15:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A2D93164; Fri, 24 Jan 2025 18:15:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/6] serial: port: Assign ->iotype correctly when ->iobase is set
Date: Fri, 24 Jan 2025 18:10:46 +0200
Message-ID: <20250124161530.398361-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250124161530.398361-1-andriy.shevchenko@linux.intel.com>
References: <20250124161530.398361-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the ->iotype is always assigned to the UPIO_MEM when
the respective property is not found. However, this will not
support the cases when user wants to have UPIO_PORT to be set
or preserved.  Support this scenario by checking ->iobase value
and default the ->iotype respectively.

Fixes: 1117a6fdc7c1 ("serial: 8250_of: Switch to use uart_read_port_properties()")
Fixes: e894b6005dce ("serial: port: Introduce a common helper to read properties")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index d35f1d24156c..f28d0633fe6b 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -173,6 +173,7 @@ EXPORT_SYMBOL(uart_remove_one_port);
  * The caller is responsible to initialize the following fields of the @port
  *   ->dev (must be valid)
  *   ->flags
+ *   ->iobase
  *   ->mapbase
  *   ->mapsize
  *   ->regshift (if @use_defaults is false)
@@ -214,7 +215,7 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 	/* Read the registers I/O access type (default: MMIO 8-bit) */
 	ret = device_property_read_u32(dev, "reg-io-width", &value);
 	if (ret) {
-		port->iotype = UPIO_MEM;
+		port->iotype = port->iobase ? UPIO_PORT : UPIO_MEM;
 	} else {
 		switch (value) {
 		case 1:
-- 
2.43.0.rc1.1336.g36b5255a03ac

