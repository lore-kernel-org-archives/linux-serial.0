Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A3449EA4;
	Tue, 18 Aug 2026 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045980; cv=none; b=P+MqEM1MqdGvCVH2OPd4QnP/oMb95gOBa32N4w+MhI7Mq3DU0QoaDsMQhRHm+m5Ovb/KxDdKwozUW3MhxnbpInQNQ5TlhppAdh0huoh8ZyVIt/sR2oYNpblKPLSsQOvvPPoPr4eV/mYbn6UyfCLMIUnk+46utG07AF0OVTIcX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045980; c=relaxed/simple;
	bh=4IoK/wKy91VljtjS/W0D5fC8iTeqrp3TDCvEjBk7mMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNTwirCQpCRus+z0asiYeHD/XiFjxkHuzLvvA5+0FOj48OWLpDTgZSGIV5lx1ngSy5Z0fSANcHCCE8knPsqN8mpjqSkSPC0x44scLfL3nJmrRk0UsdWJYxRjjO3dxteeXCm96zrw6zgCawEzAK/sYxJTXHgHg8h9kXrg1wwcmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b6a6e79e9ae811f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b539aa13-20c0-4179-88c9-9d355da0251d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:de7f13e3d55880741d133f6f2f557bbd,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b6a6e79e9ae811f19a56ed5b684f684d-20260818
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1524043102; Tue, 18 Aug 2026 17:39:31 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH 3/3] serial: 8250_mxpcie: take the line settings from the new termios
Date: Tue, 18 Aug 2026 17:39:18 +0800
Message-Id: <20260818093918.3190686-4-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818093918.3190686-1-lilinmao@kylinos.cn>
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mxpcie8250_set_termios() reads the line settings out of
port->state->port.tty, which is only set once the port has been opened.

uart_set_options() builds a termios of its own and calls ->set_termios()
with no tty behind it, so using such a board as the console
(console=ttyS<n>) dereferences a NULL tty during console setup, as does
attaching kgdboc to it and resuming a suspended console from
uart_resume_port().

Read the settings from the termios the serial core passes in instead.
It holds the same values on the normal path - uart_change_line_settings()
passes &tty->termios - and it is what serial8250_do_set_termios() right
above already uses.

Fixes: 55edf8511f47 ("serial: 8250_mxpcie: enable automatic RTS/CTS flow control")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index ddd02d5622ec4..eba59f1724b78 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -217,8 +217,7 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 				   const struct ktermios *old)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	struct tty_struct *tty = port->state->port.tty;
-	unsigned int cflag = tty->termios.c_cflag;
+	unsigned int cflag = new->c_cflag;
 	u8 efr, val;
 
 	serial8250_do_set_termios(port, new, old);
@@ -233,18 +232,20 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
 	}
 	/* Set on-chip software flow control character */
-	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
-	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
-	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
-	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
+	serial_out(up, MOXA_PUART_XON1, new->c_cc[VSTART]);
+	serial_out(up, MOXA_PUART_XON2, new->c_cc[VSTART]);
+	serial_out(up, MOXA_PUART_XOFF1, new->c_cc[VSTOP]);
+	serial_out(up, MOXA_PUART_XOFF2, new->c_cc[VSTOP]);
 
-	val = I_IXON(tty) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_RX_FLOW_DISABLED;
+	val = (new->c_iflag & IXON) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 :
+				      MOXA_PUART_EFR_RX_FLOW_DISABLED;
 	FIELD_MODIFY(MOXA_PUART_EFR_RX_FLOW_MASK, &efr, val);
 
-	val = I_IXOFF(tty) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_TX_FLOW_DISABLED;
+	val = (new->c_iflag & IXOFF) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 :
+				       MOXA_PUART_EFR_TX_FLOW_DISABLED;
 	FIELD_MODIFY(MOXA_PUART_EFR_TX_FLOW_MASK, &efr, val);
 
-	if (I_IXOFF(tty))
+	if (new->c_iflag & IXOFF)
 		up->port.status |= UPSTAT_AUTOXOFF;
 
 	serial_out(up, MOXA_PUART_EFR, efr);
-- 
2.25.1

