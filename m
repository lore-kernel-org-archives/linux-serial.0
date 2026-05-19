Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1F3E0090
	for <linux-serial@vger.kernel.org>; Tue, 19 May 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184632; cv=none; b=eLAaUAt6AFxDVIr5dMmU+r99wpHxF143UUIvLdlUh1RUviyvhruxwqzTKsHm8tB47tH4zXy76CIeKEqfzqWWnnSAcgNLou71X1qXjWvTVgTJs77V+KkLLXlzyDsBHuvm950VocU/+TA9LAMjRyvq6b3YyaJ4XkiYrMI+uss4NzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184632; c=relaxed/simple;
	bh=uyOetSGmhVwdxZjrC96qC99865zHFawgJgkaCq1A7Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ioXslRlju7nHSqWxzk8rwfskOOLLTxpDVA4ONQjU5dscwNfJASBqhGklE6p6K8zTNncYipaz4WhnWiygOqxQzfaUmJ08ModuS0a4vjSPZzH8jAiJV8+NEJELrP76UH8+eFnAPo8wE5HMbIFBHphbOQIFv5wJacdrrvG9naQUa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1wPHCD-00070b-EF; Tue, 19 May 2026 11:57:05 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 19 May 2026 11:57:00 +0200
Subject: [PATCH RFC] serial: 8250: fix possible ISR soft lockup
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-v7-1-topic-serial-8250-v1-1-56b04293a246@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAOszDGoC/x3MOQqAMBBA0avI1A5kIW6t4AFsxULiqAOikkgQx
 LsbLX/x/g2eHJOHKrnBUWDP+xZDpgnYZdhmQh5jgxIqE0aWGHKUeO4HW/zosGKhjEChJ5sZnZM
 2BBEfjia+/nEHbVND/zwv0lw26G0AAAA=
X-Change-ID: 20260519-v7-1-topic-serial-8250-03fc6537e35e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 k-willis@ti.com, m-shah@ti.com, kernel@pengutronix.de, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

There are rare cases in which the host gets stuck in the ISR because it
is flooded with messages during the startup phase.

The reason for the soft lockup in the ISR is the missing FIFO error IRQ
(FIFOE) handling. Not handling it and reporting IRQ_HANDLED triggers
the IRQ immediately again.

Fix this by adding a check for the FIFOE status and clearing the FIFO
if no data is ready (DR).

This behavior was observed on an AM62L device which uses the OMAP 8250
driver. Fix it for all 8250 drivers, since the OMAP driver's special
IRQ setup handling may trigger this behavior more frequently, but it
is not ensured that other 8250 drivers aren't affected.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index af78cc02f38e719573becd0aea226f7790555a3e..f9135df3cc7c2662522197518995e5e1a6880ec2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1797,6 +1797,13 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 
 	status = serial_lsr_in(up);
 
+	/*
+	 * Recover from no-data-ready and FIFO error condition to avoid getting
+	 * stuck in the ISR.
+	 */
+	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
+		serial8250_clear_and_reinit_fifos(up);
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260519-v7-1-topic-serial-8250-03fc6537e35e

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>

