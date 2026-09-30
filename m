Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D4415F29
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754541; cv=none; b=SBIWtJPu5EIGuxSZkEneCH63upRHmHUq0ZO5uQfatWDz+COjph9q81QucNUz74DAmpjjYuNKLatBlel+6kTya5hfJcI7IQEDDeXAeGhez1N6zUB6pLFMWZzeGQ/m/TsxP3S42bxWO3rjnIbaIvoet1YTxR1r/QQ2Fjlkv03PoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754541; c=relaxed/simple;
	bh=S35Yt6MMIDiu89GiENd7YXKG1VdniUNgPzYQiYvvfDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntbLXYzvpdj7BzvmM9NqKBK+tku36QvXku32oet0N7+4gIc1hFNhw0mSPV4VRvWV4DvsYQw0m+Xx9MALLly1Unk84GuiO/ZW1JHK3A/U0JUfQE5zyr5s2Yc4I7eozYbyUD695PGR40BvEBV4qrqbYqPz12qDU6YRU1ygprIrdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6HY5R04; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6HY5R04"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87c90648f99so3656156b3a.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 00:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754535; x=1791359335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=72PWod9CYTLQICpDGdnCAhLW0qkolhlRAfQR41QlFTA=;
        b=q6HY5R04MQMqwUs3d53UWsLpfkbVH3nUxUyQLcA9xlUEAAxJS7vtdUX2ntwQ/PN8XA
         6BG9dzrf3ahoi6CmlQxfPzaLgoPYwciH2j4D8CgM4HkSACP49vpJeir1PMYoA2rohTUV
         ygHZo1P6Y7VWuRmC0tCC2y8hDIzFYKbVI7CFuv8apVld+2sr/ZgYTWt7qeyr3xApUP5I
         nH/b4cIFFuGzfWbhRuDx3v+uLVNhKe0WSd/BWb41L2Rf4jkeaiu9uS3WRZUal4OUKsIT
         pEdhyGXBx1lWo0NyCPE5sHS/oAx0qiLSf5yeFHoLR0j5lAou5+tY5i3pJdFyIdUBfAQk
         9DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754535; x=1791359335;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72PWod9CYTLQICpDGdnCAhLW0qkolhlRAfQR41QlFTA=;
        b=2JygwyzYpxltFqUaWAfsZKp4DjIhOGxfaUHCyDiGK8B7/WwgKI4CdjO5da4tCSCdbX
         O1/UcnxZb4sfOj+ON6hJtpPR3jjn790QAiDfAZD4F4diq5TpVIJOeQIHIfYIoKQ8TEJM
         pKiAruHsKnrgYNrCLAjjxXMhzJjCWF2ZHDh4iTmhmESMXwGRECd87NLBfNdG+eOL8PQq
         InRX7d2m+1qKy+M0Ymd57lrboIodDsob/t51R64y1E5ceciA9IKjYej8MX6AQ+pHgYVZ
         xObulSB76C8n7EpssoJcKzqcTw5rNxi4QBg6b3hvWTmrXnzRPGslX/D0G75BkWTHk2sm
         XCEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWcVgo29f4rJ55c6qxBRkCYl70ggmD5qZDBMitLSuPuYWvS9NGbTWQdHCLZfL/91VP9Y8mVmVg469bHQs=@vger.kernel.org
X-Gm-Message-State: AFuF++kvMsU+n4iyemuFbGJqxahh3gsssK1BUBtXH5w/hrYpx+FzsEuo
	Y0jDl8mXXMS178P/23iAi3QhWckaVpdfKKlSGpViB6mxSPsFCeVxkAsE
X-Gm-Gg: AYBFou3UmhLTFrQGjcDK7bnx4PZidnfFZTjTUpzG5XKAkagmdn6yHU//5muA8++Fm80
	rPtrzAvBAzB8wqyABVLaEl9P1Id21wzr8cgVt9yfEqrv0HQUmxhtsCjH2D/MaHU57ZE07ubp0mX
	bIxgCVKrR/+oHWp2nhMpgeSLGb6K5dF8SVZQ9sTsNlRq7zBZ+zAeFQvlu4wp1zsFCmZ7L8zDw2R
	qo2mRpDnldLBHfnR5jhAX1Y+J5xUynvxLUupNQaUc39+R/AJwz1ZCj8ShwU5oZGLdIXcSkxAtPz
	KAH7+AA25bTCF6QRnSobnzzb3VlN28D16NKUejBswLBYqE4l34LzWu5YAuV6rUCQrlpkdFqDguA
	p9TsakDCrVn3gnMa9+3r1RlKI86vy20eAJj0E/ELZ+0eNUI26XiRvEvAN1/nxrfUfDlSz2usoAU
	bwUiOsh8omlpgpTHdmFsRAzAywoQB74zY9f8SeEf4KGKaNvhAqfkz8r/gJN91lctx568rz96Hsp
	uGGQR2zqtdejiiCPbVXfjYuLiRZP3oRqc13X+nlUikTM7jLth17/MzYWH7qnvUqbITK+D0bqSnE
	MydIVuvI8Q==
X-Received: by 2002:a05:6a20:d10f:b0:3de:540a:a270 with SMTP id adf61e73a8af0-3de9e7f2d5dmr664907637.41.1790754534806;
        Wed, 30 Sep 2026 00:48:54 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725881fa6sm376732b3a.27.2026.09.30.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:48:54 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v6 2/3] serial: core: fix baud rate fallback in uart_get_baud_rate()
Date: Wed, 30 Sep 2026 07:48:49 +0000
Message-ID: <20260930074850.465003-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930074850.465003-1-benquike@gmail.com>
References: <20260930074850.465003-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In uart_get_baud_rate(), when a custom divisor is requested, if
port->uartclk is zero, the fallback logic evaluates baud = port->uartclk / 16
which results in baud = 0, causing a divide-by-zero error in subsequent
calculations.

Ensure uart_get_baud_rate() falls back to a valid default baud rate when
port->uartclk is zero.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/tty/serial/serial_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..55bb1eaa27e7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -480,6 +480,11 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		return 0;

 	max = port->uartclk / 16;
+	if (!max)
+		max = 115200;
+
 	if (termios) {
 		baud = tty_termios_baud_rate(termios);
