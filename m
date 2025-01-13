Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F801B2186;
	Mon, 13 Jan 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789382; cv=none; b=HJRwiROsKWnnhrnx01CLlrp2qHGvit8pfLu/KVTn7voI66ILDARC0zaG+GywNemg80XqL6LPFbQ9Pf8GrGJKrmIP4CUBYx94iBr0X9Z5M5JBlmhTUGQTxfE4PAD/oejkytCWbYIBcVRJPpb2UpETgs+CDdWe8abDMb8Qv2ZYfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789382; c=relaxed/simple;
	bh=AbNznFJw7tNO7GELSX8D+PxeywVxUKNnoVkCmp1DXmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6wjRSdZg+SS23qEQRk3L7w53ov2lTwXkuvWns65U+SE786NTOJkLDXJlQkRpMFSULDxEC/HZpnzGJfMNr239kQvABUAli4wwtqhcdszUX1YhcNwICLFDSlxuuAzlBcvLZ9x+jm/Hy/+UbwQ6Qdypo0UP0/hw/Oo9pi/6Ju8Hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bukdIbmG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bukdIbmG"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b98a2e3b3eso249129585a.2;
        Mon, 13 Jan 2025 09:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736789380; x=1737394180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5Z+bg8OafqMVuPmIXTprIIiZqk6gb1AHOX/DFWzuNU=;
        b=bukdIbmG+BgIBAw7voyLLPOf264PVHYzkAZQZ16u2MlVgnxHktExhQ3lfBf+ulpjsV
         7tseHbE+SThZSjeMDKlgQzPc5+XRb5r/qdKlCQVcAghRDgfaz+6nl/qz59F6IzHToah5
         raPunGIsAPJrmw/B2S5XOIVSgw32iBFylsNf+8ehbcrlo0E5cyoPYMTRJK/bVy32TiTB
         3U7jPshsT6IpshmKk1dFt0XJzQZHVrDRzqFwhkvEv4QlQMw2BB4293G/JphjG5Q81XwF
         5MbSD6gN4dqK8MEGPxRw3/Gnv138TvLRVKrV+iNZC/vJDUArJTlT9hN+EK06aZ/x9paA
         E4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789380; x=1737394180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5Z+bg8OafqMVuPmIXTprIIiZqk6gb1AHOX/DFWzuNU=;
        b=JvvlCKJPUEMMZ87zyDt3M+PeUeN/2pgXay1KCaYuwy4oXCebnsRiAr204pX/vs4k2n
         2hXUwaUzl23Yytn1tCp4d8BAuwHqxnkZKDnmSpF00g7ab0+JI9Y4jBkoXF2rkeLmpzcZ
         KVgi+JzIgVhTirNwu+aa/jIk7eN3H9ueA1PcouMmwdCaFJmHB8KXXsxOASKJDNXk/SsF
         IGiTQcc1ZJnWHFeoA200xloNZrHUUuA9UM/a9VoMHx9G2GoZTCKs9tPMP3IBQ2Aj14F/
         RirM3PxOnuJvSpaQnEbj8/1Am8Cw0YnU0QBAbSl6BkJ3vz/Y7pvDTxZjZf2wsCUm06oG
         LlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK8+nNRsxdt71lFe6ZnxPqMQ/j/1uqzgXQeuYL8MX0JDbGJ39DV8UzMg5Z99QSEDFZG9pHLT1PSPjHI5NG@vger.kernel.org, AJvYcCWp8ECSMB1aeiihmXoW4VtxrqDzi1ZnSv1q74TSQKSoPq5VaCwwXebhi2KGJIWpkhKgNRH4uZy+cfviWWHh6U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnN7YsG4GC9OYiQove8mW2iZEOFBVhRkb4+s+xzkE8X2a9C0bb
	csiENNY+Z8sL1xkRpKu1lxsEJrtMJjmaqO1Y1XpWj0YNpw8XgbeH
X-Gm-Gg: ASbGnctOoYjKBFTfOWi+RXjzo7M8XGZDxUz2lvg/BBDKLhE5YKRNO2q5/KgvKr9E7H+
	giDgeK/xqrKX53A44nOBEOvv+nCTxOyi7FxLLAHJNXYebVjGeqyJMyE43ftzv3QhmRBvE0mW6a4
	/dVfL0i2k5jIFH4M12eVymFVC9qkhxou5rTkd0UrsN19l8ARHzPjoWH5VfRQPg7b6Bt8xijfdYQ
	BeHzE53GZZbuKvJeG8pJn8t8qdUvN5ab6J7sS+onDcuWZCa0w==
X-Google-Smtp-Source: AGHT+IHgORHKn8UYd+xXXrbpkWKXILxktlXQWr2TceQQeJ3AQScLGGLts3HcaqiY0MwDjC2UgnYIFA==
X-Received: by 2002:a05:620a:458f:b0:7b1:4327:7b63 with SMTP id af79cd13be357-7bcd97185d4mr3623748085a.32.1736789380204;
        Mon, 13 Jan 2025 09:29:40 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:71::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce327b8besm510436185a.59.2025.01.13.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:29:39 -0800 (PST)
From: Amal Raj T <tjarlama@gmail.com>
To: danielt@kernel.org,
	dianders@chromium.org,
	jason.wessel@windriver.com,
	stephen.s.brennan@oracle.com
Cc: tjarlama@gmail.com,
	amalrajt@meta.com,
	osandov@osandov.com,
	linux-debuggers@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH v3 2/3] serial: Move LF -> CRLF replacement from serial console to kdb
Date: Mon, 13 Jan 2025 09:29:35 -0800
Message-ID: <20250113172936.1434532-4-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250113172936.1434532-1-tjarlama@gmail.com>
References: <gmail>
 <20250113172936.1434532-1-tjarlama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amal Raj T <amalrajt@meta.com>

The current implementation of `poll_put_char` in the serial console driver
performs LF -> CRLF replacement, which can corrupt binary data. Since kdb
is the only user of `poll_put_char`, this patch moves the LF -> CRLF
replacement logic to kdb.

Link: https://lore.kernel.org/linux-debuggers/Zy093jVKPs9gSVx2@telecaster/
---
 drivers/tty/serial/serial_core.c | 2 --
 kernel/debug/kdb/kdb_io.c        | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 74fa02b23772..8e702f3deffb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2738,8 +2738,6 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
 	if (!port)
 		return;
 
-	if (ch == '\n')
-		port->ops->poll_put_char(port, '\r');
 	port->ops->poll_put_char(port, ch);
 	uart_port_deref(port);
 }
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6a77f1c779c4..43a7c8ad741a 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -572,6 +572,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	len = msg_len;
 
 	while (len--) {
+		if (*cp == '\n')
+			dbg_io_ops->write_char('\r');
 		dbg_io_ops->write_char(*cp);
 		cp++;
 	}
-- 
2.43.5

