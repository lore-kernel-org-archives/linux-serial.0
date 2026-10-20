Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521808;
	b=kbX7SV9VxatTLBEZqG6ZSc9URO9biwP8flbRaakgorIDSUP929YqshvsNwpMSJPOrbG8
	 XJgyHsnMsbVlDvN3VGTCfwHydjDgpKVCpx38lSb5FzfAVqoFaBAiwENNoPMVDxl1z3r9K
	 DvGfRO5frQ5SFrZiIL58oFPOMCkvbxxWFgaJKrkPGlYKIvaXA7x7SnE87cOTZFJe7xmZs
	 tXSOblh+dY+QPMDZzZLTicZishMiHlF2QgP0l1cZUh281rHMWpOLc1uEToyz5yA24dWpd
	 zvzvCut3QlJppsEPEl94htKi/W24NRgP4qCScVQQ+CARrB5UyRxWA/dQL0TAltVY8Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521808;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=Gxgg5VeXayw266nUh/HtSJVl1YD2GuN5qO40kUlAA8g=;
	b=u/pfL5d4hdstmgHWsS3Xs6Urc2lpF/GSbJaUfe9CPvypUVjj38jCpvzYToaObjueKBHU
	 qS9AEssDDL8RaDciQ/UJulMmY/G06wKNSoxpeehWpm9wgstqGiZJzHyyUyP58+zT7rNsO
	 Qr3kJtzGuXkntxirm/LCU+Qgm493srqZclQKxNkKuInwM+1Cskg2BZraKHw4K/XtKOkwo
	 JRjMnqFX4Sh7i8+PfoXiDVrHl57chwvzYPun/nbacq4XjfoGZac1vclA+umPNf6GhgQEH
	 WwezcHu875lLxWRcbuUHgxKG6P1CkIyCVXQDqAP3ywK5s+nICgUmitQJC2vHcRDyF/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=C6uETg4Z;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7208606A326;
	Tue, 20 Oct 2026 18:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7208606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=C6uETg4Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=Gxgg5VeXayw266nUh/HtSJVl1YD2GuN5qO40kUlAA8g=; b=C6uETg4ZADEBhX6oqpg7CxZ0UC
	x2vsvs2kHmUwuKlPiO+tHuYsfOBVbo+JJTVj4hNd6Ej5BxgQOE57rQ7KXWF2CbcSMxKQf+SJPZTqr
	Y9xihqm/lOYkuCcA68SmevGI2UlWFQxR8i9YUpE2uuzMsu05+gNIT6klGYslRFEyCFkQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xJEo3-000000000nG-2QO7;
	Tue, 20 Oct 2026 14:43:25 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	alan@linux.intel.com
Cc: hugo@hugovil.com,
	gregkh@suse.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 4/5] serial: core: avoid redundant baud assignment without any UPF_SPD_* flags
Date: Tue, 20 Oct 2026 14:41:20 -0400
Message-ID: <20261020184131.2893575-5-hugo@hugovil.com>
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

If no UPF_SPD_* flags are set, the spd_* flags kludge is not necessary, so
avoid redundant and confusing "baud = altbaud" assignment.

No functional change intended.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d9ed7db53e68d..08a6afa75af07 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -494,7 +494,7 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		altbaud = 460800;
 		break;
 	default:
-		altbaud = 38400;
+		altbaud = 0;
 		break;
 	}
 
@@ -505,7 +505,7 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		 * The spd_hi, spd_vhi, spd_shi, spd_warp kludge...
 		 * Die! Die! Die!
 		 */
-		if (try == 0 && baud == 38400)
+		if (altbaud && baud == 38400)
 			baud = altbaud;
 
 		/*
@@ -517,6 +517,8 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		if (baud >= min && baud <= max)
 			return baud;
 
+		altbaud = 0; /* No more spd_* kludge for next iterations. */
+
 		/*
 		 * If the range cannot be met then try again with
 		 * the old baud rate if possible.
-- 
2.47.3

