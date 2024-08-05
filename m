Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48BE15A865;
	Mon,  5 Aug 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853259; cv=none; b=reLENO1iO6p42yJv+DxltSkL0y6boeZvCCaIlOieDhd5HSV8cB2N5yRlIQDdDxsuys+4dMwd4w8BSRdZGYO7LWZZf6gCV3IDpVw15JfrM7pMKHHLRZfdAx62zJdwo9iifV5IN1BN5Iv+6shQb8w55brwdUppywI8cEDNgjcuvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853259; c=relaxed/simple;
	bh=jOuqSo9hnu+BJZ9+LRjz1QLODIw+vrxmbvnptmsVYMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D44qK/zvFL4Dglgde9mBTj2YB9PC6huTVXKzOJTy1AeZv34aLN8CzU9Ca8KhKuRwdo+d7Qgw7b4iGkeT2eLqMbOWNpCs/1oaIPsRWwn173cSUI1ndtOc7vt2ElqDCddHfHABm3njQ+QdMPtcfJ+GYwENGREuicATzdrmlJ/uIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIYBoY6b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIYBoY6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E55C4AF0F;
	Mon,  5 Aug 2024 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853259;
	bh=jOuqSo9hnu+BJZ9+LRjz1QLODIw+vrxmbvnptmsVYMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIYBoY6bQ04eaRdaebMdig0+dtVGA+kcxKGh+LQ77gJdcpRODjSyF6t75WI/PxASA
	 qQdxxm7SStzPisngEaTHgJao5+xLSAVlPLq+w5RcIIyus8oXUtpotEnHux6CH8r2pb
	 5pTG6OoN48d0T4z16PAQoc/dsjJkbFrnLQKu9GWak3+3E4Mw1GzXeiyGixg33D8k81
	 IWFSaYM82b07mZtMIJronySvbybd261Yi6QD0MJY8kN1TNeC9n2ZBaa3NZEARLp1Gf
	 vF4q+l45Klc7GVrwtybDKXZKWEop6c95e5ZGfyeTm/CgqWUMvNmmlGO/Lwq0mvKXuV
	 kzBb5ZbuVkHAg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 04/13] serial: remove quot_frac from serial8250_do_set_divisor()
Date: Mon,  5 Aug 2024 12:20:37 +0200
Message-ID: <20240805102046.307511-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

quot_frac is unused in serial8250_do_set_divisor() since commit
b2b4b8ed3c06 (serial: 8250_exar: Move custom divisor support out from
8250_port). So no point to pass it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dwlib.c | 2 +-
 drivers/tty/serial/8250/8250_exar.c  | 2 +-
 drivers/tty/serial/8250/8250_pci.c   | 2 +-
 drivers/tty/serial/8250/8250_port.c  | 4 ++--
 include/linux/serial_8250.h          | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 5a2520943dfd..b055d89cfb39 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -89,7 +89,7 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
 	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
-	serial8250_do_set_divisor(p, baud, quot, quot_frac);
+	serial8250_do_set_divisor(p, baud, quot);
 }
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios,
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 616128254bbd..b7a75db15249 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -500,7 +500,7 @@ static unsigned int xr17v35x_get_divisor(struct uart_port *p, unsigned int baud,
 static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
 				 unsigned int quot, unsigned int quot_frac)
 {
-	serial8250_do_set_divisor(p, baud, quot, quot_frac);
+	serial8250_do_set_divisor(p, baud, quot);
 
 	/* Preserve bits not related to baudrate; DLD[7:4]. */
 	quot_frac |= serial_port_in(p, 0x2) & 0xf0;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e1d7aa2fa347..6709b6a5f301 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1277,7 +1277,7 @@ static void pci_oxsemi_tornado_set_divisor(struct uart_port *port,
 	serial_icr_write(up, UART_TCR, tcr);
 	serial_icr_write(up, UART_CPR, cpr);
 	serial_icr_write(up, UART_CKS, cpr2);
-	serial8250_do_set_divisor(port, baud, quot, 0);
+	serial8250_do_set_divisor(port, baud, quot);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2786918aea98..3509af7dc52b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2609,7 +2609,7 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 }
 
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
-			       unsigned int quot, unsigned int quot_frac)
+			       unsigned int quot)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
@@ -2641,7 +2641,7 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 	if (port->set_divisor)
 		port->set_divisor(port, baud, quot, quot_frac);
 	else
-		serial8250_do_set_divisor(port, baud, quot, quot_frac);
+		serial8250_do_set_divisor(port, baud, quot);
 }
 
 static unsigned int serial8250_get_baud_rate(struct uart_port *port,
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index fd59ed2cca53..e0717c8393d7 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -193,7 +193,7 @@ void serial8250_do_pm(struct uart_port *port, unsigned int state,
 		      unsigned int oldstate);
 void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
-			       unsigned int quot, unsigned int quot_frac);
+			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
-- 
2.46.0

