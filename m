Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521809;
	b=fuvus8TqZPAHJiRDuaLcmtabIe4dLPVKJ4H0GUt1a/AnfL631heurKhL4T/LBtcWEYTE
	 6hwGQQ1ZqZxe2bUih5oIZoYuPzaCthun4dKERJFOuRI+3O4+GX7TY3+eNSKxM12s30qhL
	 QSW2T3f+z/l2Swb6nkIZLDNVDKg+BXGVXnp//y4P7aO/e9xx8fBrY2G41DgryLlijsPlq
	 pLIjj4fZPHDYbDM/E/L6nRzdTg/2hR2sDtXmRhJ5gFa0wEQGcg8ryrYVxpR2jtPdCLy8W
	 mqJdfBKmngp3FYAkFgCScFbQEXKUmw+FHiHZm5C8alGY1QxGL+Fxckj7XCofoBsGblw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521809;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=pth2lYC3EFeD/3mUTbdjJYlroHvxBI6KfSbbHR5qsiM=;
	b=tUCHN3i6VzsPlzxCsxzd9zuVQt5RvVHMNaTuoJGJPnxAfXcHULot24O2y/R2wHMrhZiX
	 f82Hgr3UaDl2fri3l4nv0aii2G7CM9RRZGfZfDCoxfcihovLfqa37rQExYCeu9JgXt/iK
	 fs/WUk0KChy1J/dy3sg9YtrJWmZc/1+EcUjUo/ofoZRgQ0XuCGRQYQQq5FoeO7369CMnP
	 1JpvT5wBjzoeC1EYXvPRMOIbwqm1fiKhXvb4s1/sRstUTQf+grpHKRTG1uwr/2P/xHqk/
	 6xoNXXEcTFKmDWOtizZieN0w8mx+SuYEvp+Ja4QTdsziyAH3ABahJB4lImtsJPVy3iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=l74nwNIR;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFF606A33E;
	Tue, 20 Oct 2026 18:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEFF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=l74nwNIR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=pth2lYC3EFeD/3mUTbdjJYlroHvxBI6KfSbbHR5qsiM=; b=l74nwNIRvFD2MoCPR3ApFA2FlN
	6JTlW2TP8biaU4scXyWm7f4XWXm1TC3+pxTW79ylLpk3sLm78NPxdkhpNYHHKtudM6OW4H/3rW8TG
	deEHllkbRwnBO361eysZbjm20G+2S4n4uVb+E4cYkR1xmQO5LqMN3jUlWxfFH/glsoIA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xJEo4-000000000nG-30A5;
	Tue, 20 Oct 2026 14:43:27 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	alan@linux.intel.com
Cc: hugo@hugovil.com,
	gregkh@suse.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 5/5] serial: core: refactor uart_get_baud_rate() for readability
Date: Tue, 20 Oct 2026 14:41:21 -0400
Message-ID: <20261020184131.2893575-6-hugo@hugovil.com>
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

The current loop makes it hard to properly understand the code flow,
so replace it with more linear code using a validation function to
improve readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 103 ++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 08a6afa75af07..7457c6b44f325 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -453,6 +453,40 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
 }
 EXPORT_SYMBOL(uart_update_timeout);
 
+static int
+uart_validate_baud_rate(const struct ktermios *termios, unsigned int altbaud,
+			unsigned int *ret_baud, unsigned int min, unsigned int max)
+{
+	unsigned int baud;
+	int rc;
+
+	baud = tty_termios_baud_rate(termios);
+
+	/*
+	 * The spd_hi, spd_vhi, spd_shi, spd_warp kludge...
+	 * Die! Die! Die!
+	 */
+	if (altbaud && baud == 38400)
+		baud = altbaud;
+
+	if (baud == 0) {
+		/* Special case: B0 rate. */
+		baud = max(min, 9600);
+		rc = 1;
+	} else if (baud < min) {
+		baud = min; /* Clip to lowest chip supported rate. */
+		rc = -EINVAL;
+	} else if (baud > max) {
+		baud = max; /* Clip to highest chip supported rate. */
+		rc = -EINVAL;
+	} else {
+		rc = 0; /* Valid. */
+	}
+
+	*ret_baud = baud;
+	return rc;
+}
+
 /**
  * uart_get_baud_rate - return baud rate for a particular port
  * @port: uart_port structure describing the port in question.
@@ -475,7 +509,7 @@ unsigned int
 uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		   const struct ktermios *old, unsigned int min, unsigned int max)
 {
-	unsigned int try;
+	int rc;
 	unsigned int baud;
 	unsigned int altbaud;
 	upf_t flags = port->flags & UPF_SPD_MASK;
@@ -498,54 +532,37 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		break;
 	}
 
-	for (try = 0; try < 3; try++) {
-		baud = tty_termios_baud_rate(termios);
+	rc = uart_validate_baud_rate(termios, altbaud, &baud, min, max);
+	if (rc >= 0)
+		return baud;
 
-		/*
-		 * The spd_hi, spd_vhi, spd_shi, spd_warp kludge...
-		 * Die! Die! Die!
-		 */
-		if (altbaud && baud == 38400)
-			baud = altbaud;
+	/*
+	 * Invalid baud rate detected. First clear c_cflag because
+	 * tty_termios_encode_baud_rate() tests existing c_cflag before encoding new value.
+	 */
+	termios->c_cflag &= ~CBAUD;
 
-		/*
-		 * Special case: B0 rate.
-		 */
-		if (baud == 0)
-			return max(min, 9600);
+	altbaud = 0; /* No more spd_* kludge. */
 
-		if (baud >= min && baud <= max)
-			return baud;
-
-		altbaud = 0; /* No more spd_* kludge for next iterations. */
-
-		/*
-		 * If the range cannot be met then try again with
-		 * the old baud rate if possible.
-		 */
-		termios->c_cflag &= ~CBAUD;
-		if (old) {
-			baud = tty_termios_baud_rate(old);
-			tty_termios_encode_baud_rate(termios, baud, baud);
-			old = NULL;
-			continue;
+	/*
+	 * If old termios is present, retry with the old baud rate. Otherwise,
+	 * baud holds clipped value, and this will be used.
+	 */
+	if (old) {
+		rc = uart_validate_baud_rate(old, altbaud, &baud, min, max);
+		if (rc == 1) {
+			/* Special case: old was B0 (hang-up). */
+			tty_termios_encode_baud_rate(termios, 0, 0); /* Encode B0 in termios. */
+			return baud; /* Return B0-mapped baud rate, not B0. */
 		}
-
-		/*
-		 * As a last resort, if the range cannot be met then clip to
-		 * the nearest chip supported rate.
-		 */
-		if (baud < min)
-			baud = min;
-		else
-			baud = max;
-
-		tty_termios_encode_baud_rate(termios, baud, baud);
 	}
 
-	/* Should never happen */
-	dev_warn_ratelimited(port->dev, "%s (%u): unable to find fallback baud rate\n",
-			     port->name, port->line);
+	tty_termios_encode_baud_rate(termios, baud, baud);
+	rc = uart_validate_baud_rate(termios, altbaud, &baud, min, max);
+	if (rc != 0)
+		dev_warn_ratelimited(port->dev, "%s (%u): unable to find fallback baud rate\n",
+				     port->name, port->line);
+
 	return baud;
 }
 EXPORT_SYMBOL(uart_get_baud_rate);
-- 
2.47.3

