Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794765774;
	b=CoZKPrd7sFbfjBpQcZ0n90og4k56qKPwp61W2iXVzKBqNfyIgelhadvoQyQZVScYiiDe
	 XpQ49GoInAYVkKtssJIr1EbH5/Kh7gC9W2rVLC1cBe776uzJwkNaqnTfwn0wvKD17ac3k
	 YWNhscqMaW6s6BEx98e0U/RmKQ6OpLRyzvd46tK+RZOML4LsYAwiZZDQVwF0ILTLSUu0u
	 cJbzFyfDw6yq5UqFdqjTQ544R7hgnKdTnjMxvKi8BRikpVJlsQlqmzXJo05Taazg7WER8
	 cPMrnwJn1t2K9wHng8UEkH3TTRiQH4Q2QMHf8cRrVw+YaXjWdbxjLgiPStHnrZlY6BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794765774;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uBQX6/nT1hygXsWDtnsiV93/FA7MYqbCPqA3ZDhVzHQ=;
	b=IHv9C3oQuYRI8/Rp9Jr4GxkHAxsS2qoNqdE5pPjITb58i2Yq8NorvXLvPTMjKtAUrYD6
	 hWBnagWNT+8RRpX5HJqbuib06mrl0wiHHjfjd8hAhjBytpvq0ulZck22QAybPIibGigEF
	 xFeCV+aluTMPOgQvmOhfWGMP+EgjS6dPZGBOB+EViS/+AwTQ8Q03tS9eyMOudfKiOw12Q
	 cyi1U0BXsanNkYKzm1GBl8AWhyQLvHM/wF+vAJmwutpwFd6zSO59NGrC6l+Q+vlbZ44lg
	 KEGSkZT6fMFC+kpErUhwZZehh7CwvFGVtEhirijpaynHZtkOpqLwEeDBU/FhEp07e8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlCkmRX6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA67606A327;
	Sun, 15 Nov 2026 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlCkmRX6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794765774;
	b=OUYk8SHQPmWKX3fDY3AiPy03G/gKoBfTwZqEXRz9n+eaSmv8vtzQlTh1RGaC9RQq5EDh
	 fB0e0kqd9l9Y1ebNCSfNYAJ8GtYlfOy58MyDp0ntQ38A+n82rVp0yOlH+Ck895IAIy2C4
	 AbRutFz57QFWZ8JLCiDi+2mxzbANPaD60eH7XYAo2pZTN/vjeoUnfUKLGQ1IdkfndBJbd
	 b2yFh2JF6dek0auft2nCcEazM1ZSARIp0bXA5YxBIZe0n7EtFLJgljIoKJwY+IH1cHHbe
	 3NvO3fw5mik78Bmef9qLTVcE94HlgwGQCQ1KoQmUpnEBNmW7ZNf2LYoO0KFzcLgi8UA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794765774;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uBQX6/nT1hygXsWDtnsiV93/FA7MYqbCPqA3ZDhVzHQ=;
	b=s8OQhwoOYig37jHlyx+ww5G3m7aLwY+7f3qks23n/d7n/i/s/nL0QcWf1YmOt6CwHLOK
	 uy68f/nvIkT36IjB5b47yIAjx+pM5ZxGXZKrG5cuEWzELkNT5GUQxEF56lM+OZRWhDWXb
	 KtUyGnVf9/0lWhRJXOieOLqKK/el3FvVquALsRTwGDDIlTSqEstF6P1a7O5+WCtI7bfU0
	 njoZJTGtHpekp1sU6Osu3akcw5sLMXYNRyYkPrMTwDHmVfyZLFQ/2Z85/g4TxcTcI8o79
	 KojkLL1F1AKUpeUqqbEEJGD93V3d4BkJdCurGQaLGA1H7XVLwtSUSrwV/oNtXYCqVBg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 33CFC1F000C4;
	Sun, 15 Nov 2026 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794765774;
	bh=uBQX6/nT1hygXsWDtnsiV93/FA7MYqbCPqA3ZDhVzHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OlCkmRX6mdagui0pXGf5YpwB6y74Jeo8VjQewdslWj27I/7LyM2Cm01KjD1sykKuY
	 kPShK2ygDJh0HkymiIYICsFOo5c7RSBg5qlxXrwY6An9AXUmqQZ/EsNFsrMGNAzZ81
	 xK+CgBXG3TYSuNBQ+3DnBTF2QrRPnIpZJo4N8ScnLRtmZozjdv4GRhNgSWBrGR3fkl
	 zmOiHSfn/rqOwif1Ecinbxrjx4yvQ0yZ+qaTtGHawFFalU7KHNvNFDoJ2NpqEaWWp/
	 dNCGhfbGoDGeB2aKWiTT8jFX1xKBMR41Cpbbh+LMkkeqd6ftvaHgCsbUlDB2/Hp4S8
	 Y0cdRr5qC9SBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B10604A123;
	Sun, 15 Nov 2026 18:02:52 +0000 (UTC)
From: Jonas Juffinger via B4 Relay <devnull+jonas.juffinger.liebherr.com@kernel.org>
Date: Sun, 15 Nov 2026 19:01:56 +0100
Subject: [PATCH 1/2] serial: fsl_lpuart: Enable break detection in 8-bit
 driver
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261115-fsl_lpuart_8_bit_break_detection-v1-1-b7ac2307dd55@liebherr.com>
References: <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
In-Reply-To: <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 michael@walle.cc, sherry.sun@nxp.com, 
 Jonas Juffinger <jonas.juffinger@liebherr.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794765771; l=2586;
 i=jonas.juffinger@liebherr.com; s=20260615; h=from:subject:message-id;
 bh=9aJj61UEVxmT3JSRw0htuxmj1O/fWkXMFbGksUPDyKc=;
 b=HXumKe2sa9UV7ddE4tON6z9c+sWpbqhRtGjHrpF4Xht+CujaERCsMujsFVFvYdlXcWZ+u/DhS
 Hzbd0J63Xp1BC0Xr1E8r3h8cyrUHZ1/8Q7darRnFxhC9QgnV4JZKN/R
X-Developer-Key: i=jonas.juffinger@liebherr.com; a=ed25519;
 pk=57Vzs2aKTP3E7TDrBuZMQibGR+Koattc4oIhiMOs3FI=
X-Endpoint-Received: by B4 Relay for jonas.juffinger@liebherr.com/20260615
 with auth_id=821
X-Original-From: Jonas Juffinger <jonas.juffinger@liebherr.com>
Reply-To: jonas.juffinger@liebherr.com
Content-Transfer-Encoding: 7bit

From: Jonas Juffinger <jonas.juffinger@liebherr.com>

Add break detection in the code for the 8-bit LPUART.

The driver contains the code for the 8-bit and 32-bit LPUART device
but only the 32-bit part has working break detection. Add break
detection to the 8-bit LPUART driver.

Break detection in the 32-bit part was added with commit 5541a9bacfe5
("serial: fsl_lpuart: handle break and make sysrq work") and later fixed
with commit 707f816f2559 ("tty: serial: fsl_lpuart: correct the count of
break characters"). This patch is practically identical.

Signed-off-by: Jonas Juffinger <jonas.juffinger@liebherr.com>
---
 drivers/tty/serial/fsl_lpuart.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..5817c47e4db3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -885,6 +885,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
 	u8 rx, sr;
+	bool is_break;
 
 	uart_port_lock(&sport->port);
 
@@ -898,14 +899,27 @@ static void lpuart_rxint(struct lpuart_port *sport)
 		sr = readb(sport->port.membase + UARTSR1);
 		rx = readb(sport->port.membase + UARTDR);
 
+		/*
+		 * The LPUART can't distinguish between a break and a framing error,
+		 * thus we assume it is a break if the received data is zero.
+		 */
+		is_break = (sr & UARTSR1_FE) && !rx;
+
+		if (is_break && uart_handle_break(&sport->port))
+			continue;
+
 		if (uart_prepare_sysrq_char(&sport->port, rx))
 			continue;
 
 		if (sr & (UARTSR1_PE | UARTSR1_OR | UARTSR1_FE)) {
-			if (sr & UARTSR1_PE)
+			if (sr & UARTSR1_PE) {
 				sport->port.icount.parity++;
-			else if (sr & UARTSR1_FE)
-				sport->port.icount.frame++;
+			} else if (sr & UARTSR1_FE) {
+				if (is_break)
+					sport->port.icount.brk++;
+				else
+					sport->port.icount.frame++;
+			}
 
 			if (sr & UARTSR1_OR)
 				overrun++;
@@ -918,15 +932,17 @@ static void lpuart_rxint(struct lpuart_port *sport)
 
 			sr &= sport->port.read_status_mask;
 
-			if (sr & UARTSR1_PE)
+			if (sr & UARTSR1_PE) {
 				flg = TTY_PARITY;
-			else if (sr & UARTSR1_FE)
-				flg = TTY_FRAME;
+			} else if (sr & UARTSR1_FE) {
+				if (is_break)
+					flg = TTY_BREAK;
+				else
+					flg = TTY_FRAME;
+			}
 
 			if (sr & UARTSR1_OR)
 				flg = TTY_OVERRUN;
-
-			sport->port.sysrq = 0;
 		}
 
 		if (tty_insert_flip_char(port, rx, flg) == 0)

-- 
2.43.0


