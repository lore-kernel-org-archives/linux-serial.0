Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458418E02D;
	Fri, 24 Jan 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735344; cv=none; b=s8zNuUKB9vMD4sh2Vhf92QnZR7uNqyT2aWs0UVuMpY7cOxuzckju8Hsiflh/Qz+OxocMzoVW3BbebDXUboB+B7lznidYa5lZ0d4lLhn4CHIUen5vfBTfzkwWsxCVhSZ1pBA/mx1KbrCklnWtyWV2VVnKhth3ZW4PzqgQRX+JSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735344; c=relaxed/simple;
	bh=tOipyK38zy8+DW8odwZ5XKf70Zyy2VhOJybOTIJ89gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcreP7kIEsSSdSTkEF0osYAH++RfmDR5SYEXC59KJD3/iah7vHHESmkTsH3eUab/GVn6GwIeWhaQtBT8XmZAIhvmcahQkM+reridmzTOXzDGcAZfbQnkOjbIdDIqoi2EACzA2YqFC9N75jbKu6MjUxlXdtfuz/lX7ijep1I6xR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDmNEkb8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDmNEkb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737735344; x=1769271344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tOipyK38zy8+DW8odwZ5XKf70Zyy2VhOJybOTIJ89gM=;
  b=iDmNEkb8we9l0EFJF6lcN2KyC2BprE39CYJua4CvlzJEUv8ASiOLhUrE
   WhoC/+Jd9SPGEOEk8Z5ALh/DNzadIWEYDeIlJwpGM/vl0x21kUyDG4uqw
   FIgiUeAnpOHyrvvkmLnB4+f5kMmuTnV610xLdVqgfczu1AhZtfDzBHaT0
   KZA8mlez4OPL3r8X9XG+wKqF10aHto0Sw05cEBLFj2jGxyJs1+lu3nyD+
   lKcL0B4zYYgXEV8ZFtTZXfuxU7ZTbnbOJI80X+R83KYXbo6h4RCo5qPVA
   liKopDi7qVQBosJklsbGeQM5fZ2655VM0XuCOaf8oOq/+zVKC3s6XwwPK
   Q==;
X-CSE-ConnectionGUID: dcvs2z0PRpGwrV8bkdnl+A==
X-CSE-MsgGUID: WENnViO4Rm2UyGHrM7wkPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38152892"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="38152892"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:15:41 -0800
X-CSE-ConnectionGUID: G88RWLyvRbOb9sGatkdhVA==
X-CSE-MsgGUID: yyytXDjKT1KF33164kZDxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="107612356"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jan 2025 08:15:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B109529D; Fri, 24 Jan 2025 18:15:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 2/6] serial: port: Always update ->iotype in __uart_read_properties()
Date: Fri, 24 Jan 2025 18:10:47 +0200
Message-ID: <20250124161530.398361-3-andriy.shevchenko@linux.intel.com>
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

The documentation of the __uart_read_properties() states that
->iotype member is always altered after the function call, but
the code doesn't do that in the case when use_defaults == false
and the value of reg-io-width is unsupported. Make sure the code
follows the documentation.

Note, the current users of the uart_read_and_validate_port_properties()
will fail and the change doesn't affect their behaviour, neither
users of uart_read_port_properties() will be affected since the
alteration happens there even in the current code flow.

Fixes: e894b6005dce ("serial: port: Introduce a common helper to read properties")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index f28d0633fe6b..85285c56fabf 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -228,11 +228,11 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 			port->iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
 			break;
 		default:
+			port->iotype = UPIO_UNKNOWN;
 			if (!use_defaults) {
 				dev_err(dev, "Unsupported reg-io-width (%u)\n", value);
 				return -EINVAL;
 			}
-			port->iotype = UPIO_UNKNOWN;
 			break;
 		}
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac

