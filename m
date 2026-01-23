Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA426A1AC;
	Fri, 23 Jan 2026 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189276; cv=none; b=R6A9dhbXx2vvz+Tr2nrTZB++vHvRAJSM1f3/APD1CymVw1JsecHSqMdFViJ5He7u9dra/cZ81WjAZqAKIZT/MT1uv1OxeMIm7FdN1aE/U9TL2uNJN82jaNe9zeqdTiTCNTVBKeZP3VSVSREYTJq2KfLId+src7GQg6RmActQ/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189276; c=relaxed/simple;
	bh=N2zo7xtBrhjnpwzCIzUD4Aey6ZZjnP51mHc+GEZyLF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=laKer7Y41h2GdZu81bFSLFBWRP2K4GHm9617hBPv2WFeWU4sLrfOE7wFnJeb4Co7FKHNfSJoVUeVv+gJ33Iqns1VP5yt2uFCICHgXDbYLXwESJzq4UiVoshu4CMx+aCdwPCMQ3z+S9xP5nDLgH6xQMTSvLrh8bUXZm5CB3z9E6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8xf1MNG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8xf1MNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769189274; x=1800725274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N2zo7xtBrhjnpwzCIzUD4Aey6ZZjnP51mHc+GEZyLF0=;
  b=T8xf1MNGdH97VgUvbtKJ1YewDv0pPRiDdNLm6Gn8pQr1WqUkISXv/7b0
   DfXvlxRmKH/eAaSI6NtyfDkbhPpLPcIW8eCZVlOgg3BwDquG9zX6zowEb
   6ixKHoMvxuIfXuq5JCGtIMlfofKCT57gj0XuuHSBxNtpjTAFfD+EKXRX7
   Gp/D9VAtSuDapc1jMY1PfVzLNeybbi7CZXn0nmGjHTg7NBFkBcfXi5UoZ
   Fq+i85ERVb6MFe3rNXbEc4jsKkZ6SVgQuVvljhfqhQq5GdTouaCH2Ho5n
   dWM5E8HLRvZiBQYqw1U/4RUYCBs8A6bxcCK4ZymkLfk6qHMCFqugpUAhM
   g==;
X-CSE-ConnectionGUID: wXDQ85NnRFiCJK31iuihQQ==
X-CSE-MsgGUID: QZy4zreiQGWsudd49r545A==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="88020867"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="88020867"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:27:53 -0800
X-CSE-ConnectionGUID: lofMWL34SKKVA6NVgwkcIw==
X-CSE-MsgGUID: /PCALg+CRBeOuIiqtcL/Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211580884"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.164])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 09:27:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/6] 8250 DW UART fixes when under constant Rx pressure
Date: Fri, 23 Jan 2026 19:27:33 +0200
Message-Id: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here are fixes to 8250 DW UART conditions that mostly occur in scenarios
under constant Rx pressure which are made complicated by BUSY handling
of DW UARTs (used when !uart_16550_compatible).

A few of the changes touch also 8250_port but it's mostly moving existing
code around (except for the extra synchronize_irq() in shutdown).

I'll do UART_IIR_RX_TIMEOUT move to switch/case separately from this
fix series.

Ilpo Järvinen (6):
  serial: 8250: Protect LCR write in shutdown
  serial: 8250_dw: Avoid unnecessary LCR writes
  serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
  serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
  serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART
    BUSY
  serial: 8250_dw: Ensure BUSY is deasserted

 drivers/tty/serial/8250/8250.h      |  25 +++
 drivers/tty/serial/8250/8250_dw.c   | 297 ++++++++++++++++++++++------
 drivers/tty/serial/8250/8250_port.c |  69 ++++---
 include/linux/serial_8250.h         |   1 +
 4 files changed, 301 insertions(+), 91 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.39.5

