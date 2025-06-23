Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2146F1FCFE7;
	Mon, 23 Jun 2025 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664771; cv=none; b=JKe8O5i8AsGKvt5NG0aiW5vv7wPk3neARajHiK1Zc2kOxgqvakDElzmIwhGc7mR5BRR8zenOQU7qMtAev/zE6jy2icjmP5oGVUr4yKEwBheto5lDkMEG6Ba4rOkulR9824KKTX9er/XBe0zVJSLoNhsPRr4DobgOW5zmovW97v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664771; c=relaxed/simple;
	bh=8PdxRbGHrTIbYeZaZWAnu2iO4cbJH8QbP9FyCJlwLrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeuAviQE7mrCQPS060LC3943DAAUp+sxjdfS8ssBL6bZ7AEsML9/lD/LSUNv5wVJLJal9cnNVVFYyY8fOUaKmdoLuC9XFiDU/345Cufuf14tfv3yXLXAsIumnUu4y06MGFUZlpGRzA42x1SKAmXWLxiNlwVXDLfjVeZQNSfrGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3r2X5tu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3r2X5tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6599BC4CEEF;
	Mon, 23 Jun 2025 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750664770;
	bh=8PdxRbGHrTIbYeZaZWAnu2iO4cbJH8QbP9FyCJlwLrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3r2X5tu3C6XnqrDjuoak9CQfAHrjMxtutDEN73F2HgTBUcWlQajudqPqLnlWql+v
	 ldBKzbjJrsS7QpxJRv1lb05lErjT5UTqzhrkhFYnFNcYSXh501wV4r423W+rLfTCXy
	 X/rabZyiYFurgKwR6Up2NDUPdnKWAjTlx/5P4GsvXlRGMK5cJpUDWDitfBvkXTVJTP
	 7CzOYfUfe2I6L+YJIY8oCOmBT2rij2R+/q8YvBsuVif8hRuZJT91ilRNp7aaHbSAZr
	 iE3spA8thxaVirbVt26JtpFOuIG2rMFYPpgA0hikZgv2KBXjdLJ0uVDMHvJvGHENTZ
	 zcrT/yXXNrpiA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/5] serial: 8250: extract serial8250_init_mctrl()
Date: Mon, 23 Jun 2025 09:46:02 +0200
Message-ID: <20250623074606.456532-2-jirislaby@kernel.org>
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

After commit 795158691cc0 ("serial: 8250: extract
serial8250_initialize()"), split serial8250_initialize() even more --
the mctrl part of this code can be separated into
serial8250_init_mctrl() -- done now.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 48c30e158cb8..ca82ce26715a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2216,6 +2216,23 @@ static void serial8250_THRE_test(struct uart_port *port)
 		up->bugs |= UART_BUG_THRE;
 }
 
+static void serial8250_init_mctrl(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (up->port.flags & UPF_FOURPORT) {
+		if (!up->port.irq)
+			up->port.mctrl |= TIOCM_OUT1;
+	} else
+		/*
+		 * Most PC uarts need OUT2 raised to enable interrupts.
+		 */
+		if (port->irq)
+			up->port.mctrl |= TIOCM_OUT2;
+
+	serial8250_set_mctrl(port, port->mctrl);
+}
+
 static void serial8250_initialize(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2225,16 +2242,7 @@ static void serial8250_initialize(struct uart_port *port)
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	uart_port_lock_irqsave(port, &flags);
-	if (port->flags & UPF_FOURPORT) {
-		if (!port->irq)
-			port->mctrl |= TIOCM_OUT1;
-	} else {
-		/* Most PC uarts need OUT2 raised to enable interrupts. */
-		if (port->irq)
-			port->mctrl |= TIOCM_OUT2;
-	}
-
-	serial8250_set_mctrl(port, port->mctrl);
+	serial8250_init_mctrl(port);
 
 	/*
 	 * Serial over Lan (SoL) hack:
-- 
2.49.0

