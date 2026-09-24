Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECC47D931;
	Thu, 24 Sep 2026 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252757; cv=none; b=rLUVqtNbIKKRejhS7c3aRslm4yfeREIjhwE2ii/yHTpfUGXEhzjy4JEhQRpddm6wjMMC9YrDAxLoYq+HcthhuWwPlabvMWJtsTQK4glEQ/DMZXrMdht9DSFxMO3IvX074/ecpf8o5RALTPWukl1DSwSnad1RQQwrurQ3UTO0zSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252757; c=relaxed/simple;
	bh=AoakT/OhXCFnu1Bmiu2d4H1OY/GBLtdyZbBIaCT0gg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7hhVh0TEAhHorVTu1mZDc2hcyKw0uM8wly427BbaX8L2X1Kevl0dZCM5KsOrKQfsM0zJgiy/PMRJbtRkrx2oZG9aRu16aTLDL8twrqr0Yz54kjyml5FCjmu9rmi1sE5C6bCMAz03SZ5PShXIg0VBt708bzKSQ1X+BOocv0500Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSQkbVvi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSQkbVvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790252756; x=1821788756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AoakT/OhXCFnu1Bmiu2d4H1OY/GBLtdyZbBIaCT0gg4=;
  b=kSQkbVvi8IvgbnEcEV4XJzDYX5DINi6p8TRfJxBfoEFRzRUGFWkAreeM
   9WBq4SgyEChiwRRg4lG+pQ5nsINV2qzM202N1pLfJF3GddkJaXbY/d6/N
   ZXQBwsBsLNNhjvT5Ay6TJQL9yCObVJK4Ahfzd7SOUNVx2GPPXG0YE6HQR
   +Im37bRNidnOPKy81orSaMQTF48m5EtfG3mB4/g12jNzm0GW40nP4uv9B
   c98bvOqXBiFVPO0fGF2wEYPDCOJV/qh0D4ilGOBAp/zqNb4a8e8f9+AC2
   7YJzXdTrOObvU8cRdIXhmrTYY3JZty2trcvk0nQHOqVTKJFaJsvZI8NEw
   w==;
X-CSE-ConnectionGUID: bx4uipanTLylK7UvtzW/Vw==
X-CSE-MsgGUID: S2aRQrpfSXGZpyVi4TCraQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89926563"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89926563"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:25:53 -0700
X-CSE-ConnectionGUID: DXTNQMG6SOqU/uZp3WXjvQ==
X-CSE-MsgGUID: nxOemAI0S4CA2f2tw327JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311926430"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:25:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BD7669B; Thu, 24 Sep 2026 14:25:50 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] serial: 8250_port: Remove redundant pm_runtime_mark_last_busy() call
Date: Thu, 24 Sep 2026 14:24:19 +0200
Message-ID: <20260924122549.668680-2-andriy.shevchenko@linux.intel.com>
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

The pm_runtime_mark_last_busy() call is redundant in the wrapper function
as pm_runtime_put_autosuspend() already calls pm_runtime_mark_last_busy()
internally to update the last access time of the device before queuing
autosuspend.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 38fa45e74a37..c0bcc0742a60 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -526,7 +526,6 @@ void serial8250_rpm_put(struct uart_8250_port *p)
 {
 	if (!(p->capabilities & UART_CAP_RPM))
 		return;
-	pm_runtime_mark_last_busy(p->port.dev);
 	pm_runtime_put_autosuspend(p->port.dev);
 }
 EXPORT_SYMBOL_GPL(serial8250_rpm_put);
@@ -667,7 +666,6 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
 	rpm_active = xchg(&p->rpm_tx_active, 0);
 	if (!rpm_active)
 		return;
-	pm_runtime_mark_last_busy(p->port.dev);
 	pm_runtime_put_autosuspend(p->port.dev);
 }
 
-- 
2.50.1

