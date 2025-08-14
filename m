Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B527146B;
	Thu, 14 Aug 2025 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156309; cv=none; b=XVdXoeejk1X7Kn4EM0LTGCBxU/m+nppcZKhiXc2eislPHmQcmoHm7yRobLWycmS56/rCRpfVfIk8bcQM0YlOWUmNLdzqmIDJUritjV1zOQ7ixzSNHpeJifgNExngg0YzwtXfrnR2ad2Eqp6I/mdm7wNNdDcDH9ZL91UmnewAlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156309; c=relaxed/simple;
	bh=SZxDq7QAhVN1IAYE84RwYsUZjBe/0T/DfTN+tw2c/G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qehCqHOdU4wAP5WPD4NdQyev47Wf+4XXigL0wfIRuMRvyqkISyv4LH15MBqSLCwDX/n8i/dAX9TBIz55CCfd/k3R8l+t/otrRT90Sr0KU2f383lSZiOXLd0bqQRrw3Ttv7Q5wkIUFRuPlP22ouyH6icb5tZp1Ey4zjPmmGjuyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPKxkaN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPKxkaN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826D7C4CEF5;
	Thu, 14 Aug 2025 07:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156308;
	bh=SZxDq7QAhVN1IAYE84RwYsUZjBe/0T/DfTN+tw2c/G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPKxkaN2RRlS5aaX7OgShzCwVGRYjdad1FO60ujGaHYvRtiisQctBfyimMU7zNUBZ
	 Fjgy3n8QnJCz58DmF5pCXM1btPBqQ0T8btxxKW0+ReHJfxmT8abNbBR79q9UEntgGC
	 hv8TPoBlTSFJUOuhqs6r4Cb0zpvK3NdeFO10c0fvZvZT66umON42qzxrFh81GtAhQv
	 +BZykdYX23TNwMR4TsrksC2/j+unQiTLLD2NuMCsmhfikGm2C+QUIhF12U6hLwUGql
	 pWQkmxWkcx5wBEiVP/ZmaFUGd7sSXie7qi5GGM9g0ZfzFIfqTxBm36ZYCr8xk3l1yB
	 zqf2EXqymDomg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/16] mxser: use tty_port_tty guard() in mxser_port_isr()
Date: Thu, 14 Aug 2025 09:24:46 +0200
Message-ID: <20250814072456.182853-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped_guard() and reorder the function. This is done separately
from the other changes, as it is slighly more intrusive: scoped_guard()
handles the have-tty case and returns. The non-tty case is done at the
end of the function.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/mxser.c | 62 +++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 2fc13cc02cc5..b070ebf9f51a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1600,54 +1600,50 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 
 static bool mxser_port_isr(struct mxser_port *port)
 {
-	struct tty_struct *tty;
 	u8 iir, status;
-	bool error = false;
 
 	iir = inb(port->ioaddr + UART_IIR);
 	if (iir & UART_IIR_NO_INT)
 		return true;
 
 	iir &= MOXA_MUST_IIR_MASK;
-	tty = tty_port_tty_get(&port->port);
-	if (!tty) {
-		status = inb(port->ioaddr + UART_LSR);
-		outb(port->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
-				port->ioaddr + UART_FCR);
-		inb(port->ioaddr + UART_MSR);
 
-		error = true;
-		goto put_tty;
-	}
+	scoped_guard(tty_port_tty, &port->port) {
+		struct tty_struct *tty = scoped_tty();
 
-	status = inb(port->ioaddr + UART_LSR);
+		status = inb(port->ioaddr + UART_LSR);
 
-	if (port->board->must_hwid) {
-		if (iir == MOXA_MUST_IIR_GDA ||
-		    iir == MOXA_MUST_IIR_RDA ||
-		    iir == MOXA_MUST_IIR_RTO ||
-		    iir == MOXA_MUST_IIR_LSR)
-			status = mxser_receive_chars(tty, port, status);
-	} else {
-		status &= port->read_status_mask;
-		if (status & UART_LSR_DR)
-			status = mxser_receive_chars(tty, port, status);
-	}
+		if (port->board->must_hwid) {
+			if (iir == MOXA_MUST_IIR_GDA ||
+			    iir == MOXA_MUST_IIR_RDA ||
+			    iir == MOXA_MUST_IIR_RTO ||
+			    iir == MOXA_MUST_IIR_LSR)
+				status = mxser_receive_chars(tty, port, status);
+		} else {
+			status &= port->read_status_mask;
+			if (status & UART_LSR_DR)
+				status = mxser_receive_chars(tty, port, status);
+		}
 
-	mxser_check_modem_status(tty, port);
+		mxser_check_modem_status(tty, port);
 
-	if (port->board->must_hwid) {
-		if (iir == 0x02 && (status & UART_LSR_THRE))
-			mxser_transmit_chars(tty, port);
-	} else {
-		if (status & UART_LSR_THRE)
-			mxser_transmit_chars(tty, port);
+		if (port->board->must_hwid) {
+			if (iir == 0x02 && (status & UART_LSR_THRE))
+				mxser_transmit_chars(tty, port);
+		} else {
+			if (status & UART_LSR_THRE)
+				mxser_transmit_chars(tty, port);
+		}
+
+		return false;
 	}
 
-put_tty:
-	tty_kref_put(tty);
+	status = inb(port->ioaddr + UART_LSR);
+	outb(port->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+			port->ioaddr + UART_FCR);
+	inb(port->ioaddr + UART_MSR);
 
-	return error;
+	return true;
 }
 
 /*
-- 
2.50.1

