Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444A18562A;
	Mon, 12 Aug 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477749; cv=none; b=IgabhvXV42A+Hwbm2SmA3nAdYyRN8BFXvdoC8xbNQX+AJZ1vEZe/D86XSTzJrKBpsOYb/7UF/WFHPkl8LXhFVzdL2rsAcjcLOOdBABdelTMQJJX8dGVNIWRYbq2nXhtn5Y3FhZ5yDlaQUvlm3I4A9BT7YGoylizkAkQp0OdLpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477749; c=relaxed/simple;
	bh=oEGMPDmJEbbGQUvoEJPDdDF4HFm+Jp4H/O+URWqPCbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Npvk4kOMS/ck9NsNuEJPM55uAs+9WJn94iWr2Wo/VfDmp+0e/FhzG2VvyCgd7xgU/XUgT0dv/vD+WFQA6GkZKL3oWo9lKqx4Y4Ol8qxccDPAlnNFhBbnuxZGS6x/eYRiJ6IoY9ovXWFJlu4NP5Yw7CzuU5Q/8Xc+ugFxlweCWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+tA8L6+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+tA8L6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477748; x=1755013748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oEGMPDmJEbbGQUvoEJPDdDF4HFm+Jp4H/O+URWqPCbQ=;
  b=X+tA8L6+Fw0EIIVCK+0rt7Y6S1YUdLQ+YWDGevVrMS0nHNJHGmmFnNmV
   u8RRe8IihMUZ6FW22PomEpD62DcUkUZPk7THK8toBJngSEiP2PYYD/4nJ
   Rhto0fsepV4gVQR5/dDibAAjplxX5RfiFQBPAtEAtVUTTYtqsoGkt8K5b
   v7zlgUx8TKnpKh47dWXhFGd1/u89uoKtIxQuCGlqfk7Td6P+tQpFvkSNw
   wt0YcwATbOqM/VL6JlLkgmvfvUTaB5SQbXb9LtB2PwnbcCfrrLi9bLzpW
   0n5RzFeQgi9VEzWFjUNMrjvn5/OKXdVLTFS6w/qj/f9QdR0MfRBEGSdAj
   g==;
X-CSE-ConnectionGUID: MQ1a7/PqRJKJhJ2W639XtA==
X-CSE-MsgGUID: S7D34IPvQTupwlni+92QKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46998244"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46998244"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:49:06 -0700
X-CSE-ConnectionGUID: yINk/hUzR5qX8nTFDGrzYw==
X-CSE-MsgGUID: /X7vflvCT3a6ywGaeHos3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62959170"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2024 08:49:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D93783B5; Mon, 12 Aug 2024 18:49:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 3/7] serial: 8250_platform: Use same check for ACPI in the whole driver
Date: Mon, 12 Aug 2024 18:47:05 +0300
Message-ID: <20240812154901.1068407-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>
References: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use has_acpi_companion() as 8250_core does to unify this across
the driver modules.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index ffa2b7b690d3..937eea3ebdea 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -165,14 +165,13 @@ static int serial8250_probe(struct platform_device *dev)
 	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
 	struct uart_8250_port uart;
 	int ret, i, irqflag = 0;
-	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
 
 	/*
 	 * Probe platform UART devices defined using standard hardware
 	 * discovery mechanism like ACPI or DT. Support only ACPI based
 	 * serial device for now.
 	 */
-	if (!p && is_acpi_node(fwnode))
+	if (!p && has_acpi_companion(&dev->dev))
 		return serial8250_platform_probe(dev);
 
 	memset(&uart, 0, sizeof(uart));
-- 
2.43.0.rc1.1336.g36b5255a03ac

