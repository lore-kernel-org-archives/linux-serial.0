Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC20274FDF;
	Wed, 11 Jun 2025 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636258; cv=none; b=E5yDhaxPNoTyUS30xH62qbRcud4cCmnTIwqafVObslDBBcTwY1ktG85ndkOKsn+kb+RbQkvHABNO5c8GY8pmJyJDOoPUsNcTUOMZvxkcasCyetciSU84VbV92DKKcKUYpIV+uQATlvmsjeIFZX8as+s0emAhFav0sKO8nRiyn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636258; c=relaxed/simple;
	bh=XRkrlnSCwcbeRXUXQj1MvWIxyQPXeoOAi0mv2fldBwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFcESSPiAQvDUAY0/cyPcOnJf2EFUw2kX9MPpaB/fzutxAIicJcAB81J954dOxZTHrKXWQIWxm9efV7VthDkIH1auDobkxsvcQM1urhseIO919yO45oTJqablPIfZDMpOqq0ruNnK4Ea/qzXWz1OPUQ/dkg0UROXgEwPEw+662w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB1y23eo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB1y23eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA1FC4CEF1;
	Wed, 11 Jun 2025 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636258;
	bh=XRkrlnSCwcbeRXUXQj1MvWIxyQPXeoOAi0mv2fldBwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HB1y23eo9kJPYp7Gg1YiD6RrGgCeljBmKeelQ/JAzvWiWlAetVD7LZPzJniAcmX1a
	 pIqx/NkXcVQtveFRuKiXcLedsm/V6Vs/ofoI174WWYdTi4GsMfhptSgEcXnLcu+u9X
	 GdSNuGUJ41pW6VxZq/l4JpbZajGESSOdfeuE2fpzHSgnwV7IG6xsj11tYleQnf7MZa
	 5W5vG1XEMS408DGUCNxd+oQkY6x/2rsUBk10Ktqnc3rzdt+mKzLzctfvDtauxOsL6M
	 0NlpHjLejf53enA/eu7w26AzrrhqSmRbeHIc6+WvJAwbxRe3F81F+bii+ygFBmtV4O
	 RFQcagv45b3/Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 31/33] serial: 8250: invert condition to avoid a goto label
Date: Wed, 11 Jun 2025 12:03:17 +0200
Message-ID: <20250611100319.186924-32-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of "goto" in this code is frowned upon:
 +-------
 |if (port->type == PORT_UNKNOWN)
 |  goto out_unlock;
 |CODE;
 |out_unlock:
 +-------

Instead, simply do:
 +-------
 |if (port->type != PORT_UNKNOWN)
 |  CODE;
 +-------

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e93bfdac3d0e..48c30e158cb8 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1184,19 +1184,17 @@ static void autoconfig(struct uart_8250_port *up)
 	up->capabilities = uart_config[port->type].flags;
 	up->tx_loadsz = uart_config[port->type].tx_loadsz;
 
-	if (port->type == PORT_UNKNOWN)
-		goto out_unlock;
-
-	/*
-	 * Reset the UART.
-	 */
-	rsa_reset(up);
-	serial8250_out_MCR(up, save_mcr);
-	serial8250_clear_fifos(up);
-	serial_in(up, UART_RX);
-	serial8250_clear_IER(up);
+	if (port->type != PORT_UNKNOWN) {
+		/*
+		 * Reset the UART.
+		 */
+		rsa_reset(up);
+		serial8250_out_MCR(up, save_mcr);
+		serial8250_clear_fifos(up);
+		serial_in(up, UART_RX);
+		serial8250_clear_IER(up);
+	}
 
-out_unlock:
 	uart_port_unlock_irqrestore(port, flags);
 
 	/*
-- 
2.49.0

