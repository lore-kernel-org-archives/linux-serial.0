Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC7313E13;
	Wed, 28 Jan 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610457; cv=none; b=KrFUA1tNxKSVPEPUIOwKGMmthBpUPJaEfU5h5vUL/afrrCS9SoW7vRcdjkg6jcSOAOK7NmgYrhkgN4QFr052pX5jMFgfyBG+MYSFx8JEmSOvieQ1I6i2aD4XUMYgR2qJoMRVPDP4HzXeRDAgLnlgzk0Q+fGhJ3nsEk+9oyTYJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610457; c=relaxed/simple;
	bh=E0Puas+mh+KpJ/tkEX+mNm1ypymYaEPzs2JYMYE9FEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QntI8sFWL8vUAbBp7cRoL0ZlUOdu8YkToA6tuvutqmSRMYGkudyH+M9Pg2G4kzmsRiCg9F0+2hlKDiit95+t79QJx193z9KCMvj/NwhsRGkE6pKfNPC0qTs0CYr4eUGvnL1QGx9aSB72gvYG0uIuz/WOsp9mC/UTJkSm2+68pMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmUsc+bk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmUsc+bk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769610454; x=1801146454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E0Puas+mh+KpJ/tkEX+mNm1ypymYaEPzs2JYMYE9FEM=;
  b=NmUsc+bkfQpoM3LVt/zf5qlUjGCUHc1m9UzD+L+geReGRGwFT2TF3lqH
   TYopqNckI9NIj4BqrSVw3j9Kf6hg73g2y4RQGGnW2bWOpA2apQnaeRuZF
   N11IsO9Elfd9O1n4XqGEbLiQxISdtvLrnZDqIcY4xFUPO3F/8ZUbZEc56
   cdhGdyDmOgMGTMQmaklXgojCouF5D2y74YkUnRSe8r0T6SyvRra6BaxnX
   P6eQeP8MgOnw+plXs2OT7n015/jRAwlDWaX/1I39+rMjis9vOvgqPM48h
   bgSb+LCanKWuXaJ7MpIqe51SOcKH0TM3OCjit/CLxsLxi7gI3Sjnqwlr+
   w==;
X-CSE-ConnectionGUID: JwqWjAEzQ5ar/occYkR6Bg==
X-CSE-MsgGUID: HNEMNfOGRfiNN3Xu+ms9fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70021926"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70021926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:27:33 -0800
X-CSE-ConnectionGUID: dM4/VmKwQXaFJxfBG9nhfg==
X-CSE-MsgGUID: +oKpaI7xR7OHnwqFyviTMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213256617"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 28 Jan 2026 06:27:31 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 25EFB95; Wed, 28 Jan 2026 15:27:30 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_port: Drop duplicate NULL check
Date: Wed, 28 Jan 2026 15:27:26 +0100
Message-ID: <20260128142726.128175-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial8250_release_dma() is NULL-aware, no need to check this in the caller.
While at it, make sure DMA won't be used again, by NULLifying the pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 21fdf84f118f..c40d750d5a4b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2366,8 +2366,8 @@ void serial8250_do_shutdown(struct uart_port *port)
 
 	synchronize_irq(port->irq);
 
-	if (up->dma)
-		serial8250_release_dma(up);
+	serial8250_release_dma(up);
+	up->dma = NULL;
 
 	scoped_guard(uart_port_lock_irqsave, port) {
 		if (port->flags & UPF_FOURPORT) {
-- 
2.50.1

