Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521807;
	b=ISzT+rF206d6LxjEIhEioK2oevdPU00DC92wX9M4dyK4AqoJUpVgPR1WSlVcc53CGWGq
	 6BZ5abGUsBvL6UEqsIz8BUidecwYy5mIK/R8vNnNLOhWwzB/UkGraSUjBoLeqhQf66G2O
	 jvWcA57QYaRQtuWGsMtH5R9T0DnOZCHYik5kIi23csAgocDYo8/rGZSgKKHWzZxjm94on
	 gLkEqqSC7BY50F/W4XoDNdUeS/ZckXoN+h0r8OtDaB1NCzMsy545o2DTFwAJmUhzV8J5e
	 P/hCK571AWSjG4pdRf/UbmmDs+ZdHQYz2TLDbBicKN0D/nPTTd/utVt0upnNaJH71uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521807;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=pjpTkpXFtMJ8XMFAsz77PGDQoy96e3X6maQLEfjyEGc=;
	b=4YJ4Al26W44sZ0QxIWmUH2Hv5eQs5AevOb5+73rh/Rb6w0VGYYaO97qtNcMhfPCXEn6D
	 VzH41bJ+LLjerErlz7+W+d2KEgRG5RFvdBXa6liEi8fUASPfRQh6Ns8oyPOSx5cdW5u5O
	 WzpqQpWRmLP5CEd8VTw/O8WAbVVXK+taOVaOxNfucOQYrQhQJm/6mI9u9qQjlbTKdlta4
	 +/u9qow/goQrfZNaPf3mp1deYI9S+7XmebYsCrr94yQnZi82VgEElXSSbekCRbyRpkK1p
	 6BSs3PIhLRlOrL3TcM3YKS2GLB27GU8MOAbLqwGGyF6cHPGo94oluLuiWak1IrI5pRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=pfCXXEos;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EB606A321;
	Tue, 20 Oct 2026 18:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=pfCXXEos
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=pjpTkpXFtMJ8XMFAsz77PGDQoy96e3X6maQLEfjyEGc=; b=pfCXXEosiJ57L8752A8WWt7Iiz
	Ft3j3oNemKc74FQTEv01TBCDIDwElWSapJaRzXaKo1D7Be3Ipy0pqHFiTEziXNPyw4liuN7htFaoR
	Zxopc+FAZn+pnvXzDNC1TFDTt368UTFy5khLsM3DbfOBf8agiPhxI3jVqCNhOiMdFy6o=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xJEo2-000000000nG-1mq9;
	Tue, 20 Oct 2026 14:43:24 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	alan@linux.intel.com
Cc: hugo@hugovil.com,
	gregkh@suse.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 3/5] serial: core: always return in-range baud rate even in case of failure
Date: Tue, 20 Oct 2026 14:41:19 -0400
Message-ID: <20261020184131.2893575-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020184131.2893575-1-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Returning a zero baud rate from uart_get_baud_rate() can trigger a division
by zero fault. To prevent this, always make sure to return non-zero baud
rate if the loop exits without a valid baud rate.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0498a8524c6da..d9ed7db53e68d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -542,8 +542,9 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* Should never happen */
-	WARN_ON(1);
-	return 0;
+	dev_warn_ratelimited(port->dev, "%s (%u): unable to find fallback baud rate\n",
+			     port->name, port->line);
+	return baud;
 }
 EXPORT_SYMBOL(uart_get_baud_rate);
 
-- 
2.47.3

