Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D11CD0C;
	Fri, 17 Jan 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123198; cv=none; b=BccKbSyQ/rGbmsO0ALXZY49cSTGJrolB533gMnNO2XOVVtq9B/KjMbiaxvhOLT4bbW+c+AB+vns8mv68uPyXG7qN15Hf6mpk72F6czdVQTl9vh9GQytMBB4fQDdlBAS0TF7bySaGYriwBr89aoN4Tq7MxonWZzE4o5n+rejxX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123198; c=relaxed/simple;
	bh=BFB2UZU6fXF/mH75+gywyKyHONXhwAtQ0e0ilpRzxPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYO+ui8/bYXgREMpVSn1r0Lq+DC1p+zR4R24FbucrhzH4K7SluazuaDxfe3n1bqQqXHVLR8R4tt3UIsXV5bUSCRrDvDel0hQUzRCTHKjt96k8CfUCblgudrMLx2AsYBoHzhkho43YaHcgdxCS9cTRbjC1LxJmw6191eWbMZH6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqMbjQs4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqMbjQs4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737123197; x=1768659197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BFB2UZU6fXF/mH75+gywyKyHONXhwAtQ0e0ilpRzxPA=;
  b=IqMbjQs4hbxEiUvZ10f7VGpZZ0iWPNQx1m0hM51Peg1YmzVFGuqLO4Cp
   SS280kA3iSvaHBUPSb73jGs+rv2ndunU/TcJci4hud5q6kVrmAyHlYz/r
   mZSLBNcDzCKDjGCGoS3KsTuGs1LMsvpKtPpa2gCS4zbkPql7qyeOdGPPt
   IF7mgCuX6FzMivufnpCoB4DmewtZVnt3bTcTKgvHEmTPBAxXahYEIH7bj
   ta/PFxcy90H3e0Da5Ei94P//tjMMhia4mr1CBiua2rph2DpBEzXGIZFTR
   mMDNTuq68QU3LuuQFytm1CTsQ3qkz5RIx8ayhHzzY0FqkuAkpebK6N8lu
   g==;
X-CSE-ConnectionGUID: rUamYxHJRMqO5AljHKGHpw==
X-CSE-MsgGUID: kvf8TI51SXako11EXFx/zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48948930"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="48948930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 06:13:17 -0800
X-CSE-ConnectionGUID: ZZpsXy81S7KeREpUaiPhXQ==
X-CSE-MsgGUID: DuqxEVCxTSe+PzruC9pVNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="136651032"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 17 Jan 2025 06:13:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CB1EF10F; Fri, 17 Jan 2025 16:13:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: pch_uart: Remove legacy PM hook
Date: Fri, 17 Jan 2025 16:13:12 +0200
Message-ID: <20250117141313.592645-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy PM hook was never implemented. If we would like to achieve this,
the entire serial subsystem should switch to use runtime PM first. For now,
remove unneeded code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/pch_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index c7cee5fee603..508e8c6f01d4 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1515,7 +1515,6 @@ static const struct uart_ops pch_uart_ops = {
 	.startup = pch_uart_startup,
 	.shutdown = pch_uart_shutdown,
 	.set_termios = pch_uart_set_termios,
-/*	.pm		= pch_uart_pm,		Not supported yet */
 	.type = pch_uart_type,
 	.release_port = pch_uart_release_port,
 	.request_port = pch_uart_request_port,
-- 
2.43.0.rc1.1336.g36b5255a03ac

