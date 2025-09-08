Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2D2F60B6;
	Mon,  8 Sep 2025 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324755; cv=none; b=lmHesgqaQboB/E6MZysKvh3vEjyWAat+pN4vBdcjFVWUcFIkZfvPaMUsoBdKp5Bqdok4CaLYIUrRE64RSrgAy6+GvkTtObui7hvtljb4JATlQJKk0qpuc4yUZkdY71HscOT7ZwSoLcGiQ9plAHkxkpraiQsYk3T3KM5t9V6/AU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324755; c=relaxed/simple;
	bh=TZUhvHSGGcLtIxh0HnB+s/u5WaFKlmsEZiZnhX4sdrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ap6w1KjDpUePPyLcW4+ngT70u2vDhFYlG6doIEXO11Q/mPQgTRSzA2kC4Aq/uGHf8lNX0YPiy/gZAIIYg3Snqrld24e6zLBpBVOL0yfj3950MYLGlKblqnc9uCaYNYLg42IMRAF8F3WqcVqrBF2wjwQp4GQQHw1zh7dcrDAl2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A2FC4CEFA;
	Mon,  8 Sep 2025 09:45:53 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philip Blundell <philb@gnu.org>,
	Kars de Jong <jongk@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] tty: serial: 8250: Rework HP300 serial Kconfig logic
Date: Mon,  8 Sep 2025 11:45:42 +0200
Message-ID: <f69570963ce01fe83bf11675c47415530e8d950e.1757323858.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757323858.git.geert@linux-m68k.org>
References: <cover.1757323858.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SERIAL_8250 and HP300 are enabled, but none of SERIAL_8250_HPDCA
and SERIAL_8250_HPAPCI is built-in:

    drivers/tty/serial/8250/8250_hp300.c:24:2: warning: #warning CONFIG_SERIAL_8250 defined but neither CONFIG_SERIAL_8250_HPDCA nor CONFIG_SERIAL_8250_HPAPCI defined, are you sure? [-Wcpp]
       24 | #warning CONFIG_SERIAL_8250 defined but neither CONFIG_SERIAL_8250_HPDCA nor CONFIG_SERIAL_8250_HPAPCI defined, are you sure?
	  |  ^~~~~~~

Fix this by reworking the Kconfig logic to make such combinations
impossible:
  - Stop enabling SERIAL_8250_HP300 by default when both SERIAL_8250 and
    HP300 are enabled,
  - Instead, let SERIAL_8250_HPDCA and SERIAL_8250_HPAPCI select
    SERIAL_8250_HP300.

Note that since commit 0cff260a42c051ee ("[SERIAL] Allow 8250 PCI, PNP,
GSC and HP300 support to be disabled"), the warning message is wrong,
and should have been s/CONFIG_SERIAL_8250/CONFIG_SERIAL_8250_HP300/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/8250/8250_hp300.c | 4 ----
 drivers/tty/serial/8250/Kconfig      | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 583a86d87b559ec4..30e7d09eed8ae5bf 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -20,10 +20,6 @@
 
 #include "8250.h"
 
-#if !defined(CONFIG_SERIAL_8250_HPDCA) && !defined(CONFIG_SERIAL_8250_HPAPCI) && !defined(CONFIG_COMPILE_TEST)
-#warning CONFIG_SERIAL_8250 defined but neither CONFIG_SERIAL_8250_HPDCA nor CONFIG_SERIAL_8250_HPAPCI defined, are you sure?
-#endif
-
 #ifdef CONFIG_SERIAL_8250_HPAPCI
 struct hp300_port {
 	struct hp300_port *next;	/* next port */
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 2696c236917afddd..9b5df423606bfb80 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -159,12 +159,11 @@ config SERIAL_8250_EXAR
 
 config SERIAL_8250_HP300
 	tristate
-	depends on SERIAL_8250 && HP300
-	default SERIAL_8250
 
 config SERIAL_8250_HPDCA
 	tristate "8250 HP DCA serial support"
 	depends on SERIAL_8250 && DIO
+	select SERIAL_8250_HP300
 	help
 	  If you want to use the internal "DCA" serial ports on an HP300
 	  machine, say Y here.
@@ -172,6 +171,7 @@ config SERIAL_8250_HPDCA
 config SERIAL_8250_HPAPCI
 	tristate "8250 HP APCI serial support"
 	depends on SERIAL_8250 && HP300
+	select SERIAL_8250_HP300
 	help
 	  If you want to use the internal "APCI" serial ports on an HP400
 	  machine, say Y here.
-- 
2.43.0

