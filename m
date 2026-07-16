Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6A3BFAEA;
	Thu, 16 Jul 2026 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236346; cv=none; b=FTTl5fzFDh4gQMKWJJfklnb5+3J/9Y953hRbvB8n6Ip4Ix5QnDT5l1qEg64SiaeQLhQ+8dnvkZ+Fx/YDO2bUznGzlwQiT4PVooV5gBouKB7wjbBeDYee/iG9tQYUrAXQgH4G+inL+B7YoMUAeaMA5c7Zl0pfOO5B/O7UrU+0bms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236346; c=relaxed/simple;
	bh=t8g/+DIc1QFeKOO7ybt7KVYPz1mEak8/xPLS8+6wsGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHBDs+R+gDsVt0qaXDmFfdOzS4BJANqaB5wJnXBl3r9jQgOO3LajuiaWrV1D+Io8c9rY+3FSwIup203TDZF1zINKJLCF3psJlyV2fZc5gF+GBUtHlVZtzGjFvcGCtznHCG8vnZwkBWnXJGdqoOJ1i/C7Rr/cFEus4KqB9VIZAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=p5qCuZP/; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="p5qCuZP/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=KgEo7dmWefApgSn0wERlVj3R5AginOs1bSVXdNgpfC8=; b=p5qCuZP/MQ+Tl/BSGRwlHKhgnn
	bs06Mq7dbPjDuyZi1sUqMIdvdgZEXI3Min7x2rn5GxTBHKy9tY1zQwTzihFV8ResAfn/++zUQvyBE
	6lVoe6UBR5Lfrx7UGzljZFU3RqQx2+VwHj+BcCKNsAqJaGvDi0Zk/5yVtSW9wfErmbyM=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wkTNW-000000007oU-3CAC;
	Thu, 16 Jul 2026 17:12:22 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	geert@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: core: display 32 for MEM32 and MEM32BE UPIO types
Date: Thu, 16 Jul 2026 17:12:10 -0400
Message-ID: <20260716211216.2583291-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Displaying "32be" is wrong for UPIO_MEM32. Fix and simplify by displaying
"32" for MEM32 and MEM32BE UPIO types.

Fixes: 86305190f307 ("serial: uniformize serial port I/O infos display")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 06d7f44643d61..edd1e7be2a5c7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2492,7 +2492,7 @@ static const char *uart_get_mmio_width(struct uart_port *port)
 		return "16";
 	case UPIO_MEM32:
 	case UPIO_MEM32BE:
-		return "32be";
+		return "32";
 	case UPIO_AU:
 	case UPIO_MEM:
 	default:

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.47.3

