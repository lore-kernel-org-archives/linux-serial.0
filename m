Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663A26FA4E;
	Wed, 11 Jun 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636238; cv=none; b=Etlg5dXoqtBWe/tH09jRaaepB+bwKYnBgh9LTM4Wybs8qZfNSlyAc/TACI4IhhocOvpIvYZmdPvHktdpHwohqRGy+9MHsSRL50xuJDXyY5y9Pw7NvBvpaQgmUC2qb7LqY9V3vFd+KKYYpRKbB66ZliQwD/1uP8Ds7Z4Qd43kYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636238; c=relaxed/simple;
	bh=xaJJlQcxKm++tvGMXyDRzn8B2BvesW+EjNbVHmVVJug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtgDt6Sb3yPOuIFZYPSZfM8D3DB77aFoR++VUoqo9agKWb0JxEJhCdyJhxXMD04e1i8Yur4ASKmuhXU7vcWcCJ4IYTFnTnllZRQtSrsqF0BYeEL4XBWkbjnC8VllBFC58ZnLWPXhemYy63Nkb/quTuLti64s2M20M4XXLmGMa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKPjiF70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKPjiF70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DCCC4CEEE;
	Wed, 11 Jun 2025 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636238;
	bh=xaJJlQcxKm++tvGMXyDRzn8B2BvesW+EjNbVHmVVJug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKPjiF70Z9ktWH2DzYCR1IMSJdDGOIOyBvbS1GMXPfZUKNaIeSw8l2dnIw31Lhyxy
	 H2pCQ00z3f/6QmiOJYTP/RqLwKmw2cHiB8dIVl3JXeiPIHJyuNjEr+i6xy6SqAMnmL
	 9ypC+euhuc0TZ2x97nAZoFuMPF5gDQbZPm/y6QZAky6N990Gqcq+nRr92luIJ86B43
	 ZTEj1HDtQbbIFGzpcc9K3lVd9NqbNjy3uBjd5EAeTolVDRo+6bIrmo6+y3iyrOJKjV
	 ZOy9L4AWe9t7Duzx3ZyiiNWInkvWr2AEuFsbrVEH/sRliH2uQiFszGJUW6LqNlr8Ex
	 ZzQZdi0qgvNYg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 18/33] serial: 8250: extract serial8250_set_mini()
Date: Wed, 11 Jun 2025 12:03:04 +0200
Message-ID: <20250611100319.186924-19-jirislaby@kernel.org>
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
of CSIZE for UART_CAP_MINI ports.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a73f4db22feb..edfbaa6b7a1b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2670,6 +2670,22 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 }
 EXPORT_SYMBOL_GPL(serial8250_update_uartclk);
 
+static void serial8250_set_mini(struct uart_port *port, struct ktermios *termios)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (!(up->capabilities & UART_CAP_MINI))
+		return;
+
+	termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CMSPAR);
+
+	tcflag_t csize = termios->c_cflag & CSIZE;
+	if (csize == CS5 || csize == CS6) {
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS7;
+	}
+}
+
 void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
@@ -2679,14 +2695,8 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags;
 	unsigned int baud, quot, frac = 0;
 
-	if (up->capabilities & UART_CAP_MINI) {
-		termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CMSPAR);
-		if ((termios->c_cflag & CSIZE) == CS5 ||
-		    (termios->c_cflag & CSIZE) == CS6)
-			termios->c_cflag = (termios->c_cflag & ~CSIZE) | CS7;
-	}
+	serial8250_set_mini(port, termios);
 	cval = serial8250_compute_lcr(up, termios->c_cflag);
-
 	baud = serial8250_get_baud_rate(port, termios, old);
 	quot = serial8250_get_divisor(port, baud, &frac);
 
-- 
2.49.0

