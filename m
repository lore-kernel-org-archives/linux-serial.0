Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A903D9667
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524780; cv=none; b=XziRhtaVokDg/smTY0VoRcFINbPxtrAb7fgXhA9xJjg0w/qZocusXv53ur5DeNFpzHUSN4pFCxaDq92G7GH0C1SrKQyv0d3Gg+jFJnhYtS6G7a2zIeIUSyHxUVm2DBj3cmeJ2SAt/GpLUjoq1LSKnU5jIaARw8fr1z2PyrrjLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524780; c=relaxed/simple;
	bh=PCefaLqCaiTst9QTucwxtNu7QiAxVSwnxoESaqfZnYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeEUpN9ntMU2tqTFNqtt7h2L3zl6jGDnTv3X9JnaXQPN3G0IG4/k+bis5tseboU7baKHIi6AF2IzMPDZeEqtFBeW21+yRimCoKxoZ+cymHvfGXoA02IiNqdLU/+bUjbIZelT8S0NMGRDa+2SK21UUYugvmoCY6Ch3+IWIj1p+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iiy1TXdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iiy1TXdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E601F00893;
	Fri,  9 Oct 2026 05:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791524778;
	bh=tRFvbCFu1LMeK110YVNXO+VUVwItswJjOjDMEkLoaiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iiy1TXdq1Sa4I5i3uB272LNdL63ChVUYUCR5/HDRKnEqZmxCulQGxwKJweFFLCL2T
	 SOgksvmiWcHa21nxhajqtLVpzlkHKdXPsEF18ujSG5khkeiykMw+JvmzI2rzkU4b9k
	 n0o1EVa+X3SXmWtY1AZXMiLV9T02LZk4HUgEo5nlWhC68dncKdJ9jLViv13j4sn7Do
	 n38lv7w6yF65QvMKbuJXPtpAqL2eovgyDkP8mOiykZBKnvu8Ch0ZQabAUPgEAGs4+c
	 SZ6iyCeMXRGJ1kF6t88prgs+J8961UbfnqFBBhNU+5KntsP7uNV/oj7EsgXl2MV/hr
	 FIae/g96Fyz7w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/3] serial: 8250_omap: set priv->line before enabling the IRQ
Date: Fri,  9 Oct 2026 07:46:11 +0200
Message-ID: <d25b0dc9f84e7cd9b42324a19cbe4b4f78164172.1791524724.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791524724.git.jirislaby@kernel.org>
References: <cover.1791524724.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap8250_irq() is requested in omap8250_probe() with IRQ_NOAUTOEN and
enabled only in omap_8250_startup(). The handler obtains the port by
serial8250_get_port(priv->line), but probe stores priv->line only after
serial8250_register_8250_port() returns.

The port becomes visible to userspace already inside
serial8250_register_8250_port() (uart_add_one_port()). So it can be
opened -- and the IRQ enabled -- before probe stores the line. An
interrupt in that window makes the handler call
serial8250_get_port(-ENODEV) and dereference a pointer outside of
serial8250_ports[].

Store the line in omap_8250_startup() before enable_irq(), so the
handler never runs with an unset line. Keep the assignment in probe
too, as remove and the system PM callbacks rely on it even when the
port was never opened.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: LLM
---
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/8250/8250_omap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 3a1473bf54d0..137175aa4183 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -711,6 +711,9 @@ static int omap_8250_startup(struct uart_port *port)
 	struct uart_8250_dma *dma = &priv->omap8250_dma;
 	int ret;
 
+	/* ISR and runtime PM need the line; probe sets it only after registration */
+	priv->line = port->line;
+
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
 #endif
-- 
2.56.0

