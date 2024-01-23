Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3E82D64
	for <linux-serial@vger.kernel.org>; Tue, 23 Jan 2024 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040568; cv=none; b=VxruEc2Oknxz3wA6cUh2oa6AYbIpoNAPpOd6BgimCZ6AXBmuxBgtPm9VpE5yrlRoCcFYhouR7usr/uxIup446HDIIrMjjQYAlEvkjg9RXkuR9IX2wehKgMSL7/7RFwCwNkxYw5avFLQDNtlBOwVw5x6DYSHW3GXLDKQFJ/R6+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040568; c=relaxed/simple;
	bh=EKUqlFr4uDKDaZclr/fZ6Kuqd0TROioAJn3MAot9Wcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Xzd9meRFr3BJ/PqQla6te+2GyC+A3I4X/e/lZe2b2/45O1UShQMrfGIIFU7MEcdUefwJLWzA4KklFmgBXZqhjC0nVucU9M8K3xH8TDrqBhCPgtmE0LfLPOkjgJhFgWaSuvWQERg4204HletCOEeRqwXJW7+6JUNWL7yHt7kMfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8ec8:24bf:c2ed:213e])
	by baptiste.telenet-ops.be with bizsmtp
	id eL9G2B00T2E7G5801L9Gb5; Tue, 23 Jan 2024 21:09:17 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rSN4M-00GNTe-Ku;
	Tue, 23 Jan 2024 21:09:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rSN5A-00Eta1-I1;
	Tue, 23 Jan 2024 21:09:16 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Johan Hovold <johan@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: txx9: Add missing #include <asm/txx9/generic.h>
Date: Tue, 23 Jan 2024 21:09:15 +0100
Message-Id: <818be2380061c19fe65819f7b7f10ab6e7aaa082.1706040343.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drivers/tty/serial/serial_txx9.c:933:12: error: no previous prototype for ‘early_serial_txx9_setup’ [-Werror=missing-prototypes]
  933 | int __init early_serial_txx9_setup(struct uart_port *port)
      |            ^~~~~~~~~~~~~~~~~~~~~~~

This function is called from arch/mips/txx9/generic/setup.c, and does
have a forward declaration in arch/mips/include/asm/txx9/generic.h.

As the TXX9 serial driver does not support compile-testing, and thus can
only be built on MIPS, fix this by including the MIPS-only header file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note that the initial version of commit 8720037d55dbfa30 ("serial:
extend compile-test coverage") did enable compile-testing for
SERIAL_TXX9, but that was dropped later, cfr. the discussion in the
thread at
https://lore.kernel.org/all/CAMuHMdXKWDB89Hm-LQcpfTq=0yjm_xvQsQiD4QuEtW=yVymuRw@mail.gmail.com
---
 drivers/tty/serial/serial_txx9.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index e1897894a4ef58cb..abba397229581851 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -23,9 +23,10 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-
 #include <linux/io.h>
 
+#include <asm/txx9/generic.h>
+
 #define PASS_LIMIT	256
 
 #if !defined(CONFIG_SERIAL_TXX9_STDSERIAL)
-- 
2.34.1

