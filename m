Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CF2571A2;
	Tue, 24 Jun 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752407; cv=none; b=P7AywD5ZKZNPW/4Eghb91siu5N2oLKkdlv4N13QRndq+xTqi0sdUJj0pMXKl9ewfUpvcYqTVzVyv5ep6nCjNneROZvgxpNIEVM18LQ8VI9nF1D41flFUo1f51vtHd2ExfPSaNqRujsieR/2rZ8tG4SLLlkxPBukpDIjlH6wGpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752407; c=relaxed/simple;
	bh=ZDOr+KyMbsjP150xtbS+m55ZlY3PgRkTcYJNBAoR6bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD47Z0so83hc44woCDS+E+UCvMZVsrOwl6B18qnSHaBA5fNKYUY5LRiHdsXR9wzcD230vbo+C8oS+VK7Mys2Ekc4npOsdbNdpVziN+ahj0kRSQsfIFisFF2aIL3aJDFbrnHzaYSdVIlUL3nZwkXTvHK/mIVwThpmAoNQH6oWgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK+gTj6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK+gTj6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5A0C4CEF2;
	Tue, 24 Jun 2025 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750752406;
	bh=ZDOr+KyMbsjP150xtbS+m55ZlY3PgRkTcYJNBAoR6bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZK+gTj6zBEYCkP5QGKOUTM0u9El+p1qcOXeqAcSiDJpGxAAIjyptVoredENyt0+7e
	 BoWxMy4jgZFwPQafSuWc6CQjpjRuZiELL9oeLosAKdNECMjHW5axvZuYuxJvAwGf2u
	 8MmMJCPtSjql7kcMEdoaWNOTcc+kEuX1FqtPrsljG+H9rTPmLAfXzn1MDDOadCABzm
	 xXTJS/2BVhxt/4CU+8FiyjdCJX6OWTj/2q+ElOTMosy7g6TVqTADnwYQj1pDpW0tFX
	 DLhpel13xyQCjXiFQYfWHIRohJwMrMXNHZSOAan8C9c4APV9hF7tDlpB4Xu8GpGLIY
	 JvN6rvbnX80+Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/5] serial: 8250: extract serial8250_init_mctrl()
Date: Tue, 24 Jun 2025 10:06:37 +0200
Message-ID: <20250624080641.509959-2-jirislaby@kernel.org>
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

After commit 795158691cc0 ("serial: 8250: extract
serial8250_initialize()"), split serial8250_initialize() even more --
the mctrl part of this code can be separated into
serial8250_init_mctrl() -- done now.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
[v2]
* use port-> directly.
* do not remove curly braces.
Both rebase errors -- noticed by Andy.
---
 drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 48c30e158cb8..0f85a2f292fc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2216,15 +2216,8 @@ static void serial8250_THRE_test(struct uart_port *port)
 		up->bugs |= UART_BUG_THRE;
 }
 
-static void serial8250_initialize(struct uart_port *port)
+static void serial8250_init_mctrl(struct uart_port *port)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
-	bool lsr_TEMT, iir_NOINT;
-
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
-
-	uart_port_lock_irqsave(port, &flags);
 	if (port->flags & UPF_FOURPORT) {
 		if (!port->irq)
 			port->mctrl |= TIOCM_OUT1;
@@ -2235,6 +2228,18 @@ static void serial8250_initialize(struct uart_port *port)
 	}
 
 	serial8250_set_mctrl(port, port->mctrl);
+}
+
+static void serial8250_initialize(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+	bool lsr_TEMT, iir_NOINT;
+
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
+
+	uart_port_lock_irqsave(port, &flags);
+	serial8250_init_mctrl(port);
 
 	/*
 	 * Serial over Lan (SoL) hack:
-- 
2.50.0

