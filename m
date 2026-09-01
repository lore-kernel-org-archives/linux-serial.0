Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B813A5430;
	Tue,  1 Sep 2026 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236148; cv=none; b=lSt4q/Wm23mLcSgFvk1cfLlyujt/nCsVvsCle+NMI8qTaxMI80pM1ocWE60jmWQIzYfh1Yt5wBp4IUcZlwTY7S2LprlO9hkSJ30gz+Y8tv0LfpQWh3r6QBSmDhsIaelAKT9apNKnjDSOeC75N7UkJxK7g3ETFWd627nJxy53o+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236148; c=relaxed/simple;
	bh=yf68TTgUIkR4IjDODrHc2nhmYFZ+HJAuwDmMMri5yxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8HM5lbCZMp0af4hdeW9X9ZO2khrr17komNz7IFgnmSiwfKSlwFN4y9s8zGM8WR9b+HJjekrg5cIp4UwRu05bbh/YDxZoDCEcgVzBp57NDYFE5DOediGVO837sRvu+bvokMYDUyKojnUxQTqPpu2KPoxceo154O1SccCu5KaRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c8b3bac4a5bb11f19a56ed5b684f684d-20260901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:40469b12-bed6-41a0-a530-736f07895db3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:56bbbc179ddccb1321aa4a7320c3960f,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c8b3bac4a5bb11f19a56ed5b684f684d-20260901
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1787754201; Tue, 01 Sep 2026 12:15:36 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v2 3/3] serial: 8250_mxpcie: take the line settings from the new termios
Date: Tue,  1 Sep 2026 12:15:19 +0800
Message-Id: <20260901041519.114737-4-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901041519.114737-1-lilinmao@kylinos.cn>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
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
Tested-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
v2: drop the cflag local, read new->c_cflag directly (Crescent Hsieh).

 drivers/tty/serial/8250/8250_mxpcie.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index ef2516ec16da..19f1f51eec47 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -218,8 +218,6 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 				   const struct ktermios *old)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	struct tty_struct *tty = port->state->port.tty;
-	unsigned int cflag = tty->termios.c_cflag;
 	u8 efr, val;
 
 	serial8250_do_set_termios(port, new, old);
@@ -229,23 +227,25 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 	efr = serial_in(up, MOXA_PUART_EFR);
 	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
 
-	if (cflag & CRTSCTS) {
+	if (new->c_cflag & CRTSCTS) {
 		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
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

