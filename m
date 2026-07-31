Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA43A1A21;
	Fri, 31 Jul 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490782; cv=none; b=am3zJZ+J9zOJRlZThsUei5WnSl4eASzM2nzGP01xVvtwF3KzQt14ke4quBkvUxgxvDy5T0ZM9vRIPf6NXFNnGj1DPxjQFjgpkO3xjGgHc9Wvw9mJurCEOfLNlMGL2HiIAGQBRc7o50qT1nrOGt6yoJsBnXUj8yWUN1kEZZae+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490782; c=relaxed/simple;
	bh=XpKGrJ8oeXzH26hyilRihK3VPy1Ez2VuqWzcp8ptPoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgNpMvZh8z0DNG1z4RqWfR+d/S0wNkxVzjyyM5nl8x4ymskI+lZ5ffupAlpw6y6t2Atmp61CtaUDO8q89BEPe34Kvk9TypVB6UMQwCRYcPD1WvMu51d7gUUp3MBLKHbS9aPmkqrsZ9a/iGBCi/heDGzTOOLlEBmEEfPSCX4ObAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHiAxf8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHiAxf8J"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1D0941F000E9;
	Fri, 31 Jul 2026 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490780;
	bh=tatdY3mN2Ik5NNo+hhHKTNHL5NnvD1XtiBjZs0k9aEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHiAxf8JYynLQ/+nN74e62XGIgeVM7665wJGEHzURSmhWt/8n7VAzI9FRHqgopxXC
	 vc+3vLTHeaX7WalhZWPDBCIhNIYpMgk/434u3B3GOljxOa0NmqNJdFj945KQGVcLJl
	 BQ3JLch3dgme88m8tg6eNkxW7Ah1wYdzxsgI4/z7LQZ4+gt2fvlbqKmHyouaZ+EgJ2
	 ZLY/MQyc5daROh2Og++JWceITpxPeInGPb7ME8Jmy7neJ8Fq/Mf6GuZCKsurGhJeT9
	 QxS7iWXt/naAeMVZ6sjWlwGSzJIlq2zQ9A317/Wljob3CkMowEgBEdA5ne2cSciqYa
	 Ylu8kh3RtIJ5w==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 2/6] serial: txx9: Drop usage of uart_match_port()
Date: Fri, 31 Jul 2026 11:39:05 +0200
Message-ID:  <c785f3269794934d126909719e94d5ad6c35f7dc.1785489518.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785489518.git.ukleinek@kernel.org>
References: <cover.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=ukleinek@kernel.org; h=from:subject:message-id; bh=XpKGrJ8oeXzH26hyilRihK3VPy1Ez2VuqWzcp8ptPoE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqycXJdprmn8i8svMEuHmG+0jy9ymvgkyO/99wm9JcW7k 286MR3oZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiWQvZ/xfelfjvzy0/Wf1U lMFMjVkPnGc8njc37F3Hvt7iaf0BTZkrjeoPClxRO2ntkM5Zk65e5/fobbq5Jdcm/4Zdi6X9A11 tXxus9WDqy1J8PXO2esgrhsbOSeXsmhKcIllab9LWs0kasZdee2DCGByS1pmbX9sSVajDyzLr0c J5YlcTvym+LRRyKnUozDD90eb18UCM6EXx4/V37Tcv3H1sW1OkgOTf5hX3zv37f3iWyudnbc9Zo 7uTvEU8M63mZi79fK6mNfd8xbNyTcb3Se8Uy2sPlK1XjtHQmGS63lrY2nPSGfeaX8zxlbsWMdwT e8Lz/ZWlj4QkU1dyor3m2+v1Hl3ZZb+aW+aUfJX2eQsA
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

In this driver .iotype is always UPIO_PORT. So uart_match_port() is
equivalent to comparing .iobase. Remove the call to uart_match_port()
which then only has a single caller that is handled in the next commit.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/tty/serial/serial_txx9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 5ed20129b44b..2368081c3742 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -965,7 +965,7 @@ static int serial_txx9_register_port(struct uart_port *port)
 	mutex_lock(&serial_txx9_mutex);
 	for (i = 0; i < UART_NR; i++) {
 		uart = &serial_txx9_ports[i];
-		if (uart_match_port(uart, port)) {
+		if (uart->iobase == port->iobase)
 			uart_remove_one_port(&serial_txx9_reg, uart);
 			break;
 		}
-- 
2.55.0.11.g153666a7d9bb

