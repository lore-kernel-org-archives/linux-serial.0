Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE8366542;
	Thu, 22 Jan 2026 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077442; cv=none; b=rw0l/4q11tUqctB6gdM8sYnziu7eG3z0zoqZnj1oeSw5C+IZPrkZKvCP95/THrS1sqiR3daBZ0eugRJzdEJIbMG25uE4OaSs9vH5KDMzQ64Pfp2CVYp0BIYc8TzGm1+CK4DyS21MHmzSl5dPcFjhhAqNVWtQlm/hwTDVxW1HhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077442; c=relaxed/simple;
	bh=oEqzGs6ebPgC4am6k3QRnBOCW4DvCLRax9CPKKyzzWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw+GhVqg7HxKPa682DNlOjK+qvrSNgvZ8ijPGP5NogJtDR970Rd7BQzoOcnz7u2jmXQy3yQOGXmKTKVFBsc0TMhANhFoxOnK3OR+O5DaTM/koHdmKvucMFmzXMoYN1fHa6FLOfPtDSwZ86MlRpDFFxdgSZGxE2cUBCS1Ikdcn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIcgNg8E; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIcgNg8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769077440; x=1800613440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oEqzGs6ebPgC4am6k3QRnBOCW4DvCLRax9CPKKyzzWw=;
  b=oIcgNg8EqbQ8//L/5kZWdKxnQmF8gr2gnPCmnbx8+9dbaknqxFhyVDnk
   F76aApCVjmvgXI19nykdOZnsmENisMbo1nHrZfEONDkEnZrA7GM1bheQg
   tsS9tQunmj1NI2c3F6GhS2nZwZZlQYhFSC5wZ196tdFplCEmDMsEcE+Xh
   /8gvwLyCfb/Xf/Qy1pmRSobSwAkIOR5HZuwftkKtr4lcZvZ9E4axSMhK7
   ytfviN2o4cATwBqrZVx1gnpzL6tYySrhxia4RMZSIsHCLG2yZOJqWuRcb
   31X3CYytZe3ktr9GpiT/R7m6LQO6ZgLZPVENIRuAiKQPFZNGOssGB+3H/
   w==;
X-CSE-ConnectionGUID: TLTibYNUQQeXHGrmm5GdOA==
X-CSE-MsgGUID: MpEQRnuiQT67W6t+derxlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70371026"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70371026"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 02:23:59 -0800
X-CSE-ConnectionGUID: f0z6MBH8Q0O1BCUQdYJszQ==
X-CSE-MsgGUID: gz4yOoFNRYaiDj46iiJeAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206760722"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 22 Jan 2026 02:23:57 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BF1EB99; Thu, 22 Jan 2026 11:23:55 +0100 (CET)
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
Subject: [PATCH v1 2/2] serial: 8250_pci: Remove custom deprecated baud setting routine
Date: Thu, 22 Jan 2026 11:19:48 +0100
Message-ID: <20260122102349.2395423-3-andriy.shevchenko@linux.intel.com>
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
 Documentation/misc-devices/oxsemi-tornado.rst | 26 +-----
 drivers/tty/serial/8250/8250_pci.c            | 85 ++++++++-----------
 2 files changed, 38 insertions(+), 73 deletions(-)

diff --git a/Documentation/misc-devices/oxsemi-tornado.rst b/Documentation/misc-devices/oxsemi-tornado.rst
index b33351bef6cf..fe2e5f726c2b 100644
--- a/Documentation/misc-devices/oxsemi-tornado.rst
+++ b/Documentation/misc-devices/oxsemi-tornado.rst
@@ -89,31 +89,7 @@ With the baud base set to 15625000 and the unsigned 16-bit UART_DIV_MAX
 limitation imposed by ``serial8250_get_baud_rate`` standard baud rates
 below 300bps become unavailable in the regular way, e.g. the rate of
 200bps requires the baud base to be divided by 78125 and that is beyond
-the unsigned 16-bit range.  The historic spd_cust feature can still be
-used by encoding the values for, the prescaler, the oversampling rate
-and the clock divisor (DLM/DLL) as follows to obtain such rates if so
-required:
-
-::
-
-  31 29 28             20 19   16 15                            0
- +-----+-----------------+-------+-------------------------------+
- |0 0 0|    CPR2:CPR     |  TCR  |            DLM:DLL            |
- +-----+-----------------+-------+-------------------------------+
-
-Use a value such encoded for the ``custom_divisor`` field along with the
-ASYNC_SPD_CUST flag set in the ``flags`` field in ``struct serial_struct``
-passed with the TIOCSSERIAL ioctl(2), such as with the setserial(8)
-utility and its ``divisor`` and ``spd_cust`` parameters, and then select
-the baud rate of 38400bps.  Note that the value of 0 in TCR sets the
-oversampling rate to 16 and prescaler values below 1 in CPR2/CPR are
-clamped by the driver to 1.
-
-For example the value of 0x1f4004e2 will set CPR2/CPR, TCR and DLM/DLL
-respectively to 0x1f4, 0x0 and 0x04e2, choosing the prescaler value,
-the oversampling rate and the clock divisor of 62.500, 16 and 1250
-respectively.  These parameters will set the baud rate for the serial
-port to 62500000 / 62.500 / 1250 / 16 = 50bps.
+the unsigned 16-bit range.
 
 Maciej W. Rozycki  <macro@orcam.me.uk>
 
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3efe075ef7b2..6589bb531cc6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1205,60 +1205,49 @@ static unsigned int pci_oxsemi_tornado_get_divisor(struct uart_port *port,
 	u8 tcr;
 	int i;
 
-	/* Old custom speed handling.  */
-	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
-		unsigned int cust_div = port->custom_divisor;
+	best_squot = quot_scale;
+	for (i = 0; i < ARRAY_SIZE(p); i++) {
+		unsigned int spre;
+		unsigned int srem;
+		u8 cp;
+		u8 tc;
 
-		quot = cust_div & UART_DIV_MAX;
-		tcr = (cust_div >> 16) & OXSEMI_TORNADO_TCR_MASK;
-		cpr = (cust_div >> 20) & OXSEMI_TORNADO_CPR_MASK;
-		if (cpr < OXSEMI_TORNADO_CPR_MIN)
-			cpr = OXSEMI_TORNADO_CPR_DEF;
-	} else {
-		best_squot = quot_scale;
-		for (i = 0; i < ARRAY_SIZE(p); i++) {
-			unsigned int spre;
-			unsigned int srem;
-			u8 cp;
-			u8 tc;
+		tc = p[i][0];
+		cp = p[i][1];
+		spre = tc * cp;
 
-			tc = p[i][0];
-			cp = p[i][1];
-			spre = tc * cp;
+		srem = sdiv % spre;
+		if (srem > spre / 2)
+			srem = spre - srem;
+		squot = DIV_ROUND_CLOSEST(srem * quot_scale, spre);
 
-			srem = sdiv % spre;
-			if (srem > spre / 2)
-				srem = spre - srem;
-			squot = DIV_ROUND_CLOSEST(srem * quot_scale, spre);
-
-			if (srem == 0) {
-				tcr = tc;
-				cpr = cp;
-				quot = sdiv / spre;
-				break;
-			} else if (squot < best_squot) {
-				best_squot = squot;
-				tcr = tc;
-				cpr = cp;
-				quot = DIV_ROUND_CLOSEST(sdiv, spre);
-			}
+		if (srem == 0) {
+			tcr = tc;
+			cpr = cp;
+			quot = sdiv / spre;
+			break;
+		} else if (squot < best_squot) {
+			best_squot = squot;
+			tcr = tc;
+			cpr = cp;
+			quot = DIV_ROUND_CLOSEST(sdiv, spre);
 		}
-		while (tcr <= (OXSEMI_TORNADO_TCR_MASK + 1) >> 1 &&
-		       quot % 2 == 0) {
+	}
+	while (tcr <= (OXSEMI_TORNADO_TCR_MASK + 1) >> 1 &&
+	       quot % 2 == 0) {
+		quot >>= 1;
+		tcr <<= 1;
+	}
+	while (quot > UART_DIV_MAX) {
+		if (tcr <= (OXSEMI_TORNADO_TCR_MASK + 1) >> 1) {
 			quot >>= 1;
 			tcr <<= 1;
-		}
-		while (quot > UART_DIV_MAX) {
-			if (tcr <= (OXSEMI_TORNADO_TCR_MASK + 1) >> 1) {
-				quot >>= 1;
-				tcr <<= 1;
-			} else if (cpr <= OXSEMI_TORNADO_CPR_MASK >> 1) {
-				quot >>= 1;
-				cpr <<= 1;
-			} else {
-				quot = quot * cpr / OXSEMI_TORNADO_CPR_MASK;
-				cpr = OXSEMI_TORNADO_CPR_MASK;
-			}
+		} else if (cpr <= OXSEMI_TORNADO_CPR_MASK >> 1) {
+			quot >>= 1;
+			cpr <<= 1;
+		} else {
+			quot = quot * cpr / OXSEMI_TORNADO_CPR_MASK;
+			cpr = OXSEMI_TORNADO_CPR_MASK;
 		}
 	}
 
-- 
2.50.1

