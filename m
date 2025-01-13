Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FB192D8B;
	Mon, 13 Jan 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789381; cv=none; b=tE6V8i36kaLy4ac47VAyl1mLSIe2FTYJrPDdj8OG+Z4Iwdkt8IPVv9K8Yf+PoPEuHAEXunGBahf6d6QAD5t9JcQ/wiPtV0CQEywhU3emU8FEkKYzR3A6FHg/jLoC/EM0O2d2aJEpYvdz7VF/v+RUNRCwdqoZbAP2ZxXb8GfpESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789381; c=relaxed/simple;
	bh=AbNznFJw7tNO7GELSX8D+PxeywVxUKNnoVkCmp1DXmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnKG7gmxCYfXRQ3A4wu4ZH1OfCnCBeZ4Og1BCbACLlEj1x/irezkgd8+LJrMr7Lo9L17GUyTmetA4qW81yqLZHXLkVBJ2p6OQoz84hdt3L0fXCR/kSFZdFqZ9keaBD6UKO3f3a4OOvSQlhemssboyuAxTzJeb6tdgklFPRfw4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMJiAwNi; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMJiAwNi"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d89a727a19so51439756d6.0;
        Mon, 13 Jan 2025 09:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736789379; x=1737394179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5Z+bg8OafqMVuPmIXTprIIiZqk6gb1AHOX/DFWzuNU=;
        b=DMJiAwNiEw1NkXB16QiPc7EsRAs++Cpj0b0SFuRm7TP1Clia2a1JqwSOaILQ1bFv7O
         rfWWs5LzBjG7YYEPTBYrbLHv9kW3p84ezE5g0ZGgmwC9VLR9cnuUZqPgPqlKiLrTeU0S
         x+a/JGLnyfzVsUOT5ZPTKmkP8DelznX1N23iIP1f3YKndV9TornnHhoZip4GIGp6j4qI
         EES4ykBhuo5SFphKbX8lvDuF+WNDIprIRjIIivQVbaVPjIYJPwvz+3qgS6oht10xjQZD
         0g3Ph1YMnrojF/txbsRZpfVn4WGFT9MTZAQnCl4VzMmqjMQOca+tr5s/nxJka7Q8KaJD
         oEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789379; x=1737394179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5Z+bg8OafqMVuPmIXTprIIiZqk6gb1AHOX/DFWzuNU=;
        b=ZN51XFgw5a7HI4sHlDAaldV7X0NE75P3YOihT4nLUDOiZljXPdpjHmf/TXjhRIXNfE
         T4PgdIAoI9nULMlLtGsNaHxUzvJy90pzM/3+rEg8LGzBtsRS4go5aCdrXISWf1OkLVGr
         9eZ4dbTVaJnypYNEd5CyEOE12EEKCqGKH6NEmjnaQQG8S2AbPE1sfYO1DtOndoRb5hnv
         DTkhMuN4uJQsVY/1W4bmoA4iaJxOR4Hiwqg69hP9m6XbZTmjnjw7GWALGgin5h6FMnVE
         ZUMsKLIWW81/vJN5+DYlGQeBG80ywMA/m40aVMf4OjWsYp9WAQiGV17m9Dv35aaDyx5Q
         zxLw==
X-Forwarded-Encrypted: i=1; AJvYcCWUvfCZ43tm7m2mHCaprlL6fO1psvKf3vUoXHhYpLDdyDAitlpCPI1OFCJEXhWpM6C4XWHtTNOPoRWuiQLWsCM=@vger.kernel.org, AJvYcCX57PrZyS6cmk+9f1OQhd2L98OCBp1PlENuo/Aip21+5uVZAXp2veBjpPeNA+sG5VtuT+vfmXACX8894u1d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Xs0ob9D3lio+bsY3kX4+yuWNAXf3LV+NZRn9dtumaPe5z0Px
	s3m3XtOHRdoRGNA2hgk/IsMe+8DNGMVdgaOwbGD/hrPkWW7jm+xZ
X-Gm-Gg: ASbGncv7ZqOv25vdMCyaLD/Cut+7QHtGe0uxHNFRJEz6pJRm3RrcHb7nrVXDxnADhX0
	N/SJeIGhTF4WrTHzx5Mcfrf9RJFkk72FtUaP2PgRQ1D88onC8yQQwK9CFZyEtrWs5u7wzbC3qMd
	pq5u/CYuaZ/Dlheyo2Py7I7vu1reO1g0z1jvJseLFfhl/EiSg1498RgT4XeOAlAMv6+aaiCZiUb
	WBEt908q++eitBzCT3HxB+UIxz2BIyCf2BPQ3mS0IXXwQ==
X-Google-Smtp-Source: AGHT+IEgdilJj3bd7kdqUXicWL5UNClqAE74DlXoZG2ehSu4jRqOpWLmD+nLVUj4eNutOvvWk5tRVg==
X-Received: by 2002:a05:6214:2485:b0:6d8:b733:47c with SMTP id 6a1803df08f44-6dfbaa20b42mr123678376d6.22.1736789379146;
        Mon, 13 Jan 2025 09:29:39 -0800 (PST)
Received: from localhost ([2a03:2880:20ff::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad9aec1bsm43282876d6.55.2025.01.13.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:29:38 -0800 (PST)
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
Subject: [PATCH v3 2/3] kgdb: Add command linux.vmcoreinfo to kgdb
Date: Mon, 13 Jan 2025 09:29:34 -0800
Message-ID: <20250113172936.1434532-3-tjarlama@gmail.com>
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

