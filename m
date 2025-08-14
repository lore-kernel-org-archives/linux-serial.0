Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF217278E7E;
	Thu, 14 Aug 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156320; cv=none; b=YZepQD6OmnySSVHSWYZ2uH56lCnXWVj3mHFNRmX1QvJJRQVZih62lyRvtnLjCraISJyDEuMe3WAGEGEdTr4/e2B7CeuMeP8IOZfgtrnrN4QwtWJpmmr/JseHfBxEDMg5wAk4JQiOjJfFe95FH/xw72wn1X7YsyVS8GE9+xPID0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156320; c=relaxed/simple;
	bh=NEHsKObM4N+Xdy4uolnpMm7tU8yioXLoHI5CmmvF+eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxwLEW3Hd8Jg+xriX6EyHouZFNJu3JZ4vxIM8Q71L2R2Iz8+SbpsqKPbFcN0aDMdt0b4VhziM8dZPN1tHGlq2aMmhnfNaFGbbhKY35q4ZKVmmJ2BlUmUnKILae2DSv/qqqfjLLy88+XE4LTEC1zUHeNLiC8K8D3UVjNGi1iHGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOgdLyZi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOgdLyZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8D9C4CEEF;
	Thu, 14 Aug 2025 07:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156319;
	bh=NEHsKObM4N+Xdy4uolnpMm7tU8yioXLoHI5CmmvF+eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOgdLyZiOW0TEFUBmwYmvkxP3aOSQp6OjC4oMb5N6wixb9gtz1QQOM5+RQ1i2JC8b
	 BmMCu9UAe+NRRgxIu53Wta8JlYOP0P4eDHyFZElfnVeKR3C8XNo6xEdj+yORBM5PrW
	 RglrdEaSw8fZ6PKtkkR2+llL7CtpILfoNBY7tCTYAmNnCM/S1WfgDJ0hyMFbELJhAx
	 PhdUVTO+OHUNz3Rd3AHe/NJTOosNRRktEccFPNVCUElCdewf+yGR8nLEwAU/vw2d/h
	 zNhoT5+RQ7zYkKz4EqSiMqheLHlBn1B0wElPEwNRwRRvKhPAvk2/1PIBKetMsz1Ld+
	 6VuoTrZvZ8XGw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 13/16] serial: 8250_rsa: use guard()s
Date: Thu, 14 Aug 2025 09:24:53 +0200
Message-ID: <20250814072456.182853-14-jirislaby@kernel.org>
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

Having all the new guards, use them in the 8250_rsa code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_rsa.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index d34093cc03ad..ff52ad02f6be 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -140,9 +140,8 @@ void rsa_enable(struct uart_8250_port *up)
 		return;
 
 	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-		uart_port_lock_irq(&up->port);
+		guard(uart_port_lock_irq)(&up->port);
 		__rsa_enable(up);
-		uart_port_unlock_irq(&up->port);
 	}
 	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 		serial_out(up, UART_RSA_FRR, 0);
@@ -165,7 +164,8 @@ void rsa_disable(struct uart_8250_port *up)
 	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16)
 		return;
 
-	uart_port_lock_irq(&up->port);
+	guard(uart_port_lock_irq)(&up->port);
+
 	mode = serial_in(up, UART_RSA_MSR);
 	result = !(mode & UART_RSA_MSR_FIFO);
 
@@ -177,7 +177,6 @@ void rsa_disable(struct uart_8250_port *up)
 
 	if (result)
 		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-	uart_port_unlock_irq(&up->port);
 }
 EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_disable, "8250_base");
 
-- 
2.50.1

