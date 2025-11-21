Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FC2F4A1F
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751077; cv=none; b=pUHyIJE6R8yXV1hxzrNHDFLb67vPIZPRzSVOBQJ9kHwvYMyJj6mu1QVVZI3efqoao75LEkGCapipIxA6AT1vFZ2lJwDRDy7Uva2FhnXvUEe9U+izdmjAKsI5naERKR2gkjuyeSWjO9DctADC6Y52sIkGV+GV+xj6u5qrpxEdF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751077; c=relaxed/simple;
	bh=Me+FmgCVuipIeMGIOmW7VyWb0ioSCEd8yB49PjrkFbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4ZI/3ZFCH5iN9kOIkrD9C04w0unLwHRBX1YTyKOEWXa+FqgHhWO/ICALcB3HBqLKIZh0OuMU5qoRxYeyOaHmVADIwGOQPX89AjGcUbOBUcTlN+itbl3rcjvY0qBlbrLk5A9gFIsT71MqeS6j9M5yoptz+voGKRt//2fwNv1P+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DrtNs5Is; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DrtNs5Is"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so2196323f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751073; x=1764355873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeiJZSVEGGN00WPtN6lgqyU6XWLEKHbZMZ9rjX+7HGY=;
        b=DrtNs5IscZvUGr6jWbsf2bJgA3AeuT8c3OToH+se8gsIp0DYziPVQpSqikQ70nO/9l
         BPTzl+9o2UAKNzKYzUkHhuT9fPecCdy4UBKX1/e2P011F4P2rewhUKEEL+oczyySR7rn
         FTKk6/r5OFBbNJi4D8IFrViybQkTJLgfwpXIPTpOwpjtqpVXZ5nh6XaMJCDHtYUIpVlu
         LkAPh9ufpfcLyJmRxtITxnBjxXorr0Z4f+34/SMvs0xMvW7DGydqIOYVQ9g33kEgxJST
         PVzWfjwkqZAQAR24IKczF9/4MuQuM+HnuD9rL3yXxL/fQN50Kq3RxTmabrhxwNLpyUsU
         E7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751073; x=1764355873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zeiJZSVEGGN00WPtN6lgqyU6XWLEKHbZMZ9rjX+7HGY=;
        b=V16Fp53f3OQe65+VVws/XiXh9tDAAiqPD8v0/sjAKBxn+u9+ubsxdoj+W1vTAWgCZH
         aRm7VOcgpgpaYB37tekzyjHqYazz3ZBgpftp54tf+MJ9M9T4CKsOuKqvVeat1J/gRRf1
         h0ImKRrTfWJb5Tk7hw+NHB6lZSJ34B7UOE1EL4PLqKX0iMH9i4onS5c5HhAGYkHZJhuZ
         eTqaCAPsmJXdKppS5kXj4+EsAGMhPH64K/DffPD4c3xqsjX7fO016kA3f8Oe8GHNELmY
         GuTnyvV5BuFl0/cbK/mdoQ+KYLfy5r/PbznDqLOVu8jI1JSuGfjGPuFBU3HGpsP0/cHK
         ugIA==
X-Forwarded-Encrypted: i=1; AJvYcCW3R3pbX28rdhRoncGb9Z5QdGVeDm3a1ih83nQhrmB8BXv6gtEfY2hrbqT3Ywxxiu/oAa/UxfyjdoqnRDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehbLwsVDyGoJBiFf9WeZtgKUoZKNhJEb3PFpNq05/uYOThttk
	2QLxA1GzjobTMhSMNBHXMFPi+Cerj9N/udmlzQ5Onx4IOKBhjjtJVTWpRP+m0Yi6Ngs=
X-Gm-Gg: ASbGncvVZrGPM/Ki2YShPtJ1rJsakza8aKulV/Rc2R49WZZmOXl3QNO9FmwIAOI/3aa
	aDJuPUjDTRioNnG50aaDAc6+0PrmFmpj3fdFrLC1o5hmvG6uGW/8R9x2SwwO5KwoRvUAojLvgxw
	rf5bfE7eedZkY4FJv44OHYAzKG1Yu/wKwVmDB+KKw2GbyeND+Zbkhr8P9DjWeoa5goKHC1wY6e0
	nVtjd9BJZcG28Mv6ecjCz7365oRHr/FVGne5J8lOeONLERz3dqc2aEvK34InSxlZkCh4jpxvC9x
	4IqwKgxsXG0qMOaDKvxYhpQbsc9He3Nsmf2rLxSCpGzg6zp9l3osXItLTL9+DWqJqgSgTyoKduo
	8cHY7WSu4Nu0i1YjjFZdOn3kS4ltNYCszxMOmI7eo15kWEzIcWxXVUEscUejnLBpfxA1asfBbdM
	nZAHZZWlh0YKswOQ4WLmlnW6+UBfoZ4TdR1Nw=
X-Google-Smtp-Source: AGHT+IENN61/obhbDbsiWgswns0YOtLZMBMlnpiskqZW9+NCINqWoGwYz+8q1vTBc1WOclyJO+Metw==
X-Received: by 2002:a05:6000:4210:b0:429:eb05:1c69 with SMTP id ffacd0b85a97d-42cba63b646mr8898226f8f.2.1763751073426;
        Fri, 21 Nov 2025 10:51:13 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:51:13 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 21 Nov 2025 15:50:36 -0300
Subject: [PATCH v2 4/4] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-printk-cleanup-part2-v2-4-57b8b78647f4@suse.com>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
In-Reply-To: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=1998;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=Me+FmgCVuipIeMGIOmW7VyWb0ioSCEd8yB49PjrkFbM=;
 b=1f1XQPksSyg2y3pXUnelAzKyzaedaVrzMjIzV4D5cPN+kduYUUNr7nIbIGu3SdlK+vY1dppDR
 WrcjcRwmPvCAZWS/IHHAlVNhq/wnrv4ph6Y5HplOAbeUOE6cjJPPdGD
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

Since commit 9e70a5e109a4 ("printk: Add per-console suspended state")
the CON_SUSPENDED flag was introced, and this flag was being checked
on console_is_usable function, which returns false if the console is
suspended.

To make the behavior consistent, change show_cons_active to look for
consoles that are not suspended, instead of checking CON_ENABLED.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/tty_io.c   | 2 +-
 kernel/printk/printk.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e2d92cf70eb7..1b2ce0f36010 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3554,7 +3554,7 @@ static ssize_t show_cons_active(struct device *dev,
 			continue;
 		if (!(c->flags & CON_NBCON) && !c->write)
 			continue;
-		if ((c->flags & CON_ENABLED) == 0)
+		if (c->flags & CON_SUSPENDED)
 			continue;
 		cs[i++] = c;
 		if (i >= ARRAY_SIZE(cs))
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fed98a18e830..fe7c956f73bd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3542,7 +3542,7 @@ void console_suspend(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_list_lock();
-	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
+	console_srcu_write_flags(console, console->flags | CON_SUSPENDED);
 	console_list_unlock();
 
 	/*
@@ -3555,13 +3555,14 @@ void console_suspend(struct console *console)
 }
 EXPORT_SYMBOL(console_suspend);
 
+/* Unset CON_SUSPENDED flag so the console can start printing again. */
 void console_resume(struct console *console)
 {
 	struct console_flush_type ft;
 	bool is_nbcon;
 
 	console_list_lock();
-	console_srcu_write_flags(console, console->flags | CON_ENABLED);
+	console_srcu_write_flags(console, console->flags & ~CON_SUSPENDED);
 	is_nbcon = console->flags & CON_NBCON;
 	console_list_unlock();
 

-- 
2.51.1

