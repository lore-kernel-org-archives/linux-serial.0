Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B436AB4E;
	Thu, 22 Jan 2026 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077442; cv=none; b=W304X6f6Vne24o1vQA2yYM/sXww318BC1kS571rUrkPjsGWld6IyjN41uDbYKrebr4X2HIQbJpd7N6gGJHWs41Fw+JfmugvAYDp7IKIVlzReLKH8dxURQMYc0kdMt3wHhObUK9fI7r22uOrSjUhp7C3zsw9K6ZDK0FRDtagTYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077442; c=relaxed/simple;
	bh=+ponhCVn2cRUJSU87mwByby7CyGZivwMxVvrVozaoFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFpXv/p5lLte5TOi9H4VFIDIWUguTwH0SGeYlTYlrhYfebKKBMqiaMNbYIQ/1bHW22z7awLsAxhbS9UD1M5fVw57TwYRLH1kdUmauw+v0hvehxfBm9bOrD82WsHcf9U9YczYLggw10YvwdzoQz4Obg1CUM8lKWcP/TzeAwHLKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSd+0Z2A; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSd+0Z2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769077440; x=1800613440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ponhCVn2cRUJSU87mwByby7CyGZivwMxVvrVozaoFs=;
  b=GSd+0Z2AvDT6A4Do7T/Y+0Hib7Elks/cg68XJ/bCPJN/REFPO9b6BUSM
   D6HkfQpDoHGVBw9ibBxYYUagz7D1++ISugUYEmFqZxfYNzuc0jODlMJx6
   rrEtKEQsPw1PzKiXOOA87q1+R6Gak+eZPGhKJ0aDrnhWBqX8TsPfdiUR5
   e3/JVi0oHYvzG2Lz/7OeuailoFar+76EmBTZzeXbiFHIylMM/V2VegGqw
   pTdCURD+JNLqILkL3vAEqFpxS2/KN/90MXlDn0fTpiKp4qPZufkKL5LNf
   kSF1WepDji+ySfpWG3VM8OXoicpIQj54+LqQB5HoW7CaTXOa+jFXy5mCF
   A==;
X-CSE-ConnectionGUID: 9GMYrpN8Rv+HexPXMSjWrA==
X-CSE-MsgGUID: iWZJY7fjQ66Mm+s7cVCc9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="95790499"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="95790499"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 02:23:59 -0800
X-CSE-ConnectionGUID: aWLxvmeNQy+6SwLF0x5R0A==
X-CSE-MsgGUID: Z1nwToaFTriE2qZu9N4daA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206958325"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 22 Jan 2026 02:23:56 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BAF2098; Thu, 22 Jan 2026 11:23:55 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH v1 1/2] serial: 8250_omap: Remove custom deprecated baud setting routine
Date: Thu, 22 Jan 2026 11:19:47 +0100
Message-ID: <20260122102349.2395423-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122102349.2395423-1-andriy.shevchenko@linux.intel.com>
References: <20260122102349.2395423-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As comments mentioned this is old (and actually deprecated) interface
to set custom baud rates. This interface has limitations as it only
allows to set a single opaque value called "custom_divisor". If the HW
needs more complex settings (like fractional divisor) it must somehow
encode this. This is horrid interface that is very driver specific
and not flexible. Meanwhile Linux has established way to set free
baud rate settings via BOTHER [1]. With all this being said, remove
deprecated interface for good.

Link: https://stackoverflow.com/questions/12646324/how-can-i-set-a-custom-baud-rate-on-linux [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_omap.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4496f692b86b..427719c158b7 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -243,22 +243,6 @@ static void omap_8250_get_divisor(struct uart_port *port, unsigned int baud,
 	unsigned int div_13, div_16;
 	unsigned int abs_d13, abs_d16;
 
-	/*
-	 * Old custom speed handling.
-	 */
-	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
-		priv->quot = port->custom_divisor & UART_DIV_MAX;
-		/*
-		 * I assume that nobody is using this. But hey, if somebody
-		 * would like to specify the divisor _and_ the mode then the
-		 * driver is ready and waiting for it.
-		 */
-		if (port->custom_divisor & (1 << 16))
-			priv->mdr1 = UART_OMAP_MDR1_13X_MODE;
-		else
-			priv->mdr1 = UART_OMAP_MDR1_16X_MODE;
-		return;
-	}
 	div_13 = DIV_ROUND_CLOSEST(uartclk, 13 * baud);
 	div_16 = DIV_ROUND_CLOSEST(uartclk, 16 * baud);
 
-- 
2.50.1

