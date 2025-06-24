Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98463258CEC;
	Tue, 24 Jun 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752410; cv=none; b=WIkPc+5QPvToeTxXdTtonn/ZPUzYpB7V3upWiLeAwfGgeDmnOoed7R6TMmFoGCQijOBzweiGF/vlPwryz0nF/l68yr2hYxsVHalZ3rbMqX/QSYj40ipCZHWaMZzQUShzcNIchwhSXSI79Rbc4R5PrPIDAhFD3/0fwHz7+3wPSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752410; c=relaxed/simple;
	bh=4xjvZivOuut/sjOkmbzk/yXmDgBAAax9IEc4i93j2Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjpZOLvOiWy8RjadDmaa5qE8V50VgD3qLgaWPZ2d23PQiRV7H/kO+xl82/63YWlBoH55G1+571Zf/WemtEHkbcTtSuqb+uPn2c+YcXYxnLgq+2cpE1+usl6PgW65OA4Q1C5yGXEM47ER8bx7n9f6MZ/FlxrzyhUlCrGH5uVRDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOktpqFV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOktpqFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC0C4CEF2;
	Tue, 24 Jun 2025 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750752410;
	bh=4xjvZivOuut/sjOkmbzk/yXmDgBAAax9IEc4i93j2Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOktpqFVl0L/fzuqOcAsQg6Ih9Xe4VfDIiKI+TQZldN4orRSbzRLKOTObOynLDeaS
	 QjbigIniEBfTu0SWWf6dKxSezyLsT/Jkj/Zyw/vJ0hdVLGgMSwzar0AUJhDlbJDGp+
	 RxhP1qkv5t4dBvQ5ntgPGBc85PgUT4fASr/1MsjownnpK9gedxNALWCwT5Ymc73tR2
	 rRNJvGs4za80ys8i9Uepa1+JE6QB+aKrNaAnxLooWQkfqvYz3xZT6XQkxFNCchbUBd
	 OV7/4Jm0uHsiGjbeLt7b1TDzACn0JrQBaemt1jEcz/magYAdGKGXw2pTUisEYXsY3O
	 GM6wdHV3ktPIg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/5] serial: 8250: rename lsr_TEMT, iir_NOINT to lowercase
Date: Tue, 24 Jun 2025 10:06:39 +0200
Message-ID: <20250624080641.509959-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250624080641.509959-1-jirislaby@kernel.org>
References: <20250624080641.509959-1-jirislaby@kernel.org>
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
index 5bb0ca04da55..7eddcab318b4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2233,15 +2233,15 @@ static void serial8250_init_mctrl(struct uart_port *port)
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
@@ -2253,7 +2253,7 @@ static void serial8250_iir_txen_test(struct uart_port *port)
 	 * variable. So, in case of UPQ_NO_TXEN_TEST, let's just don't test if we receive TX irq.
 	 * This way, we'll never enable UART_BUG_TXEN.
 	 */
-	if (lsr_TEMT && iir_NOINT) {
+	if (lsr_temt && iir_noint) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
 			up->bugs |= UART_BUG_TXEN;
 			dev_dbg(port->dev, "enabling bad tx status workarounds\n");
-- 
2.50.0

