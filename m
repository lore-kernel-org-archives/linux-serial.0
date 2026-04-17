Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DA3C1980;
	Fri, 17 Apr 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437637; cv=none; b=I2xnmJ5yEO9HBWR7jQU6vjr5BFpMa+dLq5WFv7ChKnqS7naPtbEz6dHrmcCQP0S9Z9zORnGXGYrxad/NQBobPhPBU1+VWExwQwz2BnpKYsUJEurA35GUASc6DjNs2cJARLSXcG7At7nxdYGFoFaJiDjHHBtQrCdd94ktWCeOeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437637; c=relaxed/simple;
	bh=AheMHbjZxMZt3qjVkcx+GhSx9S6San+RLOlqhYvndYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grpf/C07hw8k7Co/ebAJvBEfp+7XmwaJv5g74R65//2uYDktdjgMqFmGOFjjsSapyS4pwlAoE58fTz61nvFGaUsI5w8lTBCwUo4gYC4sfvVo+nINYCWmfeDZfAAQp6N6Lph+SIsBzik/9c1yJ3wjgOz96usIjV4ynFY1q9Ahbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=kmvERybo; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="kmvERybo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=cduXsqdP4aet+jHHPTocIt514wp7jfm/O8IjyOrGA3E=; b=kmvERybo5E3A/8ysZDATm49reu
	W69QY0imU16IcOuWJFMhtk/mBYxIegoTVEJc110CSUH7NB2UiM/W25E7TqhtYq26Fx4SWcVHq/d3M
	uUPK6XfIMJebyJxpo/nLbmZwgVCz1EfIitxW0rI4B1hKpXrfKyRd1r9ABX47kzIhgyEk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZo-000000006G1-21ZE;
	Fri, 17 Apr 2026 10:53:49 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:36 -0400
Subject: [PATCH 09/10] serial: max310x: move variables to while() scope
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-9-b424e105ecac@dimonoff.com>
References: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
In-Reply-To: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

txlen, to_send and tail variables are only used within the while() loop.

Move them to that scope to keep them closer to their usage and improve
readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index b4449b68cfeee07d1d6d3206cf58f72fac00044e..748306d1a9329694e90ec4f096dd00e39d457fda 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -761,8 +761,6 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 static void max310x_handle_tx(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
-	unsigned int txlen, to_send;
-	unsigned char *tail;
 
 	if (unlikely(port->x_char)) {
 		max310x_port_write(port, MAX310X_THR_REG, port->x_char);
@@ -779,6 +777,9 @@ static void max310x_handle_tx(struct uart_port *port)
 	 * We could do that in one SPI transaction, but meh.
 	 */
 	while (!kfifo_is_empty(&tport->xmit_fifo)) {
+		unsigned int txlen, to_send;
+		unsigned char *tail;
+
 		/* Limit to space available in TX FIFO */
 		txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
 		txlen = port->fifosize - txlen;

-- 
2.47.3

