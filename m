Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98622FE03;
	Fri, 21 Mar 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581292; cv=none; b=kR4TH9Q5aqCTvWvCGKAOWMqzYfEi9aP0RnLAEpr9hG6lu1LJTNruFoMM+81JZZVxzAdSON026YIyipgBpAoYhv4tV2Wg2KgU3O0uEAMG6MUoWRI1IE9JdcWMOLmiwDYoDVn5T4S5d2FTjjdd8xjDFS0sPexmX7R80q3UDaAuXBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581292; c=relaxed/simple;
	bh=H+LCNSxdQS34wY23ObDHsrVq1Z7QJeoK5FyXJLKhpEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5OimKedEPju8WcaWseu371ldgodZG2BPbR2/5avB75KC8ZMY6wxv2H3T0YisdFSJrYV+X037/1ugwnAk3mPDVPDOE/ByFKyd0slRBkHhi+f2NgisJuEebt8lD9gLokDfIS9Q15NqI4BATA7bI/BhrGfXNRuR+NK1ezHZC61kuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJwUsEcM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJwUsEcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742581291; x=1774117291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+LCNSxdQS34wY23ObDHsrVq1Z7QJeoK5FyXJLKhpEs=;
  b=MJwUsEcM149pIcxC+UHZE0yF+xhTuwNhIZePbfG/W+yduu38n4KQfC0m
   77rxDVc2aWZLETSvYaM1Lx3wWmSZx61D5335IPp4b/m6APvl0w9OBtbpV
   aV/k6Jj12C0Q2etP0NBbxlYLaPTkhXATvo1t7ltM1xrRit++lJISBwhkg
   GxMvCF8Y/oHaWcu1GaDkhTmF3u/OfRuYonRDR+O6+nQloBKGH1+xhZQPQ
   QzdTb9Skr768tGiCnZnEytqJ6I+4C+Rx+FhGkTM7trgybEEspKTG50owx
   niQnhdWmx//7qYW0RxP5Mu0YTo8NzQEbKFNHpUobZdbsAH8YTVk4PvXZX
   A==;
X-CSE-ConnectionGUID: v/yIQCDgR2aVkGxRI7DvPg==
X-CSE-MsgGUID: MSp8v0uQTxCINxTkG3X+Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44046755"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="44046755"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:21:28 -0700
X-CSE-ConnectionGUID: 9VnmNasrQc2t9qgOp11WEg==
X-CSE-MsgGUID: KlFagwiEQSW+0puCyLgPHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123433903"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 Mar 2025 11:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C626D214; Fri, 21 Mar 2025 20:21:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 3/7] serial: 8250_ni: Switch to use platform_get_mem_or_io()
Date: Fri, 21 Mar 2025 20:20:14 +0200
Message-ID: <20250321182119.454507-4-andriy.shevchenko@linux.intel.com>
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

Switch to use new platform_get_mem_or_io() instead of home grown analogue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ni.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index 562f7f29e209..2dc510c0a5ef 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -224,26 +224,26 @@ static int ni16550_get_regs(struct platform_device *pdev,
 {
 	struct resource *regs;
 
-	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (regs) {
+	regs = platform_get_mem_or_io(pdev, 0);
+	if (!regs)
+		return dev_err_probe(&pdev->dev, -EINVAL, "no registers defined\n");
+
+	switch (resource_type(regs)) {
+	case IORESOURCE_IO:
 		port->iotype = UPIO_PORT;
 		port->iobase = regs->start;
 
 		return 0;
-	}
-
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (regs) {
+	case IORESOURCE_MEM:
 		port->iotype = UPIO_MEM;
 		port->mapbase = regs->start;
 		port->mapsize = resource_size(regs);
 		port->flags |= UPF_IOREMAP;
 
 		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	dev_err(&pdev->dev, "no registers defined\n");
-	return -EINVAL;
 }
 
 /*
-- 
2.47.2

