Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549BC25A342
	for <linux-serial@vger.kernel.org>; Sat,  7 Jun 2025 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749264877; cv=none; b=LAhL4JfBhsEhaWKc1DPnI9Z+o4pd6B3ncl+ybofWfb615K6f2bU1izv//ftg8hQGm/9D5TFu5w9dbfuqIWZVXwdNzBM3thRyFPwxXxjTPHdkAdno7K0g2TUgRotoE7C8FcG25A+ztKnHmVEk17E6Cl3dYlAOEg3d8C63+XgN98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749264877; c=relaxed/simple;
	bh=iLfgT9HQWZUDDzN0tovkdkdRnEgGdMwJcOWfpYFBuU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNUfgHIEMR9f1DBFObluU1q3qH/UjNRbiXloZi5pVe+/fxeNVocXZO3/PAsjkOIWRITcMggjIyWeojJitB+R+Bw6ZfAMWxzNGzJFDCN/abStz2CDwtdPmkGU22S8mKlqUv7UTaR9AD/ngukPkLNz9wDkWyHLq1EXiDP759PPGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NOa0jP8T; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NOa0jP8T"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cfb79177so14363655e9.0
        for <linux-serial@vger.kernel.org>; Fri, 06 Jun 2025 19:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264874; x=1749869674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cwhjr/MwOcrXAJEej0LaRMGIcO9EQcwPYBdM3grsn/c=;
        b=NOa0jP8TfuHGiGnE7hKL/+QAnBqOu8pKY/DhDXe5P9VJfjY7iRMfLnONAUSTr+Mvd4
         B1Jlr95oEadJ5TCKALdU6JkMmFwGF3ENn1eQp7EN2Z/+4UvUiqQVI5W4PGUERz43Xlch
         hEnp024VJ6/Eij3jsd5E0f0003wZ/QVfEX4dk84yOlmGl9RoXvkjuxHIs7M87lMrAkSe
         mrjU7Dqrg0J/S8T8aP00xcasX0yogg40c2JNpJQVzmxb2ALn0RB9fumYFYHhdbm9aa5/
         kBaWSE9U0GBO/SREpkKwC+YDCyXHRnkBmhJ1pMwxQ94Sk7rk6IKkn7ifO4ud1s1reKNY
         RWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264874; x=1749869674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwhjr/MwOcrXAJEej0LaRMGIcO9EQcwPYBdM3grsn/c=;
        b=qJyBOwW4v3zbd5EPre/Ai2/CWgye9v/a8zko2mOngmJ+q0xm844cduwKJNgKGIqKYi
         wazHTd+jTxTjJ4E9cktU7S2vONTDwgEe5olfBf+ZRu/692KSb3noEXQUvxRoz750yF13
         R/tQFWpib5jIhxeW4/dhPLadkuP5CPLCeo6Tgk3gz2RvwrUVapmRig4wIZkLYSjjnfgh
         mE4JM0eETik1v0y3uEOBfpIXjlL+wRDoyq0PP8Eh14vRel7ofSkwupwW160ivfF3Jpvy
         cwmXYR4afG6LJHZ/jZxLbOp6hrhOSw/8jbnMq9qpI0Fi4ip2YY02SiKcpGf6U1bXROkR
         7Pqw==
X-Forwarded-Encrypted: i=1; AJvYcCWXc1JQ/QK/+3/+7mwKhs3kpTsRpOb2emuPjptcWfGN+XuEc3kxlSDuxhjpWisds06Pu/lp5gtCcJ/hpbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFA+F4vfzojrpmuH9v777ovcAwRHheWIgaJXqrH//MaGACZ3SH
	OwjjtqO/5U18EQwZxUrPc0XUkyLfTTvCXZedIGHmqgvEjxQcWHAjSSADkNok9+p2GnU=
X-Gm-Gg: ASbGncuvZyIzg1zpPT0wAYmEWDuyHR/AHDOIYZkOVdVix6Lj+ZcR41C2DLi+GQVqPp/
	zMJjvzl7JctywS6ghoWHfA7BCYa8HLDqjcyUkdvC3XgW2X+9T54XawhD8GPe0L668vwm8Po5B7p
	91KSKHHQg7zX8JHtforsjHVYPrq1DI4zp4wlTE6/gnDhX15+AEh7MFChYQqO1ic+m2N01iVQbqM
	4OtDvTIBXmNvi8Qu3KWgteT6Fah4Q5F9+kzJ+w4+bLoREHlbo8T9uR7VmTLBxXYepV/DsiOnEgx
	Luvk5gK5JHFDAtoyraXbJDWgNyMJBuV3YYHL/8/FQWNP8C9n
X-Google-Smtp-Source: AGHT+IHvN9wEy6EKNYkDxnnT81hoywOQZ08WI1JRYEWNl3eQSXHLiVXm+Dos5iynM7Sa+3YILwrh5Q==
X-Received: by 2002:a05:6000:1786:b0:3a4:d452:fff with SMTP id ffacd0b85a97d-3a5318837d3mr4663312f8f.17.1749264873645;
        Fri, 06 Jun 2025 19:54:33 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:33 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:48 -0300
Subject: [PATCH 6/7] debug: kgd_io: Don't check for CON_ENABLED
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-6-f427c743dda0@suse.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=912;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=iLfgT9HQWZUDDzN0tovkdkdRnEgGdMwJcOWfpYFBuU0=;
 b=lwh6KzwEyh2dinkiRzMgjAoctl1hygotlVKEbxBK2YgOdS8fCmLq/Q05gztFUdw0JdxCeH0Hs
 zy4lhvv4ZsBAeKV44NBYiajx6Sqj8Awb920ZzuYNMmySvPls0kFGTyP
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

All consoles found on for_each_console_srcu are registered, meaning that all of
them are CON_ENABLED. The code tries to find an active console, so check if the
console is not suspended instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..cdc1ee81d7332a9a00b967af719939f438f26cef 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -589,7 +589,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!(console_srcu_read_flags(c) & CON_ENABLED))
+		if (console_srcu_read_flags(c) & CON_SUSPENDED)
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;

-- 
2.49.0

