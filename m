Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FE411601;
	Mon,  2 Mar 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465264; cv=none; b=jVwHyQGwjjgodIb0LMHNDnyEAcsTqrJrj7/GuW43mNZftCpfCoft1H3t3CNh9TJolJBOWOlq28NLndYTofTa7aMCTXDGkvHY287Ayl2yWpaW6EeAxgiI/V1wO+vWrGmj9jwJLTz2uk7KUI7eGxjRO0BX8FR4HXzbW25AUamKhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465264; c=relaxed/simple;
	bh=IRUU25uFX8wL2H//YnW8V4BYBwLwydKClI72Fv/hVfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5ChQk8flV/xWP60h64FhkOpJ/d+Gqs6AFU6L6EihRAQAgN3n3dOUFtgx/dD7AkY9gz58TnmqwdkSMODoQ6hDXVTtNL2WtHYHZT+ItfT3xy20FP+++Iu2MbCU5n+1jF8ZA6AsoxZ1YzfUF8LMBZd+3LzFAKEMHVU1g2nvc/izyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvmlkYNw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvmlkYNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772465263; x=1804001263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IRUU25uFX8wL2H//YnW8V4BYBwLwydKClI72Fv/hVfE=;
  b=PvmlkYNwOtjdtcWEvFzUBgtUYlY5MbnTLH1w4Jf4Lvmk4cPs5sl3SD/G
   jDe2+PqZAt07Pl+xc5iG0WWOHSsZ6tzHtEX/Y5PKWCE8vUyHwXKxgZRn+
   Jy46CIGMqSvbfBzap/+czKulXaUrnmsLU3XeNNZGqWiMTPT3yc2b4QVD8
   GgUTdHSSRHanFmq/w/J/IGJyF3bh4T/gxDIdfrBsJO/fnzHoTDkeRcuH5
   mdSPA4kCTH1H5cLlv9mRGpICwIuTh3gdQwDdFF9lW8sFsRmUM996SL2TO
   HAcBVFy/BjmrGK86GQtBvcX8YZ5ZHF2+a5y5U3G6kNVGO/VQWBeYjUDXm
   Q==;
X-CSE-ConnectionGUID: chzajDosQEiQX3QYyaWGBA==
X-CSE-MsgGUID: XCaDLTJyQHGjznWQ9cdg0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73540679"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73540679"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 07:27:42 -0800
X-CSE-ConnectionGUID: bL5aEzkgTu2FlO06mJdfHg==
X-CSE-MsgGUID: KfWd9tG3TSanum0ltfYvOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="221835089"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 02 Mar 2026 07:27:42 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0F24498; Mon, 02 Mar 2026 16:27:40 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_port: Drop duplicate NULL check
Date: Mon,  2 Mar 2026 16:27:38 +0100
Message-ID: <20260302152738.2498579-1-andriy.shevchenko@linux.intel.com>
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
index d99c5ad7e47c..2a830969d22b 100644
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

