Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB21A0AFA;
	Tue, 10 Dec 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837694; cv=none; b=FytyGgYe5bVvJ4XwPGjHdhMjCDF2mLkO4ZznPd+xY5q7q0mrif0BqIRrD0DCDOhROmxVf4S9p/5QloubvuF7+s9oCQCWSbQlc8MDP0BzH94oX4nV1S7iAYS00ahAGnIugqEErAwrkcnqG07RgdnOZHzXy3Fq+Ojko0I+h4OL8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837694; c=relaxed/simple;
	bh=j7Fkm8miyQPUo4Agej6+DrddHMm2KEKk/d9sikhmlAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwBYAuan3zl753ami2Oyh+ACJ3cXsUOP44/jrTrsfEJujGjRIPRO5UZOAULNNJQaj0YT+3WhkbsSTywxxxQNKI1MNwDiFjnhuqwmyEOoh60RoX/XyMv6gryG6tf3/p+KzNoH4D0YCFIC0AescDhFqfZDtuaeedNQs9BpmwEec2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvNj0jZe; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvNj0jZe"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6d6fe8b16so168749485a.1;
        Tue, 10 Dec 2024 05:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733837692; x=1734442492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uDre2BrjFxoUxEXQwHK6Feq1hadBUS1xU/z2vBEIrg=;
        b=KvNj0jZe3gToEHpEd3UVr72o5IC8jvzq7/2wPWeviOA1mszIE0cdMFYMvVVPEsoqC5
         Lj0DS24QRldNK9zouSu+pnDqKzKgf8EFpeYeqz8g7yBnR2+zgY4NrG/AE93C16WIuFNp
         ahJ/1DxVu3mVwqGTulMatgCZcGf/V8on+G1YRlcy/34gQJsb4BD9QBQ547rzbykP+x89
         0mp1uehc7WyvzwM2HtFuQWSw2uD/U6Am3Ep7uViMVCm/K6w7FGyjwhPy55DM20wmpKBC
         mzGlLCx/H1pUENvAx7JaUs+0mOQ3564oWkSZevI3ikdvnbBanPB4tdOy9qV/87NhwjBl
         ztkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837692; x=1734442492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uDre2BrjFxoUxEXQwHK6Feq1hadBUS1xU/z2vBEIrg=;
        b=kSAOx/mipvlqXJcSkhT6aCB6+Q/GahYWd/eeJu/WIipW6yxz0/x+fjvfI8ZBCzGuFD
         2RQtJj6Cz9EGsbk9AZl5+XQxz9CI/tIlzNeq3xFRsXYPV7T5M7RTPfiwFEF0e7t9Pgdx
         pelOEo8rIR0OLMUUdi9faLrrA192zhDAi7AMnuKHfkuKE0l4m1jshLPfQ6Pw3XgEyJhH
         tPjTLOBOg0FOX207WUa3COcPLPAg7IFk+ORYG7mWSgvBQ+MSpPTjJbd7DiP020EC2HRk
         TwQcEiH7Vb3btQqN7XsBLzRTI0+CnLShPgHnC44IDXstOZ0N9/nJVXMTMhLykjf4TZ9M
         QIHA==
X-Forwarded-Encrypted: i=1; AJvYcCXnASLg7EAp8Uzo7ELHEvIq5B8b4uuiDMbUUqfzr1GcvqfHVfNSUdGODLDQaPRdPAboZE/b1NhbbnExItkt5IQ=@vger.kernel.org, AJvYcCXx91rE9CS9nhfm67vwf8oel5804fJE1Zd2TazGlDi5BfEW6U+cITnmr/Fq3l/zHCXDlkAE10C5HqHqit8O@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4ty5OhChy+y/1W/VlXcx+smDMt3GT7ujb4B8fmUsUcfdMtCm
	l6nm4UmRuZe0fnhCRucyz/+NNDJcCk3bDhssD9sAgObedBu8Ke9j
X-Gm-Gg: ASbGnct+iF+xTmrkVHQlZvuwp3l1WYyBoNF18gV00TWi0jlfl7wyQIocqSLXACkFLTU
	nZ0WWi9eyCPcRkk2Ur/HjfBV/z/fL1Mub3mIKpAUaSu7E9RWo40tIsxJupLxdzdv4bBW/L+1mr6
	CWvloEPRkfbTJdqaEaot8NlPO5OuHb4Nq0+JxE3jlL9rxtJZ5Yysglo/YwdpZdnXLV5mghCwPQV
	itXRqZkU8+Zuek3SbYB3nNtzz8O1BAZwzJFICAy8y+fpRo=
X-Google-Smtp-Source: AGHT+IFhEt3JFKJeFHXMMTm5hZ+k51UoMVNS8Vmaq6IsF5DsUiU5odOY4K1Yt2onZJG8ZB9YcXEnYg==
X-Received: by 2002:a05:6214:e87:b0:6d8:a1fe:7298 with SMTP id 6a1803df08f44-6d91e433d68mr68947826d6.41.1733837691981;
        Tue, 10 Dec 2024 05:34:51 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:74::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d9162133aasm18175056d6.129.2024.12.10.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:34:51 -0800 (PST)
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
Subject: [PATCH 2/3] serial: Move LF -> CRLF replacement from serial console to kdb
Date: Tue, 10 Dec 2024 05:34:47 -0800
Message-ID: <20241210133448.3684593-3-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210133448.3684593-1-tjarlama@gmail.com>
References: <gmail>
 <20241210133448.3684593-1-tjarlama@gmail.com>
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

Signed-off-by: Amal Raj T <amalrajt@meta.com>
---
 drivers/tty/serial/serial_core.c | 4 ----
 kernel/debug/kdb/kdb_io.c        | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 74fa02b23772..ed18492b7f8f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2142,8 +2142,6 @@ void uart_console_write(struct uart_port *port, const char *s,
 	unsigned int i;
 
 	for (i = 0; i < count; i++, s++) {
-		if (*s == '\n')
-			putchar(port, '\r');
 		putchar(port, *s);
 	}
 }
@@ -2738,8 +2736,6 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
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

