Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BFE448BA6
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833918; cv=none; b=IwdeC1xzjIn8haiO/xVXXwKKoCicBzaju/ygR4JtngXctptu3aAvCU2jhMkg3pPFnPfhnCtHcnG5ad0l2edTCfEIDtVjbxUtWSTv9NPy4PkIaR77y4NIgoYEQc6QkV0hFIlBbtEntnGylJU9L/85eBJMV/RFHcCuQtAa8ddSl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833918; c=relaxed/simple;
	bh=8mhW0YcuSDgN98TXAQOOJ7CdM5VJUx3gNB8aMzXeKEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgVQQe7IP6SCgWDuvwTGRf382X6PiDh0j9zqb5e46D+O2QLmizHhPEFUzJoE/W3d2HIAawYpzeBpzrTgLGF+GoqKhE23WvbT3gfKEt0oTQ+AiIdJ+gfIjkvdgydttrSalZmg28lpYEaL7Uwbe3KNcaLRo2g6ssXC7Re0/pbBWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=E6j2i/wm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="E6j2i/wm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe377a217so1092817f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785833915; x=1786438715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i99GOuT3VUOcATvwRkqhpDeUhedKTS+/sSk4a6fCl7A=;
        b=E6j2i/wmJRtjpNWQ2+VTfOceIPs7sC3rdf/8HhmmhF4V6K3F/gbdVl24cq+e6ZBIo6
         WLo4iM9RfuyGIRcna7FyHp57g0aVMqwXN3GjeppihsLu7jWhVeK+gAOvTotd+y3dUblu
         ab23eyQ68LB0t4WWTxM6O6WbvBb6j77Jj45TQTAqiWzwHpuno8/twhIUvgy29ZIBpz2E
         UxA9RIUvViheKoBj4BJxm/v0AR/PnkvcK9mQZW4UHHp7WkiAI6DN3ol7wUVqi9pVFddX
         l5IV2ePJipl7jGA0Kq8kyLPCB/sFakP9RntxBdY8A9kRycPRmFaE0KG3ldAEKddwolwU
         VCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833915; x=1786438715;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i99GOuT3VUOcATvwRkqhpDeUhedKTS+/sSk4a6fCl7A=;
        b=LdLLmiFVnbGVL08kLn8pwpnHSWugekvoksqaV8PgxXWMizhRb5g0kq5pgdwwsR3ky7
         cT6tCjiE2SN5PdI4AHme6x7vQHshy60d8c3HwO6AOHkCsxaRhIZ1+3YMHpvyq7bFd2mm
         6dclIiHNpy0GF0Ynm58SZKuflVO+U/rF9redslmg48PdT2siiO/hzSX/fJm9B+3RqpQu
         Od0Zf4Fo2DIayIMkOcqFnJNzAT3L9Bf8vlToiB1ysVGN0eM+pqeharM6ObIvAt7juPGv
         OSte4Gz0/RF/OBkCQlwY1D99HrcmOMFxOZtTARTBlLyQtcjLFWLSTVElEaJRF3bsvJVq
         YPfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoC+rYXKN2+jdLEnEpFLlnc/A+9ZiVuKAC0dDlxNkBLXAIa/Hsv6RUVNoEIopH6X9LtbRu7L9sSMVlcAD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCN+Gl28rGd2YFDbmlasM9B3lavlwoxOk8AChakak+4HCMWGdI
	DNyqzKU0nIOWlQYDBpAN1whsLt9YwPHKNAtNcz/izhaKylg67/KD5XnXhRPP9lNUfxE=
X-Gm-Gg: AR+sD100mUgBk9xkKwYp9Pkd5foPIcLx88GQV5wwaAcuwHO2eq5J+J37Y1FK/QXXrsV
	t0N7yV6J0g1Wj1ZR8M13gKMsN4Y0CmujrgVwgMGKCWkCxjwgtrBXuvPOgygGcBGgb89iLFqJHwb
	G+QzLQZoOTDABBcsRVJyDwJinqR1YwoWSS5mwBd5eonrC71zH5/O7z6IcRMsQh6HbdgpGX+Yiz2
	FrN3zdQM06/+Th/1GHVU2UdhHOXJjZkEVxuY8KuoL18IMtaFGRFIvawQanzDicPj6nYRmhLa+vp
	BUhVgj4TL83o8y0rE4ACXPBdkY2eiKNDBIUAaZz/Aq0M1xdrAik3IxA+4whHCMISgCWWIstaw31
	xUvZsnxtijjjYACHIcfbUBxo1uU5EUvnszEVym3KH05Aaz+RcxfYUz8U7co0w8bNi7AFq39W6uL
	vG56F7oNrazhmSh/uKdyQKmhBIyhpXoD1m5rMYQqV3Dka+C3KkQAFwww69zjmxor+EEue53OJnj
	QCVqcZjE5KQ4z+C2Puvbu2N3BzRuSkIELze6P76FJ2IWYLLbAm6
X-Received: by 2002:a05:600c:811b:b0:495:6934:414c with SMTP id 5b1f17b1804b1-4980c696c7emr306414905e9.19.1785833914710;
        Tue, 04 Aug 2026 01:58:34 -0700 (PDT)
Received: from localhost (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de. [2003:f6:5f01:7104:96a7:6592:f113:63a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4994a0f7b73sm86648485e9.9.2026.08.04.01.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:58:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	Kees Cook <kees@kernel.org>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 7/8] serial: 8250: hub6: Add cleanup code
Date: Tue,  4 Aug 2026 10:57:59 +0200
Message-ID:  <a258f2dcbf9eb7a5ea07209734201ad873addf22.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8mhW0YcuSDgN98TXAQOOJ7CdM5VJUx3gNB8aMzXeKEg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqcamjFQnO38kwJYDr2BFeuP0TfMdDevYiODds6 G0InzKXtHiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanGpowAKCRCPgPtYfRL+ TkukB/9Flk1eE3MdKfCb3RTRxgLgJELn4juYnEYEvZYZ06CZe9jYtwJAr76igdRJKIs72WPBbcV aUTJK+E06vqrKsrjkd93y53DJTa0VrE6zigjjoeH60IXqNhb/30FaqxhkX5OkrEVTtoowOQm55H pV1frMCVx+J1P6xZnPkHyHFAP9FoHjHlD6ybXVo2A3qgzhW8ZqCHuyvY5n2kziEjRhYNlKD3uGB ywYnEf+8mhELZ2LET4AGSsqn7k92xU7/A9diBuyXPC1rPTXfH55CSm3ym6E/9lk1T3GB3GQbuLC l1xWJH335+w9KUvDfns2zJWcrxMzDXNJinoSkwUFxFfxwmqw
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

At module load time a platform device is registered. That should be
undone when the module is unloaded.

Fixes: ec9f47cd6a14 ("[PATCH] Serial: Split 8250 port table")
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250.h          | 2 ++
 drivers/tty/serial/8250/8250_hub6.c     | 5 +++++
 drivers/tty/serial/8250/8250_platform.c | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 39d72f1480c0..01fed8d44b7b 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -317,8 +317,10 @@ static inline void serial8250_pnp_exit(void) { }
 
 #ifdef CONFIG_SERIAL_8250_HUB6
 int serial8250_hub6_init(void);
+void serial8250_hub6_exit(void);
 #else
 static inline int serial8250_hub6_init(void) { return 0; }
+static inline void serial8250_hub6_exit(void) { }
 #endif
 
 #ifdef CONFIG_SERIAL_8250_RSA
diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index 3e548530ec4e..55320b794165 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -53,3 +53,8 @@ int __init serial8250_hub6_init(void)
 {
 	return platform_device_register(&hub6_device);
 }
+
+int __init_or_module serial8250_hub6_exit(void)
+{
+	return platform_device_unregister(&hub6_device);
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

