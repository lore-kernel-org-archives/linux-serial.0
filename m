Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AF3BE161;
	Fri, 14 Aug 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706687; cv=none; b=pzG4N5Hw1D5XWmyTpXD+4VsBi4ge+52RJL3jQNioYrqP5xTuc1Q2Sb7+3aTPdvtBFmjYEiNA2CDAgTfWhdWu56ZNhM0zDyXClZpP307W79PTz62pRgDGBaJNGgfrxt/liC1MVFjBV5sAEHHo5AgqjS8YBIqKCXBZloJHkWZojmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706687; c=relaxed/simple;
	bh=AoakT/OhXCFnu1Bmiu2d4H1OY/GBLtdyZbBIaCT0gg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA1ZknfQQBj1WO5Erm7p0oyC7ndTTACzHeW4ByxK2rZg9kTc23AsdouUL1AmPDrupE+/Hus3ZB7kec3ibjtYTyUjn0RmqwBOImOSTythcCLBrox7CPjDAFhQedp/SaQL1uE5ARTlDBCHy1fmbthO1iZUqvNa71lZF6Jc2t1NgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGerrYuB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGerrYuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786706682; x=1818242682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AoakT/OhXCFnu1Bmiu2d4H1OY/GBLtdyZbBIaCT0gg4=;
  b=CGerrYuBtZHO7QFdhqeVerBQFh9pcWRityxHCPAAFMi1Ikoi7jY0MMeZ
   VT9pNV2j4O68BXK6RMJUilmrbBLjMKT0L3AzKyJaNVvWCLs2Z3JpZBPLM
   VM545q6Nkb1YUjYvnyn1ABCwG5dlbiUEty0XnaKWjc3RexjB0AUholJvk
   GmWhEtUCYFoMr8cmK1reMEXiCu6et/D+6DlS7uB7UjjW6YiyrFVdvM0no
   du5OnBOrnrkW/wEEBX2GokvxrHHFOKY7/xkU3RT9CtWjofXXvTcdO+bNV
   AoWCPYwPOkNQ7D93SuTyASy+e3kwoEHsZZFv0I3icRm1S4oJYgUHtWBJi
   g==;
X-CSE-ConnectionGUID: z/18DtfjTl++iETs62UVLA==
X-CSE-MsgGUID: OKLDbKySQ6+psMsNzM0gFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="90960119"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="90960119"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 04:24:39 -0700
X-CSE-ConnectionGUID: KuOF8ti9TxefNNMCBtSESg==
X-CSE-MsgGUID: pUrOT0QXSv2TFWK7CaivIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267687676"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 14 Aug 2026 04:24:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 58F659B; Fri, 14 Aug 2026 13:24:37 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] serial: 8250_port: Remove redundant pm_runtime_mark_last_busy() call
Date: Fri, 14 Aug 2026 13:16:29 +0200
Message-ID: <20260814112435.3290545-2-andriy.shevchenko@linux.intel.com>
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

