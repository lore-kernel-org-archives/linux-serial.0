Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05D1CD0C;
	Fri, 17 Jan 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123190; cv=none; b=GwOh5qAnM+t4evqqh7E+5o+BiLthOLnlHWNWYrdG5ue/+kt2oPsoxU4+HnOFI34yE+dZZLzmKRcnT26VOef7WNZLFgROlaOwHpTsRf9oZM++3HINdxvJmh7Ut4EezMTsVPQ0/C0r4ECilncuIp4Glx6sr0sv77teVOfqz3j7+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123190; c=relaxed/simple;
	bh=sP+GNNdVQKOSUfdq2Y60QFfSAjf/DRG7Pie3unL0SLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9CkMz/JllvYh2muQkpnEpG7L2Hfd08nuJAzeFz4uKt2ZvzblhKL+nKMl5sVHBhaAMs5/tAD+5Yw+bSxKUz+0q/yjX0OBtP8dx3w3/gsXRdmfQNpMVsEqmuQtV2PKkXRAr/mHknV1I62egIg/qcyWnJEnP+89IjC39abRovZV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGDpbycV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGDpbycV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737123189; x=1768659189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sP+GNNdVQKOSUfdq2Y60QFfSAjf/DRG7Pie3unL0SLw=;
  b=bGDpbycVkU6GM6/bK3QEms4jqOOCw8eamorVNxE5irNY0PM3beSzJXy1
   yHN2hHcqrZEdBZVduL9Pyc0etTZkKCZZUMfbJZLmY+Fz1AfCI4thyPcEL
   gKen1FERDdSqa8uK9dcA9yW3zvD+3WYbO1exzcjsHgjozoeKo/PR3D9n5
   tChWzLxTgAZpzwctXKGIFD4qW1X14Jf17u9j2f+af4jCRTdCruhPLdl4R
   R3jf8Al+7FeDluGnrpdRvJfBdBGsoLq2hTJsdLhMutVWwKoOoMmYHvuoI
   d/7eUidOUpkrl6u+mT8U5kKAEwtwgpteBo8z19XsLeVSxTUt4VhUZSOOH
   w==;
X-CSE-ConnectionGUID: fnc0oFOKR/iaZUMikIRNRg==
X-CSE-MsgGUID: 7L9hJIq3RKeP8F2POXdQUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48948913"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="48948913"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 06:13:08 -0800
X-CSE-ConnectionGUID: BdY+xT3jRnC5BG9BXJyxXQ==
X-CSE-MsgGUID: ZhomzqBIRTifZNRu5OmKtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="136651002"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 17 Jan 2025 06:13:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8162810F; Fri, 17 Jan 2025 16:13:05 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: mpc52xx_uart: Remove legacy PM hook
Date: Fri, 17 Jan 2025 16:13:04 +0200
Message-ID: <20250117141304.592611-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/mpc52xx_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 2204cc3e3b07..37eb701b0b46 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1351,7 +1351,6 @@ static const struct uart_ops mpc52xx_uart_ops = {
 	.startup	= mpc52xx_uart_startup,
 	.shutdown	= mpc52xx_uart_shutdown,
 	.set_termios	= mpc52xx_uart_set_termios,
-/*	.pm		= mpc52xx_uart_pm,		Not supported yet */
 	.type		= mpc52xx_uart_type,
 	.release_port	= mpc52xx_uart_release_port,
 	.request_port	= mpc52xx_uart_request_port,
-- 
2.43.0.rc1.1336.g36b5255a03ac

