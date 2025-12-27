Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1789325721;
	Sat, 27 Dec 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766867116; cv=none; b=KWMXZFUBJW8tNyqopcz9ldbd7qh0PJbHdE1VC9QARgKQ5roSadLUNc0HhxcLuork+erePeOj7c5N8mAqbmRzzNCLQGm7/De+emp29uD+LvK7NXWHoxh6r4sNHNaLNhufAUSg3ZsXiApelNQe0uxnSJTNfqJTrZ517l4uWk/OtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766867116; c=relaxed/simple;
	bh=eKPxrrSHxn3dGNodPncIpP7xU/nYs4no/RYlhMfOxPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHaXd6drKI9e/8PpRczcYAnQxHvZWwm5RdqnkopIwcitbTPwQkxuZ72RUKzHC36B3vf6taKRchS2pzikp0rPe3+QJhmcG5wfbQRKMqjOlVkP5BwO2vpq61mHSuc/sbD3D7I8yb5DBAR1cX8cJFTGMN2QNYVUsY7oiYED4DkbhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yV+N3o1C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yV+N3o1C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8m/mjGPf4E8B62qe3/V/0IwuiTofQWgYk7ojnbyUYjw=; b=yV+N3o1CirWwt6ZQC6rusg6l/7
	8fRW/NH7kR6oKQgaBOsOjUPUovdD7mD6aq9FkuFYZLmeJzoPDSGHSITVsWBiUH1T247q3Es7HRM/w
	tfmVHs5sEL6T4gj7IcG+Rj6lhgD3fFgIZfBD32ZV5EOIC+DYZIija0RWjWlXX8K4hQJTcD/HtScaI
	XGrFSeOqo2ebKgjGuOK0Rl6q863jG+QMoxkyc6uekQJRfdXgf4uACEm2plvFde5VKm5rFyurxHUhv
	sbG7ME2eojTjVktJZrlup9bBjs9PnMWlRbaCKsuJ8ejsyA6D1BCtm2C5jXdWYuVB6D8MH//Q691VE
	aQbUd4Vw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZaqd-00000002C4U-2j2d;
	Sat, 27 Dec 2025 20:25:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Fugang Duan <fugang.duan@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org
Subject: [PATCH 3/4] serial: Kconfig: fix ordering of entries for menu display
Date: Sat, 27 Dec 2025 12:25:08 -0800
Message-ID: <20251227202509.2084000-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227202509.2084000-1-rdunlap@infradead.org>
References: <20251227202509.2084000-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the "Non-8250 serial port support" menu so that entries in it
are displayed in a better order (_CONSOLE after its driver) and so that
intervening symbols don't break up the dependency list, allowing menu
entries to be displayed with proper indentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org

 drivers/tty/serial/Kconfig |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- linux-next-20251219.orig/drivers/tty/serial/Kconfig
+++ linux-next-20251219/drivers/tty/serial/Kconfig
@@ -413,6 +413,10 @@ config SERIAL_21285_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_PXA_NON8250
+	bool
+	depends on !SERIAL_8250 || COMPILE_TEST
+
 config SERIAL_PXA
 	bool "PXA serial port support (DEPRECATED)"
 	depends on ARCH_PXA || ARCH_MMP
@@ -426,10 +430,6 @@ config SERIAL_PXA
 	  Unless you have a specific need, you should use SERIAL_8250_PXA
 	  instead of this.
 
-config SERIAL_PXA_NON8250
-	bool
-	depends on !SERIAL_8250 || COMPILE_TEST
-
 config SERIAL_PXA_CONSOLE
 	bool "Console on PXA serial port (DEPRECATED)"
 	depends on SERIAL_PXA
@@ -863,15 +863,15 @@ config SERIAL_ICOM
 	  This driver can also be built as a module.  If so, the module
 	  will be called icom.
 
+config HAS_TXX9_SERIAL
+	bool
+
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
 	depends on HAS_TXX9_SERIAL
 	select SERIAL_CORE
 	default y
 
-config HAS_TXX9_SERIAL
-	bool
-
 config SERIAL_TXX9_NR_UARTS
 	int "Maximum number of TMPTX39XX/49XX SIO ports"
 	depends on SERIAL_TXX9
@@ -1251,12 +1251,6 @@ config SERIAL_AR933X_NR_UARTS
 	  Set this to the number of serial ports you want the driver
 	  to support.
 
-config SERIAL_MPS2_UART_CONSOLE
-	bool "MPS2 UART console support"
-	depends on SERIAL_MPS2_UART
-	select SERIAL_CORE_CONSOLE
-	select SERIAL_EARLYCON
-
 config SERIAL_MPS2_UART
 	bool "MPS2 UART port"
 	depends on ARCH_MPS2 || COMPILE_TEST
@@ -1264,6 +1258,12 @@ config SERIAL_MPS2_UART
 	help
 	  This driver support the UART ports on ARM MPS2.
 
+config SERIAL_MPS2_UART_CONSOLE
+	bool "MPS2 UART console support"
+	depends on SERIAL_MPS2_UART
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+
 config SERIAL_ARC
 	tristate "ARC UART driver support"
 	select SERIAL_CORE
