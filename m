Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8283002DC
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916085; cv=none; b=PSlK17fKPTbKs0D+FLMhWIc2TLrkzA4uKVbhV6HoKnSvJ2D9wrZv3bKDs50cLO9kkvPM+Bp1brBkm3uTrd8LxPbTu6eFh5A8rkqYN93PKMEkrTiZRmEwkKBESOvoXWZSKgm/iox/F03A4hq0bK60aX4UwwTdSfpLGqykUl5WuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916085; c=relaxed/simple;
	bh=GcFJGszqXfHnAFgOiFFDYJZB/uR9gKmuL5ecWE7PaBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6b0W9Mvf3MA+RVyJFnCOGkopzvx6JWAlwrF2xKIlEyDdDKlYbpc1QC2OGz2/CUJrWvn40IkOc1pnuxKBfMAO3/up3oNNfvzquItrQPnaXykZwnQxwuKpii5HaWh5h+6hWa6mwTO1t3FA38b4FOfYX6m/ioCWKjMlu7+PlIYsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=pTgo8V4L; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="pTgo8V4L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2mlkYPwgP2yflKfUj3bNzT8/vT7a2J8A/iUpW/AZJHQ=; b=pTgo8V4LaDKKITZyxAvWCwK23O
	Z/0wxWNSFdCuXKXMlNojeT7JAoqmtas1NlPXWVOq4g248oXpcPP1A5UtgvdrlNJSAWmWHnEVIbEdp
	Ih3NqcRwsTpk5nVuTqS/UVh7n3/7MxJ/bJYzJ6la+ExNA+xEhyK83d8Gjaz+5RZzUoGQ=;
Received: from 188-23-39-151.adsl.highway.telekom.at ([188.23.39.151] helo=hornet.engleder.at)
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vVari-000000005P3-1zFT;
	Tue, 16 Dec 2025 20:37:46 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH 2/3] serial: 8250_keba: Add ICR defines
Date: Tue, 16 Dec 2025 20:37:25 +0100
Message-Id: <20251216193726.55449-3-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216193726.55449-1-gerhard@engleder-embedded.com>
References: <20251216193726.55449-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

Add defines for better readability of the Indexed Control Register (ICR)
access. In enhanced mode SCR and LSR registers are used for ICR access.
The behavior of these register is different in this mode and that shall
be documented with dedicated defines.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/tty/serial/8250/8250_keba.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_keba.c b/drivers/tty/serial/8250/8250_keba.c
index e9e59ce79138..149953c6a288 100644
--- a/drivers/tty/serial/8250/8250_keba.c
+++ b/drivers/tty/serial/8250/8250_keba.c
@@ -51,6 +51,10 @@ enum kuart_mode {
 #define KUART_CAPABILITY_RS232	BIT(KUART_MODE_RS232)
 #define KUART_CAPABILITY_MASK	GENMASK(3, 0)
 
+/* registers for Indexed Control Register access in enhanced mode */
+#define KUART_EMODE_ICR_OFFSET	UART_SCR
+#define KUART_EMODE_ICR_VALUE	UART_LSR
+
 /* Additional Control Register DTR line configuration */
 #define UART_ACR_DTRLC_MASK		0x18
 #define UART_ACR_DTRLC_COMPAT		0x00
@@ -98,13 +102,13 @@ static void kuart_dtr_line_config(struct uart_8250_port *up, u8 dtrlc)
 	u8 acr;
 
 	/* set index register to 0 to access ACR register */
-	serial_out(up, UART_SCR, UART_ACR);
+	serial_out(up, KUART_EMODE_ICR_OFFSET, UART_ACR);
 
 	/* set value register to 0x10 writing DTR mode (1,0) */
-	acr = serial_in(up, UART_LSR);
+	acr = serial_in(up, KUART_EMODE_ICR_VALUE);
 	acr &= ~UART_ACR_DTRLC_MASK;
 	acr |= dtrlc;
-	serial_out(up, UART_LSR, acr);
+	serial_out(up, KUART_EMODE_ICR_VALUE, acr);
 }
 
 static int kuart_rs485_config(struct uart_port *port, struct ktermios *termios,
-- 
2.39.5

