Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF281A8F7D;
	Fri, 24 Jan 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735346; cv=none; b=X0wqcoWMBol6rTDowXb0n5MB1KuhXntenLjUfzB+txbvKsELCRlDl/2eE+n4YFUb5aHIpJxT6Ni+LzW7pzLzKkyEMmAtCu0vzpnO/lNIhGa2dyDSmCncUZLaN5/6kW0LcKYHfYERKOOOBktg/EaCl1TAbq1i51s6l+ICIxcI+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735346; c=relaxed/simple;
	bh=A0FojVXkgR8AphBPnWDLaNoXKasJEidZcTtNFSFW/GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofKQ308EWdF4u9wIr7NNQWtb7YAyxSxV4zDdSIhiMQnpLpGhVHV1uMPwSNHI4r+Oi6W8FV+OsM3lrjNoOHj0YluyzlZ/+QUiuC52hbp9ave0OFaCsTLVYz8VYwZ6T1CSrMUYSMQ5gSnWuHt4WaW4HGWBvssCYF5fOIdxxI9XYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDRz8DYI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDRz8DYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737735346; x=1769271346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A0FojVXkgR8AphBPnWDLaNoXKasJEidZcTtNFSFW/GY=;
  b=WDRz8DYI22cnNoxL+rJanynKD2SucAHtpubFhn+5SHouxYdDi287Dssh
   +5QHeUsxqe87SYGY/26LrHHOkbyNd0hoSvi0CIdpsFBZ5r7x7GEQecKli
   fvRVQ7/pqZmLU4MwE5cArwGWoyvDZKYOHJpqUe9KcTgtOkNoYM0StXmip
   F5UCJZW4E28TmrOvM3y6ZVwVzhBP/ziqP3dsT9VRhHAQwynfjFZq8xpkP
   MbrvS8WZn+NUD+gbmoraEL5vLAYxGVoq2ew6ImA+9yoLJixfHCDsvpfEr
   vJ4B3lP6ZrzhVdgru+ufDWFOtXHavQKtFTyOkdx7UQxqIeTe1DVnPv1Ns
   A==;
X-CSE-ConnectionGUID: lN2vHLIuQUqXV1D4IBhFyQ==
X-CSE-MsgGUID: 5ytmkB65QpGvEcjhq1tD9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38152901"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="38152901"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:15:44 -0800
X-CSE-ConnectionGUID: QX9lItmmQWSgoTpduHmCwg==
X-CSE-MsgGUID: v9Sh7zx0Tf2W4HusQ5GyjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="107612372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jan 2025 08:15:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DFD6F37E; Fri, 24 Jan 2025 18:15:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 6/6] serial: 8250_pnp: Remove unneeded ->iotype assignment
Date: Fri, 24 Jan 2025 18:10:51 +0200
Message-ID: <20250124161530.398361-7-andriy.shevchenko@linux.intel.com>
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

If ->iobase is set the default will be UPIO_PORT for ->iotype after
the uart_read_and_validate_port_properties() call. Hence no need
to assign that explicitly. Otherwise it will be UPIO_MEM.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 7c06ae79d8e2..7a837fdf9df1 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -436,7 +436,6 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
 	int ret, flags = dev_id->driver_data;
-	unsigned char iotype;
 	long line;
 
 	if (flags & UNKNOWN_DEV) {
@@ -448,14 +447,11 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	memset(&uart, 0, sizeof(uart));
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
 		uart.port.iobase = pnp_port_start(dev, 2);
-		iotype = UPIO_PORT;
 	} else if (pnp_port_valid(dev, 0)) {
 		uart.port.iobase = pnp_port_start(dev, 0);
-		iotype = UPIO_PORT;
 	} else if (pnp_mem_valid(dev, 0)) {
 		uart.port.mapbase = pnp_mem_start(dev, 0);
 		uart.port.mapsize = pnp_mem_len(dev, 0);
-		iotype = UPIO_MEM;
 		uart.port.flags = UPF_IOREMAP;
 	} else
 		return -ENODEV;
@@ -471,12 +467,6 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	if (ret)
 		return ret;
 
-	/*
-	 * The previous call may not set iotype correctly when reg-io-width
-	 * property is absent and it doesn't support IO port resource.
-	 */
-	uart.port.iotype = iotype;
-
 	if (flags & CIR_PORT) {
 		uart.port.flags |= UPF_FIXED_PORT | UPF_FIXED_TYPE;
 		uart.port.type = PORT_8250_CIR;
-- 
2.43.0.rc1.1336.g36b5255a03ac

