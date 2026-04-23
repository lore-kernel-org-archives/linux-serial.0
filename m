Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217233290AF;
	Thu, 23 Apr 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975317; cv=none; b=EaeJCK6BgmF4s5OeazNb+5buaEXMwWSvkvwI8wT9Dbb2T1e4tz5XOMEqftVztAb6gZJcNningmbeCunv0srkRMMm2gb0kK61qMdYwLleYnFpGlmN4nB3mDQ6zL4phk6eaxJOtfsiNIh5bk8KIa1ppELquQ5GPMqWpKPBhOnaYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975317; c=relaxed/simple;
	bh=v+i0tI1dm1RPHIyDcbLA5aiGXJql1Q5oMYY1n93lGrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaEoJJOeRNJYZgVHi2wwNXMwXVJ9Y1fVwgd8RJraNe3hMZ7RsFt+BXmUs0GacoWX/i43kHawn3oaefhfUawi4o04wvzRFFn77u0jUYLnZIx91Wf3HD2336KE1w4O5FNGJZkWw7mFy6X8dDqFwkx0I7MIpEOihk33O9owyLg1US4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=zFjtsjmU; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="zFjtsjmU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=2zGs6VL8/UJ/FtDhA+BXRBv2fokUHgT8VrEFQgKv9/s=; b=zFjtsjmU52pffxZ6dCKsbKL16Z
	d92uuL0jdHeIVSDJXJn8EzGSngcQ0i4a2hBMIKLKQ71GUDZezWe1GCla2KP3vHs49ywCWt//NFZYv
	35qjaVI68CEDZgNBmeKELeRG2JwRx+yFQAP/h7cwJiPoGZkZvqfYNDEFi0BKfFYBpVX8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S4-000000002qN-1UR4;
	Thu, 23 Apr 2026 16:15:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:02 -0400
Subject: [PATCH 2/9] serial: core: use uart_iotype_*() to simplify code
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-2-baf82d3b86d1@dimonoff.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
In-Reply-To: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
to simplify and improve code readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b1cf45a8fc854cd97e349ff077d83b42e3ef8b16..fc273f8f9e75de89dca1ac1aca3589567bcf8a18 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3221,23 +3221,17 @@ bool uart_match_port(const struct uart_port *port1,
 {
 	if (port1->iotype != port2->iotype)
 		return false;
-
-	switch (port1->iotype) {
-	case UPIO_PORT:
-		return port1->iobase == port2->iobase;
-	case UPIO_HUB6:
-		return port1->iobase == port2->iobase &&
-		       port1->hub6   == port2->hub6;
-	case UPIO_MEM:
-	case UPIO_MEM16:
-	case UPIO_MEM32:
-	case UPIO_MEM32BE:
-	case UPIO_AU:
-	case UPIO_TSI:
+	else if (uart_iotype_mmio(port1->iotype))
 		return port1->mapbase == port2->mapbase;
-	default:
+	else if (uart_iotype_legacy_io(port1->iotype))
+		if (port1->iobase != port2->iobase)
+			return false;
+		else if (port1->iotype == UPIO_HUB6 && port1->hub6 != port2->hub6)
+			return false;
+		else
+			return true;
+	else
 		return false;
-	}
 }
 EXPORT_SYMBOL(uart_match_port);
 

-- 
2.47.3

