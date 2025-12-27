Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBBF312800;
	Sat, 27 Dec 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766867115; cv=none; b=enbklQaGOPZTryUKERiBdr6DtUJNumxboIhi0YLBQq0hlYFolE4pkPYi4ArT7IRWE5f9HfTa7k6p6Du2kb5Y0kWUAQXcBWNkms/AC2dNN7sQnjKj9E1ztr1byVI1yzs+XiO3YtrsprZoJVHfVMBSLELMb7cpAOVeIhaTNU6yjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766867115; c=relaxed/simple;
	bh=RHhtNrNyKS3uOMn+fAQ8bNHVClqHv1ci5pJtVONuX6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhZtFOwQdVN/HLvfnYq0lIOQokHw8Z8BSsBSJ+kfsI0WNpJO2hSgAIpMlgAck/Z7hlgcmjkXMrRyPKbiMFMorPQqR7sqmsgJHIq/c0gXJxPn6Tvi33S+qy7UF4S0PIimxHj/GgbzjIyzXqFCX/wdDkv7To75dOeGm9lS3Qv2Nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n6AOej99; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n6AOej99"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SMdGy8X6N/TAE67avV0OW8PPzcYf3Mi/mys+/tlqVWw=; b=n6AOej99EEK+Tx+t7ziHZLdBJg
	6FveBqiWhzY5ixkGHccHg9xA6GE9ZquW1QKnojt172xFKo/942qV3EYRBwBgjupP+jxJ49auVc5rv
	DqbUuzkGVYVf/9hMZ65y3A4822YWp8UNlZZ2vpSaYWEwRV0eKteBWZw3d8SmoQNUjYY13Tz+WtDHw
	IsZSrgmL4HxyWuMtfWSiiqiFJ6bhz2kRODLrGhY+NuSouTvv9+H5OTsn2pgZHXXGTCJzxlfhfsj5f
	pk4Wt8+7IMgExPgi74s7FerZAC1aC2LMM7PeYDA8OZBsUQjYy/DHJZNA78wgFy811omxFPre6po4q
	984k5iMA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZaqd-00000002C4U-1EAZ;
	Sat, 27 Dec 2025 20:25:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Fugang Duan <fugang.duan@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/4] serial: 8250: fix ordering of entries for menu display
Date: Sat, 27 Dec 2025 12:25:07 -0800
Message-ID: <20251227202509.2084000-3-rdunlap@infradead.org>
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

Improve the "8250/16550 serial support" menu so that entries in it
are displayed in a better order (reorder a few symbols) and so that
intervening symbols don't break up the dependency list, allowing menu
entries to be displayed with proper indentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org

 drivers/tty/serial/8250/Kconfig |   95 +++++++++++++++---------------
 1 file changed, 48 insertions(+), 47 deletions(-)

--- linux-next-20251219.orig/drivers/tty/serial/8250/Kconfig
+++ linux-next-20251219/drivers/tty/serial/8250/Kconfig
@@ -116,6 +116,7 @@ config SERIAL_8250_DMA
 
 config SERIAL_8250_PCILIB
 	bool
+	depends on SERIAL_8250 && PCI
 
 config SERIAL_8250_PCI
 	tristate "8250/16550 PCI device support"
@@ -205,6 +206,37 @@ config SERIAL_8250_EXTENDED
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about serial driver options. If unsure, say N.
 
+config SERIAL_8250_SHARE_IRQ
+	bool "Support for sharing serial interrupts"
+	depends on SERIAL_8250_EXTENDED
+	help
+	  Some serial boards have hardware support which allows multiple dumb
+	  serial ports on the same board to share a single IRQ. To enable
+	  support for this in the serial driver, say Y here.
+
+config SERIAL_8250_DETECT_IRQ
+	bool "Autodetect IRQ on standard ports (unsafe)"
+	depends on SERIAL_8250_EXTENDED
+	help
+	  Say Y here if you want the kernel to try to guess which IRQ
+	  to use for your serial port.
+
+	  This is considered unsafe; it is far better to configure the IRQ in
+	  a boot script using the setserial command.
+
+	  If unsure, say N.
+
+config SERIAL_8250_RSA
+	bool "Support RSA serial ports"
+	depends on SERIAL_8250_EXTENDED
+	help
+	  Say Y here if you have a IODATA RSA-DV II/S ISA card and
+	  would like to use its >115kbps speeds.
+	  You will need to provide module parameter "probe_rsa", or boot-time
+	  parameter 8250.probe_rsa with I/O addresses of this card then.
+
+	  If you don't have such card, or if unsure, say N.
+
 config SERIAL_8250_MANY_PORTS
 	bool "Support more than 4 legacy serial ports"
 	depends on SERIAL_8250_EXTENDED
@@ -240,19 +272,6 @@ config SERIAL_8250_ACCENT
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_accent.
 
-config SERIAL_8250_ASPEED_VUART
-	tristate "Aspeed Virtual UART"
-	depends on SERIAL_8250
-	depends on OF
-	depends on MFD_SYSCON
-	depends on ARCH_ASPEED || COMPILE_TEST
-	select REGMAP
-	help
-	  If you want to use the virtual UART (VUART) device on Aspeed
-	  BMC platforms, enable this option. This enables the 16550A-
-	  compatible device on the local LPC bus, giving a UART device
-	  with no physical RS232 connections.
-
 config SERIAL_8250_BOCA
 	tristate "Support Boca cards"
 	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
@@ -293,44 +312,23 @@ config SERIAL_8250_PCI1XXXX
 	 serial driver for the serial interface. This driver support
 	 will ensure to support baud rates upto 1.5Mpbs.
 
+config SERIAL_8250_ASPEED_VUART
+	tristate "Aspeed Virtual UART"
+	depends on SERIAL_8250
+	depends on OF
+	depends on MFD_SYSCON
+	depends on ARCH_ASPEED || COMPILE_TEST
+	select REGMAP
+	help
+	  If you want to use the virtual UART (VUART) device on Aspeed
+	  BMC platforms, enable this option. This enables the 16550A-
+	  compatible device on the local LPC bus, giving a UART device
+	  with no physical RS232 connections.
+
 #
 # Misc. options/drivers.
 #
 
-config SERIAL_8250_SHARE_IRQ
-	bool "Support for sharing serial interrupts"
-	depends on SERIAL_8250_EXTENDED
-	help
-	  Some serial boards have hardware support which allows multiple dumb
-	  serial ports on the same board to share a single IRQ. To enable
-	  support for this in the serial driver, say Y here.
-
-config SERIAL_8250_DETECT_IRQ
-	bool "Autodetect IRQ on standard ports (unsafe)"
-	depends on SERIAL_8250_EXTENDED
-	help
-	  Say Y here if you want the kernel to try to guess which IRQ
-	  to use for your serial port.
-
-	  This is considered unsafe; it is far better to configure the IRQ in
-	  a boot script using the setserial command.
-
-	  If unsure, say N.
-
-config SERIAL_8250_RSA
-	bool "Support RSA serial ports"
-	depends on SERIAL_8250_EXTENDED
-	help
-	  Say Y here if you have a IODATA RSA-DV II/S ISA card and
-	  would like to use its >115kbps speeds.
-	  You will need to provide module parameter "probe_rsa", or boot-time
-	  parameter 8250.probe_rsa with I/O addresses of this card then.
-
-	  If you don't have such card, or if unsure, say N.
-
-config SERIAL_8250_DWLIB
-	bool
-
 config SERIAL_8250_ACORN
 	tristate "Acorn expansion card serial port support"
 	depends on ARCH_ACORN && SERIAL_8250
@@ -596,3 +594,6 @@ config SERIAL_OF_PLATFORM
 	  are probed through devicetree, including Open Firmware based
 	  PowerPC systems and embedded systems on architectures using the
 	  flattened device tree format.
+
+config SERIAL_8250_DWLIB
+	bool
