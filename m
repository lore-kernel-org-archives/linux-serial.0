Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED213AD8
	for <linux-serial@vger.kernel.org>; Sat, 13 Apr 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004440; cv=none; b=Y5/ABEPX8fkv2TsbByKb4QRw/CtUYg2YFhrLuAP8+xFzvmETtrYILCv5r7WeyQ+mM436594dwopp6qsPd4OGL8JaRREVHbXG/FLzSusI99EwQEJyD6bof9qi2jCd5s8XOpaTcGID7Pl2cWP353Nx8zDZ2cU61iav8koQJ/Q3ehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004440; c=relaxed/simple;
	bh=I0bA28BaRkKkzixQLIV2AERpkY2VXAkrfEJrul69ufs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3bXqGUowPM+UwUZ/DriscfBdvQB50dFCPV3JsLYLloPRbHdgJUtyakXVW5IxzX5Bt4AWO8whl+knExZDjr7td1VvcAqzyBPS1UcbqNYsMJb0oMH2gCZB0kTFmB56ix2iQRs5VxauVHW7ah1LJf2zE6BDoTjqNdhl4V5Wqj5vV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=O78WaWve; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="O78WaWve"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 2139F6033F;
	Sat, 13 Apr 2024 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1713004437;
	bh=I0bA28BaRkKkzixQLIV2AERpkY2VXAkrfEJrul69ufs=;
	h=From:To:Cc:Subject:Date:From;
	b=O78WaWvep6gNh63s6FXN2zLdq9xim0cV9jXcBEpYXW3yqCjAM9Wtqhs259WNXC6tp
	 IVnUIRd7vtE4Q7bHH0bTdqe51uvGXhnj92Y0obBnWtcJ2vVp2TCe6dOtN8ExX+k+Sw
	 IdL4SCfhXh0Tc/bed/Xe53rperHq/qFxyIaB49eVmFKGYvRp91QiTFxPKbz6+r1RBd
	 2fWiwF0BUuGktlbXreMcVM2D9D+wvwIlPSw3AXzlLe5wO2Qr33T1XDsqhM+H4gmych
	 iuSiO4Xcxe3bhZ8VlY8WV2oSPpXsArkZl3weoND4KqRMLo2FJE3xAME2+ji1YVCtQK
	 CxIu7gqhLFPBg==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: core: Fix ifdef for serial base console functions
Date: Sat, 13 Apr 2024 13:33:41 +0300
Message-ID: <20240413103343.24231-1-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_SERIAL_CORE_CONSOLE is not set, we get build errors.
Let's fix the issue by moving the endif after the serial base console
functions.

Fixes: 4547cd76f08a ("serial: 8250: Fix add preferred console for serial8250_isa_init_ports()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404131416.VJljwvkS-lkp@intel.com/
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -219,8 +219,6 @@ static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
 	return ret;
 }
 
-#endif
-
 #ifdef __sparc__
 
 /* Handle Sparc ttya and ttyb options as done in console_setup() */
@@ -319,6 +317,8 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
 }
 
+#endif
+
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
 /*
-- 
2.44.0
