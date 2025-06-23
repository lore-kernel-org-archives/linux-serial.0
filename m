Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936121765E;
	Mon, 23 Jun 2025 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664774; cv=none; b=iG+zXQhZ9SWdNLo88Pnw6oJsZscJiEHm8f2Xzy+R9blJ3aZqdc9AWRLLcxCbRspcXV9DQ2cSYssMf54Ol00SdqLngRFxijasUJbF4EYknY+KF7NjvLe3lGpzJoy0A0EQ6GMHHb0d8o6v67V+9ysOTlkvTxiogdvwr0cklhgAz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664774; c=relaxed/simple;
	bh=Ha3d6EU+LDV8//CrsuOIY0ka7VTKRN1AMCeo/OLzfXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuaShGdva5q8yxiR0/ep5VkC4+K1T58aadL1x57IOof6Hq3Zkvzjjb0llkF7Yq5n2GePVjVcH4rQH+anQkcjs1DRwJ47AAGr4rss6WGF1Q2Eww/9G7LWPKAAzPY0BB3GyfNXpat13pvwmVqAwrPJ5Xz1ZUy7FwbdTlVrzNxixNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBiEwCSB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBiEwCSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B318DC4CEF1;
	Mon, 23 Jun 2025 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750664773;
	bh=Ha3d6EU+LDV8//CrsuOIY0ka7VTKRN1AMCeo/OLzfXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBiEwCSBhpEIDigOflulIbx5UFxYA6mn32of2lHlOC8emMq6LcnardFJWQPgev02y
	 LL2HENdK0xnNxjvsUScqjI+w8L0RGGKVl24OIL8+SLuT5IVWSRSciawQZ02Vb8+jaJ
	 DjvFBxE9SdcoMac/ghGcNfBOAoW5PIugXRzG/j+z9dJkQ7G4En+Rks6Dzz/enk4XUy
	 G/F321QOLcBZmeO60JH41OEaLW1GM46wKdL21mQjhzk2vgsgojT7TV4oHP1G0ntekt
	 yU6Z9Qs+VuHUpPoPc2yV/i+oEE1/IDQK91jNgAdNsVsLbqj677132V4Zxg+Zes8WuN
	 kifL1+0Fa/VWA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/5] serial: 8250: rename lsr_TEMT, iir_NOINT to lowercase
Date: Mon, 23 Jun 2025 09:46:04 +0200
Message-ID: <20250623074606.456532-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623074606.456532-1-jirislaby@kernel.org>
References: <20250623074606.456532-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are already variables like 'iir_noint1' and 'iir_noint2'. Follow
the preexisting lowercase naming of variables. So s/lsr_TEMT/lsr_temt/
and 'iir_NOINT' likewise.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 584563c45424..f67b206d1676 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2236,15 +2236,15 @@ static void serial8250_init_mctrl(struct uart_port *port)
 static void serial8250_iir_txen_test(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	bool lsr_TEMT, iir_NOINT;
+	bool lsr_temt, iir_noint;
 
 	if (port->quirks & UPQ_NO_TXEN_TEST)
 		return;
 
 	/* Do a quick test to see if we receive an interrupt when we enable the TX irq. */
 	serial_port_out(port, UART_IER, UART_IER_THRI);
-	lsr_TEMT = serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
-	iir_NOINT = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
+	lsr_temt = serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
+	iir_noint = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
 	serial_port_out(port, UART_IER, 0);
 
 	/*
@@ -2256,7 +2256,7 @@ static void serial8250_iir_txen_test(struct uart_port *port)
 	 * variable. So, in case of UPQ_NO_TXEN_TEST, let's just don't test if we receive TX irq.
 	 * This way, we'll never enable UART_BUG_TXEN.
 	 */
-	if (lsr_TEMT && iir_NOINT) {
+	if (lsr_temt && iir_noint) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
 			up->bugs |= UART_BUG_TXEN;
 			dev_dbg(port->dev, "enabling bad tx status workarounds\n");
-- 
2.49.0

