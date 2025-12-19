Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACE33CEA1;
	Fri, 19 Dec 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.96.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144942; cv=none; b=DopKeQgPosgiaXeX+izvMRFIz3c2bWypmgmn4hDYlI9TDVZPtlQ/sFKTSTAEtNMZQt79MftmVnf9P076WGNwtH8E9+yb88dHnivgv+g6gPI/xy6ly/2SSC2qxdTgH5LCt+BseZGVDYcrCOEfs4DTqzUK4MXjs3bdQUlVspzifC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144942; c=relaxed/simple;
	bh=nqErMckt33cnJGbeAiTJLF5E0JyV6boKOW5rk+H9iWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hC1JlzfZ5leFtskNoXhE6KotZBubGiljnLCdttbipFJ4kIaECAqgbTPMUgc5jR4PQJSkLiqaqOxal8cORr6v/Byr5HnQihnaXnU3aRQc3P32dE34v6TfMiFm+OCLr7rPuUAEdcCy9S28t53tQhTZiyX7bo0JAc+Miv3Tl3r+92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech; spf=pass smtp.mailfrom=elsta.tech; dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b=iILWY+Bh; arc=none smtp.client-ip=194.150.96.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elsta.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b="iILWY+Bh"
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id A4AAA8C00C4;
	Fri, 19 Dec 2025 12:48:49 +0100 (CET)
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id DEvcV_dUNv5h; Fri, 19 Dec 2025 12:48:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 6B7308C00E1;
	Fri, 19 Dec 2025 12:48:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 6B7308C00E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
	s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1766144929;
	bh=hOpYl0LfA7bo1KbM/NIBBwUpBaJ7uesB4UvPkEViU2E=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=iILWY+BhjMKoV1KRmRYyIjX0AbkZtBhm34NMkFotbKlq9yJu7miFUTNwJWJbkLUbK
	 kuFzh2OgTZkcTx+qCYyrbMCMlyGELH8kPoUAxCTXEL8J1IROKwGT0BLu9am9Dv/sQ9
	 qcjdrSBjkLkusEuSZO2ATP+TSJPRDQWvWIZg+fwP52Jw5KtVPqHcMKTD6Fi9/91BM3
	 K+1aPZdGa7zFW5S895wkX7ExH497qyBw/jng2y17G2mqxCKnn0TajS4v5KZJRnnDmy
	 a9RfVTg8lVbRDW7vyzs4QBXsK82I0DJsWvOq8RtkHLOT6uSOMHQh1MkXT9mPjLKuLm
	 pRU8NSwcz2tsw==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id KQat8c1F5THC; Fri, 19 Dec 2025 12:48:49 +0100 (CET)
Received: from dev-VirtualBox.elsta-tech.lan (unknown [172.31.0.125])
	by mail.elsta.tech (Postfix) with ESMTPSA id 430E88C00C4;
	Fri, 19 Dec 2025 12:48:49 +0100 (CET)
From: "j.turek" <jakub.turek@elsta.tech>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: michal.simek@amd.com,
	namcao@linutronix.de,
	tglx@linutronix.de,
	zack.rusin@broadcom.com,
	sean.anderson@linux.dev,
	hshah@axiado.com,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"j.turek" <jakub.turek@elsta.tech>
Subject: [PATCH] serial: xilinx_uartps: fix rs485 delay_rts_after_send
Date: Fri, 19 Dec 2025 12:48:26 +0100
Message-Id: <20251219114826.135017-1-jakub.turek@elsta.tech>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RTS line control with delay should be triggered when there is no more byt=
es
in kfifo and hardware buffer is empty. Without this patch RTS control is
scheduled right after feeding hardware buffer and this is too early.
RTS line may change state before hardware buffer is empty.
With this patch delayed RTS state change is triggered when function
cdns_uart_handle_tx is called from cdns_uart_isr on CDNS_UART_IXR_TXEMPTY
exactly when hardware completed transmission

Signed-off-by: Jakub Turek  <jakub.turek@elsta.tech>

Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps dr=
iver")
---
 drivers/tty/serial/xilinx_uartps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xili=
nx_uartps.c
index 1e4d54fd5762..923a8b57ec82 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -432,6 +432,12 @@ static void cdns_uart_handle_tx(void *dev_id)
 	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
 		/* Disable the TX Empty interrupt */
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
+		/* Set RTS line after delay */
+		if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+			cdns_uart->tx_timer.function =3D &cdns_rs485_rx_callback;
+			rts_delay =3D ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart));
+			hrtimer_start(&cdns_uart->tx_timer, rts_delay, HRTIMER_MODE_REL);
+		}
 		return;
 	}
=20
@@ -448,13 +454,6 @@ static void cdns_uart_handle_tx(void *dev_id)
=20
 	/* Enable the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER)=
;
-
-	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
-	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
-		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
-		hrtimer_start(&cdns_uart->tx_timer,
-			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_=
REL);
-	}
 }
=20
 /**
--=20
2.34.1

