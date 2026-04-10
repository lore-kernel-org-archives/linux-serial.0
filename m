Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBCD3E8C5B;
	Fri, 10 Apr 2026 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834449; cv=none; b=SgZwYRVn17xqiX4rsnW0Sjcfl3dUVZv31uaku6ZGcOXTwk1fzxWbCsw2aPPq7be3fUnWb+2f2dzI32NgxIfv4gbgYVwin91HKTVaE4Oo5fwQfTtv5oo4iqq6t/MoSq0WcQ+MPycxrJQcZ/ceTLq2zKVy5cDkMOidZBLvddD5lM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834449; c=relaxed/simple;
	bh=EmqzxCeH3+2cTIzPaxzH6HVZPgBKe3xmaPvy+SMJkNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArpQzKvYnn0JtrAWiHIAEN8s0OtmOmOLXbw899LX/hZrgQ3M/nA3Ues5FbA56qyVfzF9Z4g5ItjxjkrisWFQg9lMIRvUdE688YHYMKxdrgib6iOaliboN80Yse6pKyhOHupancPNXmuVWELarZ08sMSa/w+3r063eo80L8WCP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Sw2OLsWf; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Sw2OLsWf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=nE+1kczXySniW6DFK8K0g6Io+rAOnMYlKgGQ6sCTGC4=; b=Sw2OLsWfvJiHGg7tTCgi9R6llI
	+eBCGOM8Wm8vf+vwt4Y1umjSEMu3WnlQBNMeLTYcIOeYSJfYayoUOiSIhUtH7gzPI6wUi1zzriT5H
	RozMaiC1UgG0JUi3nx5NIySBKozGU5+gjji7hxq6ZVAMpSn7fLeqngDsXMu3b+X4nyvQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wBDez-000000008Ub-3UQp;
	Fri, 10 Apr 2026 11:20:42 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: hugo@hugovil.com,
	biju.das.jz@bp.renesas.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 4/5] serial: core: simplify clipping logic in uart_get_baud_rate()
Date: Fri, 10 Apr 2026 11:20:12 -0400
Message-ID: <20260410152022.2146488-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410152022.2146488-1-hugo@hugovil.com>
References: <20260410152022.2146488-1-hugo@hugovil.com>
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

Simplify the clipping logic in uart_get_baud_rate() to improve code
readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e6a8ab40442d9..f89c0dc295163 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -543,11 +543,11 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		 */
 		if (!hung_up) {
 			if (baud <= min)
-				tty_termios_encode_baud_rate(termios,
-							min + 1, min + 1);
+				baud = min + 1;
 			else
-				tty_termios_encode_baud_rate(termios,
-							max - 1, max - 1);
+				baud = max - 1;
+
+			tty_termios_encode_baud_rate(termios, baud, baud);
 		}
 	}
 	return 0;
-- 
2.47.3

