Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7826FD87;
	Wed, 11 Jun 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636240; cv=none; b=WEZuNkg5qzJIPCacfcPu9JY9RtKHARe/Su/Dx4r9MwgO8d1nONo8G8KZuNKfAQgqIAQSg+EvnxLeAdTFTE2AQi/fMZWR2AsIqRev6IBv74wPkLq+7VfLEcY93oNtb9ZCoTmvBD6KLOpn4DrfSd+KUz6si73HKUtgIlagkf0EHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636240; c=relaxed/simple;
	bh=yk7rS8uj6HMJ5l7KaUfXbIeHDknoyAKWxylgblqDUG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leBbbmn0AARrxgyq7x8/g4qjG6LWRt+CrFRDZ9wSjXB2BE1GNImvbqNO5GxrkhNwUm389gUYeE3cmezrWKBo01yewL2QtEo0cf9p6TTLuH6T4usbBvydwiP3DQDjfQHpGbglfRKZhMf5rFqOeL954Ee4q/1vSmeKgW1g/xQ6xWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzCpjg+y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzCpjg+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E88C4CEEE;
	Wed, 11 Jun 2025 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636240;
	bh=yk7rS8uj6HMJ5l7KaUfXbIeHDknoyAKWxylgblqDUG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzCpjg+yH5ePv7DpJE9qCDkCezIZ3nXkckOKrFjKY4uCS3G3ogR2KfEFaWR+4JtY0
	 /JXZqz+kZ6aZsQTMns/CJm2ZGM5d2U1QN36GjrCdZ3Rb8e18uPntcmZONR8v08DsjF
	 p+b5wQ7bSaFQZfYcggCFBf23LTJKS0m+WTb/vAfiz9j00MlzzfenvQ27f6su6JiOTK
	 0BqIDNjAJmZAw1jB2PWmg0mKkfB6U8kfNIJiAjp2FfuJBe08kLhfwS6xuRpHFlY7cB
	 iYnpNW4KSOnU6CaVemsUtnuYAstzzJzm70ia701MIw53l9i9z1XSnMudPZvGVwXw8P
	 LMgqSdWDv83NA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 19/33] serial: 8250: extract serial8250_set_trigger_for_slow_speed()
Date: Wed, 11 Jun 2025 12:03:05 +0200
Message-ID: <20250611100319.186924-20-jirislaby@kernel.org>
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

serial8250_do_set_termios() consists of many registers and up flags
settings. Extract all these into separate functions. This time, setting
of trigger level for slow speeds.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index edfbaa6b7a1b..52385314c426 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2686,6 +2686,24 @@ static void serial8250_set_mini(struct uart_port *port, struct ktermios *termios
 	}
 }
 
+static void serial8250_set_trigger_for_slow_speed(struct uart_port *port, struct ktermios *termios,
+						  unsigned int baud)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (!(up->capabilities & UART_CAP_FIFO))
+		return;
+	if (port->fifosize <= 1)
+		return;
+	if (baud >= 2400)
+		return;
+	if (up->dma)
+		return;
+
+	up->fcr &= ~UART_FCR_TRIGGER_MASK;
+	up->fcr |= UART_FCR_TRIGGER_1;
+}
+
 void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
@@ -2710,13 +2728,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_port_lock_irqsave(port, &flags);
 
 	up->lcr = cval;					/* Save computed LCR */
-
-	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		if (baud < 2400 && !up->dma) {
-			up->fcr &= ~UART_FCR_TRIGGER_MASK;
-			up->fcr |= UART_FCR_TRIGGER_1;
-		}
-	}
+	serial8250_set_trigger_for_slow_speed(port, termios, baud);
 
 	/*
 	 * MCR-based auto flow control.  When AFE is enabled, RTS will be
-- 
2.49.0

