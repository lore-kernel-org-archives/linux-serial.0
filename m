Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00963E8333;
	Wed, 15 Jul 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129834; cv=none; b=Of2dKEwUjH/R2eAfjcPEo0BOWXk1BT+2ET6ziRtlz2G/MkaLlK137sKVxniR9k5swmte+4pqSMdOZO1cTJg0ln79hhWTpznsELmrTdmDpXKdd5BonBFcLnBtGhH1A5JGE93N4xlyxt5ZwoCxU6f+kNuFFmeipud1+Q+DQFCboQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129834; c=relaxed/simple;
	bh=geWrfmyPshysAY09R/xpbvyv9RZ0nna8NgJMUNIwUmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBanD2QdNUJQA2ovIJOm5wLVSMDvihDFcEK9/ybNeH9rFNZMBwnSORhl20SeVvGzYgVYeTDwt14gXG3foCkHwanEDD0056of6rwlp+hcoeiGGP9NZIwXazm4ViGcr0moOwMV9xiPYFEFgIdg92RGzKXOrzwRg1p2+Mbohg+jXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Qp/HRj79; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Qp/HRj79"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=pY1HX24Eap0X0TlqZ8QbQMF/J0OfJ8mUn2gixZ3vri8=; b=Qp/HRj793FPcjq9bLl4soSq+CB
	OXqc1ZxpfECuOtA3j1HzkNKsosqN3uomUZn02jE+wQdVqFHRNU9HyY5va7bZUAmTL8GN0Zynrn9o6
	ZE33/uBG7DVaZxf1h/ZAYxad4MUkzJT95G6GdRxqU6r8vPkwraEoMaa+2aTOqbwmmSsw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wk1fZ-000000008Ey-49hs;
	Wed, 15 Jul 2026 11:37:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: fix compile error with hub6_match_port() when compiled as a module
Date: Wed, 15 Jul 2026 11:37:05 -0400
Message-ID: <20260715153707.4181828-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

With CONFIG_SERIAL_8250_HUB6=m, we have the following compile error:

  ../drivers/tty/serial/8250/8250_hub6.c:46:6: error: redefinition of
       'hub6_match_port'

Fix hub6_match_port() prototype definition by using IS_REACHABLE() to
support both built-in and module values, and substitute empty prototype
otherwise.

Fixes: 3d406299d8829 ("serial: 8250_hub6: add hub6_match_port()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607150717.2YxVdWpX-lkp@intel.com/
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/8250/8250.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 9d1068d0489dc..b62f88eec881f 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/kconfig.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/dmaengine.h>
@@ -334,7 +335,7 @@ int fintek_8250_probe(struct uart_8250_port *uart);
 static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
 #endif
 
-#ifdef CONFIG_SERIAL_8250_HUB6
+#if IS_REACHABLE(CONFIG_SERIAL_8250_HUB6)
 bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2);
 #else
 static inline bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.47.3

