Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C271DE2A5;
	Sun, 21 Dec 2025 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.96.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766313179; cv=none; b=iz5waZyNgp86Hk257btj4aV2+ti+ZouBffJF49B2upxvCZ1V5/1gAHIxD4Dd5opljA3a7oROXvnvpEpZ3Nk90TbMsLk0VYqJHmtS0WfH14mKpUvy1oGw8lbL9e7lfcMs7x0ZJsTo2hMUFwpxA4sYYp5IHpKqF2w+t2k2Yd5PR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766313179; c=relaxed/simple;
	bh=Tt5XdgemmBOVqkMn1R2s74zlKvwMopMztCs+Fbq5xCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/IBYYMxJGhNAOT8ctuqBovue9jkCyUGd0Q2wIEFpNypdHKwAli6b9rps0vZpYSdNBcjLkBm049v1B+3m7L3fa+J3RPJUeHwi0Q4D13Nx2L9DuBnqONqzncPxYj4SRIs214BKpkzL6yifqgZ3GhVgGw9CFYEIse9fzoUNk0lCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech; spf=pass smtp.mailfrom=elsta.tech; dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b=PBoc1kjE; arc=none smtp.client-ip=194.150.96.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elsta.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b="PBoc1kjE"
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 006E28C00C4;
	Sun, 21 Dec 2025 11:32:46 +0100 (CET)
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id FwUVyEzGZUEm; Sun, 21 Dec 2025 11:32:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id AD6758C00E1;
	Sun, 21 Dec 2025 11:32:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech AD6758C00E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
	s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1766313166;
	bh=ryuX/qitU2BIwDF+E9hyeH8B+3/BmCHfNnTrdhmPIWU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=PBoc1kjEXEnSCy7xR4sOTnWO0jBSlItt5r7kemJ94c4hVXTQCIjDxxTSwuKwfzxUj
	 PkyBfGDL7RkeRZAfLIaXkrSG/F/OMCuSzdH0GDqxyvIogc+MjILpk4EKLmtUX9qQtk
	 W/xZh3vthdzFBOXIPI9IzlspaC2NibKMDUGD9RaL3UKUs2mzunZCW7xlXk8UcKGqs2
	 1ovpFZk2d8cUNlAmMnwAro8P6iVr6TwuVY2zkAXFhWA9masZ/u+TdvXgLDLKFlEPZi
	 uRdsEZHIKYvZya5hwCWJ3I2whuY1B9POkKTrSIxA3V8eI3CsYWGXvTYY4uVCAhH5fg
	 Zt9wAGGXf4uWA==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id iyEbB486Pprq; Sun, 21 Dec 2025 11:32:46 +0100 (CET)
Received: from dev-VirtualBox.elsta-tech.lan (unknown [176.221.120.47])
	by mail.elsta.tech (Postfix) with ESMTPSA id 1D9AE8C00C4;
	Sun, 21 Dec 2025 11:32:46 +0100 (CET)
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
Subject: [PATCH v2] serial:xilinx_uartps:fix rs485 delay_rts_after_send
Date: Sun, 21 Dec 2025 11:32:21 +0100
Message-Id: <20251221103221.1971125-1-jakub.turek@elsta.tech>
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
 drivers/tty/serial/xilinx_uartps.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

v2:
 - Fix build error by declaring rts_delay as ktime_t

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xili=
nx_uartps.c
index 1e4d54fd5762..8b08f478253e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -428,10 +428,17 @@ static void cdns_uart_handle_tx(void *dev_id)
 	struct tty_port *tport =3D &port->state->port;
 	unsigned int numbytes;
 	unsigned char ch;
+	ktime_t rts_delay;
=20
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
@@ -448,13 +455,6 @@ static void cdns_uart_handle_tx(void *dev_id)
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

