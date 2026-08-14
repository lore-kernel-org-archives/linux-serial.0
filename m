Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC64307A0
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699205; cv=none; b=QyTJZqlBbwBBbssUjFGEe+r0Zq0YBnEcEngHdqv7Ii0XcXObFjFZzdKtq8ufpm1DaQeX42cqN+6V/wdC0CiYEO9VGt+ic01NEU/e3LKrbutpITFcl9WlmGoE/NQZsbhstQ3kMsvY4JH5jyUHkTH3esZCuncnHeZ3AGshoBDTe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699205; c=relaxed/simple;
	bh=6P8MPEPf/cBvWOJG5iAtcz4MIxJaCtBUcbTcKXStiIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYIUrzktoin3slv4bo8rSMsmb0LKmq0B+C2GlUK2Bj4pPRWxS4bzVkTatNA3sHZqkJLD9jraqg1DJqqooF1p2H1qvX1WPnc2UQfVmhNUb7rieg+dRHs5vSeZenZzfXeaamfyAI0aykaGoKEndOUcZKayTaa2Y1pUAIP68E4lN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Yv6MRn/j; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Yv6MRn/j"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fd4531020so453442f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786699201; x=1787304001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmQn0kgJJZu42pOWlBVe9VCRdEn4YGhm8ifFpJVQMus=;
        b=Yv6MRn/jgyVBlO/ik+YanS/behjgGAPh7Na9xE+Hvx21a0nv576W4z3IieCub93aB5
         kMnemyqcyoWBKvJgF/puan3m/lp+kR95YzTakwmHjcYoBfIV8YEtX9atxZ2HJhShMKrF
         C1DSbFz/YhD/kNk3YcknsqKCsZ+r42BTuodcFWYFDxw5G77AmQOIP3/cSA+SaniwhgNy
         Mttjt9Ot5lWICuQYhHj+muAqQfpQTh6+q1V5l7JUozjmBH9eafHD4tkq4Wd5j+Z6qtfL
         1g8Q9x3kDkNxVFBj+9OmBeOrQ2GfYn6bz3rW3nDF0+IFNkts5tb6P9hu5vocViECe/RK
         BmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699201; x=1787304001;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmQn0kgJJZu42pOWlBVe9VCRdEn4YGhm8ifFpJVQMus=;
        b=FvmGfFJ1yPjhdEu4Yvh71cZKxEDhC5lbyujvBxqeDniwLFXPTXzss3fNlBOyQM9WsL
         /eBpTeG3ae8aTP9SnJ1sxor4M1vL7CYGYFRtJC9yzujKf+vXjcITCemjFcJG6Pg48MIm
         wCRcXkfNk0fmMqZRDefPHIOXOoN4tGRzKtSS/+tyC6ztDVkU0NVjkygTe96wTi5aC82j
         kLcJp0Fdi1Knmfy1B4ThYot64kknQY/gpNL8sLzg7MGJfRE8CnhJ8mj4CyA/42ZEB1Wa
         oyTH1NIxcVBieqGbtDjQFLE80cUNVGpttOUuL09WKotNBkY4sSFAmhp/mnnP4fQ5CxeZ
         84xA==
X-Forwarded-Encrypted: i=1; AHgh+RqPQ+DlIT1puft2TXFTHr3Ft5APSQjBAvI7GZMYfFesQlHz85mzOPN/bL4LBWLzW1syiejaVRpvDR4Zyi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywib4FOYwvJP5Xw9fwn9gQcyJFJ1YOMsBgvlT9qSelyUrAm3vKv
	bwl1LdRd0ewnAGi72qsAcDE6ieJlaZjyeI0Al+0Uw0zPyfy2SeAZR+ygIhqnpuIXW8M=
X-Gm-Gg: AR+sD11UGGH0exJdQXkjYDGkFkQlCty20VcVhFl7c9nA78JGTVgwb8KZQz0RPmy3w3X
	hWpaH3cP9u9lNTnc73D1Vq4k0S7kMAuFPhcRf0q6jIqr01bsHsA1iZqECRZGiTmVfDjIlkGGfwj
	Hn/pUodZJUyS704PHEYOOttAHBEqnefSTx7lARbd+VXf8KFXIkpV6Ti5RQaoR+UzV/+Nufl70mU
	I3U20IywPT70SaJ7etD4kZkMukRf3wRELATG71P3qR+MJGV5BD58nKuX3L7ZPPqazbqKqot/jI2
	wlaQ1VaOahYHm9glNhYlqMfqSXo11wrfSgL/bhOi23SjWJoKpI8MkJMzc3fAym3dDkHF1APbMyz
	EVkAqMch71lg6dvYWIIJ2HpRPoKVIJsoD8z7V2y2mr/NzU2L88xNlI7TTwqKvsu2feoi1FZxpaX
	Bi7BU1MwHUzRT1yGsXCMONZYseHGD6NJuL+DB8aNXtNq5cR6rtWbS1n9lWQGwTryhj4Cns/WnUj
	URE7vYLoo5/BBRGCmNSOzugg3EmBxJ7OkvgjrTk7lqpskuiQ82K
X-Received: by 2002:a5d:5f56:0:b0:481:5167:a9a4 with SMTP id ffacd0b85a97d-4816071c181mr6677214f8f.7.1786699201165;
        Fri, 14 Aug 2026 02:20:01 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815f219e12sm5937562f8f.10.2026.08.14.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:20:00 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	Kees Cook <kees@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 6/7] serial: 8250: hub6: Add cleanup code
Date: Fri, 14 Aug 2026 11:19:32 +0200
Message-ID:  <4f1903ff2907f3e8bbabce345f628771e0bbd4e1.1786697789.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
References: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2554; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=6P8MPEPf/cBvWOJG5iAtcz4MIxJaCtBUcbTcKXStiIg=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqy6u+ujfhz5/eZVYrPdpbZy5dvWhhPcgxjvZauZXe7dW Sb8/vbtTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmovCM/Q9/UYBR4rm4pqVB K/wT1XQTyqYJ++ofFvrUUtDuZbAoZYOOvV5kWwljd/zdQ4zz21OtyuRKzjJn9exPiwgpCl/YruI Y2RQ3a24to8urvCOCtR4hT776Pl2107ipYmXTmsf56YvTump3rtwfb+6ZJtGxw2LKW/UFsxXY5F KlfnHoNgY+lawL+y6Vu8lU+DH3vuf3Zl45J7OtLGC6lffCshMV/39oZYvXVRpl/AmQTLF7EWt1Z PK+SLPIVVubW7UnlzDmHP0xebaN/BkZhVO35G32Jh1P+7jM/uXJhpMu+jlnFM5lN72ew3+yIW7K +0VnWju1lRrFZ2lO28D3/IJizOblRW5sikFh0antSfsB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

At module load time a platform device is registered. That should be
undone when the module is unloaded.

Fixes: ec9f47cd6a14 ("[PATCH] Serial: Split 8250 port table")
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250.h          | 2 ++
 drivers/tty/serial/8250/8250_hub6.c     | 5 +++++
 drivers/tty/serial/8250/8250_platform.c | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 3fd25b7a7b81..f197db78c60c 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -318,8 +318,10 @@ static inline void serial8250_pnp_exit(void) { }
 
 #ifdef CONFIG_SERIAL_8250_HUB6
 int serial8250_hub6_init(void);
+void serial8250_hub6_exit(void);
 #else
 static inline int serial8250_hub6_init(void) { return 0; }
+static inline void serial8250_hub6_exit(void) { }
 #endif
 
 #ifdef CONFIG_SERIAL_8250_RSA
diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index 3e548530ec4e..4d4c54c951cb 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -53,3 +53,8 @@ int __init serial8250_hub6_init(void)
 {
 	return platform_device_register(&hub6_device);
 }
+
+void __init_or_module serial8250_hub6_exit(void)
+{
+	platform_device_unregister(&hub6_device);
+}
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 3a2dff9ce7b7..0570366a71d0 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -326,7 +326,7 @@ static int __init serial8250_init(void)
 	serial8250_isa_devs = platform_device_alloc("serial8250", PLAT8250_DEV_LEGACY);
 	if (!serial8250_isa_devs) {
 		ret = -ENOMEM;
-		goto unreg_pnp;
+		goto unreg_hub6;
 	}
 
 	ret = platform_device_add(serial8250_isa_devs);
@@ -342,6 +342,8 @@ static int __init serial8250_init(void)
 	platform_device_del(serial8250_isa_devs);
 put_dev:
 	platform_device_put(serial8250_isa_devs);
+unreg_hub6:
+	serial8250_hub6_exit();
 unreg_pnp:
 	serial8250_pnp_exit();
 unreg_uart_drv:
@@ -369,6 +371,7 @@ static void __exit serial8250_exit(void)
 	platform_driver_unregister(&serial8250_isa_driver);
 	platform_device_unregister(isa_dev);
 
+	serial8250_hub6_exit();
 	serial8250_pnp_exit();
 
 #ifdef CONFIG_SPARC
-- 
2.55.0.11.g153666a7d9bb

