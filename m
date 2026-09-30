Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31F4FB9AB
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773154; cv=none; b=todHTRp5AW/s48gnNCEmXFzFNhZicX0WNz+epoHdHJxIuJWjUrMZUoN3BIfU85mneYN+DBIkNvTb8p8LHRPxV5Rl3oFxTQb3TJ1jh3LV0b74B0C4W789oUsJoEYvhunaL/3b9iRUnxWRSiUF28IuF75A0JtUG3Zwuz67PcAET74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773154; c=relaxed/simple;
	bh=Mq0YPOcXIXmJM5XDX7yRYBMbSphahEFyS0D9AR8XhCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA471EWfrkbDxMfAhNnCFV4STLs5cDwo3b0NOBFQL9LYa6VV1B5ijySisz9TSv2av0T/m+DbAURnAfgSOpHYNO3CE+HLrRN+H3nVUSrxW3XdCQD4XMpZzT5P8FgBxfnu//UYmJfl2eqF2JHAHqiduvXPgtcGVG1habtV5LephcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQ/rS2Bh; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ/rS2Bh"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2dd05994cso3407375ad.2
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790773145; x=1791377945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThjIdAe3tMXzbT84DjYHLGeB5MLacVxxaFyft5w9u4M=;
        b=pQ/rS2BhyTBa4XvWNR4QUjXVZeKTxg/CfzqIGdrOpbyn/gLrYC28Um+kRKQajCUhDQ
         nhi/coiKaamqF3NL4aPFb2dpNPd5z6FPMtPQInG6PApKXX1rLwJ4ABLPjXohKQSVDa/G
         0HhoXOQ6fFv/M34z3X0mAEl4IBPdz/xrrG3+v0DOzQCHm+PrE5TlTB50ZX0muUY3Pzss
         DKxk6w7h3mrsmG1MdjDkiqFyYdyYEbWJqCSOsDgbo9Xt6cxqh7Js5ltkAejzblJKCQjd
         T2AzyXh4iJJQzLELIoXzqPRY7yRgmXhd96Wf2b1u5UL74IeWXU6QFhAGXbzIXWtNSAK0
         t9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773145; x=1791377945;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThjIdAe3tMXzbT84DjYHLGeB5MLacVxxaFyft5w9u4M=;
        b=ceM+BHJ7QMRyi5TxdQCQGnuPXMiRp6vj7TUtDWHRwJALq2ig/NHoJOs5z+02GKjPPx
         NxXJEvx+QSL1IS1uLtXp9hWucCGgc6Vv1LT3RuA+8Nk47AcoEIp7ZxWbVh/KKMvnWKpA
         2F1CX8afMWEtJXMZDLsgzZsYutHOJ83DKpfV8LAYLDRLc7urrRucrh0VOdTvaZDZXdFc
         CUK/SeVhxJly2VCVwoA9TOqEWxJj4WkayadYsbFJek3Hs0ibV8RB+EEvOTe7EwBEMKmj
         GwZRnql0q3vI4Y7Dl7K8zh4gfM8U2Htnb+SK0gKVwAdTwysOrGCF4TCAdAP7BY5efBLR
         0f4g==
X-Forwarded-Encrypted: i=1; AKwUvBw3O+QKvsOdhpQ3xy0GlU8kaZfuJNI7V5gfqVQOw93rMO864UmDqQEvl1HscwutXTxTTV5nsI2Yd7nG3V0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg/dKatOx8vSQs+Zj/vkS5Uq8NaFUgrHWjI3hzbFNpafUt3fe4
	Aa8t8uQ3hPsKjBOBJ4oYYcDT4gt2XEkzHA5nYs/WBl83kA7G+XNmhtveYdI48FHW
X-Gm-Gg: AYBFou0Uj+ypIIBa7bRL5N/vUxIDuuIpYS4SQnumYsMx1U/dGQnsAi/VrfoNgHqKLqJ
	fyKmq7B8Un1YR3MENAFF4ra7xNvjAUK8IE0xP7ftTQbsizPI04GvnFexOhX49hD7VrvLjIQNb89
	Pu48dNjSf8Gal5g5isoVFffPBvX9NJ4uzyugWYg7JNCxNeDuVghrmb6b0tO/RKEfgmYOkROOgX+
	Bf9z+rb0eQlp8BUpuDHYiBoesWD9HcDzbacWjpb5bzJtJjbZvZag9MoutWja2c+8+RHk3jdCQh8
	/EKqpyyq8/uYOuO02neIp5VUzx5PvnpB8hkGnWkqhujz6hghAtOj4nDNoHnKoWM1WvAhXSfy6LF
	/HAfRa4X2lQTgf4MvFzVExx9f8FXWHaQhQEP9spljGWc+II6IA+qZmd/0Cv0am7K2MYJZtc/EaF
	4o82z0sovDprAXgL9IaNAzozpWaEkwC96pA5q4jBEo4UKWo8v0vKRLTIiUFpva2ObAaSyfp4Efz
	BVcUr2DhKTlBtPm/hnpFNmlV/pFIV4GKZx2DG2jHmCQ8Cct2PFC390Gp4YaTUHpZS7aQdJirilJ
	4+ihurIAYQ==
X-Received: by 2002:a17:903:4587:b0:2e2:bf79:3cbc with SMTP id d9443c01a7336-2e2e4a1f706mr10544205ad.14.1790773144737;
        Wed, 30 Sep 2026 05:59:04 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c1b3d7sm6751925ad.70.2026.09.30.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:59:04 -0700 (PDT)
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
Subject: [PATCH v7 2/2] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Wed, 30 Sep 2026 12:59:01 +0000
Message-ID: <20260930125901.778868-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930125901.778868-1-benquike@gmail.com>
References: <20260930125901.778868-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
uport->uartclk (an unsigned int):

  uport->uartclk = new_info->baud_base * 16;

While uart_set_info() checks if (uartclk == 0) and
if (new_info->baud_base < 9600), when new_info->baud_base exceeds
UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
(16), bypassing both uartclk == 0 and new_info->baud_base < 9600 and
setting uport->uartclk = 16 (baud_base = 1, well below the required
minimum of 9600 * 16).

Use check_mul_overflow(new_info->baud_base, 16, &uartclk) in
uart_set_info() to reject overflowing baud_base values with -EINVAL.

Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
&ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
(TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divide by zero")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v7:
- Use check_mul_overflow() instead of raw UINT_MAX / 16 comparison as
  suggested by Jiri Slaby.

 drivers/tty/serial/serial_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6ed0195e6912..9a8f4c2e1180 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -14,6 +14,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/console.h>
+#include <linux/overflow.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -931,9 +932,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	old_custom_divisor = uport->custom_divisor;

 	if (!(uport->flags & UPF_FIXED_PORT)) {
-		unsigned int uartclk = new_info->baud_base * 16;

 		/* check needs to be done here before other settings made */
-		if (uartclk == 0)
+		unsigned int uartclk;
+
+		if (check_mul_overflow(new_info->baud_base, 16, &uartclk) ||
+		    uartclk == 0)
 			return -EINVAL;
 	}
-- 
2.47.3
