Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550A2F3635;
	Thu,  6 Nov 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429129; cv=none; b=U8JZFR5/8SP+QkogRd9bln3kiD2/Gf5kO3M4bRt+lJOLzIFTS532HIvJ8Wx8ta+IQlJftiRZ3I+TELRrEUVJQ1PtWj+aNfg0KUwn5YwNtDAPKiIJtw3XinK9eyoew9fHZOYEUbSSjSDD7XUocCSd68IZEwbyQtzNMYUtIAWtzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429129; c=relaxed/simple;
	bh=2CRYaZndD1gndlDnBYUKTLE3Qu+hrfD9Alkho2WLGrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozc76ERmZUgfkusjJmgKIA9gR6AZOJMPTS4kz/n8ZfhzwbouRUxXVTEaLFs5J+Nz+r9rfy0JhHHOKTnJas1IsOJNEkA6slxceHKic02D5D+6oKqT86OAkRTOG7buJXpWcItokzWIIavz8yuDTbCEvUCUv/xJp2SAQk6ZsYpFjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIBTz3z1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIBTz3z1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762429127; x=1793965127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2CRYaZndD1gndlDnBYUKTLE3Qu+hrfD9Alkho2WLGrI=;
  b=jIBTz3z1sD9VY52cLuW28AmsDpEBdb2XXQIJujhEhNR913l9PprTm+S/
   KOCnIcEUmZ26j35erwN3eek/eHnsyCOb14Pl8HegvBfpLM/6lCvf3kTjG
   qRmTJR83EtBVPEyJP8SJq4qoUIT0P43dhl3wgLT1TaLzdOg+9G4pgNZNR
   +3OM9afLgWuzSMOby1hTbjnbegWnUJb4AVZb2DBZ/zZSBXRxr0ebs5JrX
   4wVjYmP1WWqiu3PWgi7ccFux40Hoxz8+XVsdsmHjhHH1+5RYLgRV5fSiW
   hqBdJrY8nd0cw9BNjiq+dBNlMp6YwHlEM6O2/6Qa275MA43nVK0rK2/70
   Q==;
X-CSE-ConnectionGUID: IkgH4/dYRH6NkmhnrkOIzQ==
X-CSE-MsgGUID: AmOX4Fb1T4aEsT+gcn/Wzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="82192407"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="82192407"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 03:38:20 -0800
X-CSE-ConnectionGUID: MJ3j9sFwRhGNVSxH5Pw7EQ==
X-CSE-MsgGUID: iHrZrE8TRu+XWVEspPhGqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192785024"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 06 Nov 2025 03:38:17 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0F98A95; Thu, 06 Nov 2025 12:38:17 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: mux: Fix kernel doc for mux_poll()
Date: Thu,  6 Nov 2025 12:38:15 +0100
Message-ID: <20251106113815.2302539-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The validator is not happy:

Warning: drivers/tty/serial/mux.c:351 expecting prototype for mux_drv_poll(). Prototype was for mux_poll() instead

Update the kernel-doc accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index b417faead20f..3a77a7e5c7bc 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -343,7 +343,7 @@ static int mux_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 /**
- * mux_drv_poll - Mux poll function.
+ * mux_poll - Mux poll function.
  * @unused: Unused variable
  *
  * This function periodically polls the Serial MUX to check for new data.
-- 
2.50.1

