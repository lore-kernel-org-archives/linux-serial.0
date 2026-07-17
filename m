Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9A39CD1E
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281452; cv=none; b=H3MGXBX1tKUhY2bEutDLnM2dazZnVzaDpmlM9Z0ohVylTtmKsnnfNIFPtsjK/YeGxIKkc9R0TKqsVEsLbi8RF2cYlbrh6Bot213XMJpLbWHY9pz2oB16x9CYUGkG3G+ddvKyN7sjsU+X8cywJhHzjRgykQNkyRTNmnxNic35c4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281452; c=relaxed/simple;
	bh=ys1Bnnn/LANGHx4LJ/blN4Y406HHq5JwZRPZZ4WEMSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TppsUsdevFH3mc/oTnuTXCjl/xA8asBaXYCTfEGPPwuX2+M8FR0wAhRh8qUU8LI5Ii7xyfy9ERUVEtewczZqr/hL4rncAtup+XpgSu2SmliBSj+wgCYmNWLCU39w1fcjVPM55WWNDjQT5883chu2SYBJimj2zwZGLxvMvjPtyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex9Nd7Gv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex9Nd7Gv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954d383e64so98005e9.1
        for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784281449; x=1784886249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rfVvhbBQ4LOML2JmIul+hMSx6zjHvq6VT6JmZI2Uurg=;
        b=ex9Nd7GvJ++2V2bwVoAfdgM0O2i3f1mecr3j/1CHjAsrK8ZBGKOef9qImNc2NP6IkN
         N+U4A9/TWovrJoY/fC5kUdH0mTl16j0vKyeLG7EAP3X7X/nmWiPVxLPDRRuq8vXeEOtI
         EtBlNV1HoPIPGcB6ft/7WOv5vL6L1oODfhmwfAgH5BHRKoAIH2AfLYc62xUjQUZ2QGNn
         0fhVLvsybcMTZYGsgw3VEivYZNDNgn+rtsm07aFtIjb5zvVYqwg28viglyE7atIQffTO
         on48Z0RYx1K08jFkF+Dodf9/N9FNMJ7MgjwjQLu6uxoi+KycgcNnv6IQl7uTOsmWCjt0
         Dcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281449; x=1784886249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rfVvhbBQ4LOML2JmIul+hMSx6zjHvq6VT6JmZI2Uurg=;
        b=kPlwEpY1hMMRR/XNqtK08a2+o4Kfu394wRs1ahbz1v1ukM9dwz1AHMScShdmQuw/rv
         pljqcCfc6pQAv1VsJFG37bhSj139OjjTBnSS+vQlods/nzke+iR8fjOiPgrXzfVc/hWj
         IIKfK98vqERVdN960O0rL2jZcvRxm8hcgvldvZ9iA0NEvgPjPoJJw/lYK5lQvFF6dxg/
         4D+ICo32Bn+UYluVg9yQq8fUPohBh7gQmd2aZpoRKjrxhe4FyfIWHfe0jcS6eFc04vZ1
         exEO5SSV5wzTQ8+2Ugeyjw5+pVhkZY/eEHRkQrKgjGZdexrKzJfuBYVEbQPAMndjUo96
         ZTYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIXUUqQCdPHLJ6YaKQrJtJ7CC+EGZuopAURUwjOJmgA9bGlziBtptC7QDmBIiDNqFiUt8BTVtJPlbZXBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWC1RbMsw+kvUgftEOmWGBGOcNFThP+LcmXI9CAoywPJx3+CzE
	l2h2sly/lXM4Oqu4GNx67/Lch5l1Gl77vzbJSg7ksl7OD0vAsbxXM0FM
X-Gm-Gg: AfdE7clL36HbEo7c3+z3HbD7d5hXV5RCVNg5ExZ9Td2hasKXJBSV33dw3OKF8JKfSkz
	yyYI8XCqoZ+YXP7OwjYmsY/ir6bb53vIwQzh+5n1k/CgfGhhiRMFWuJ3bjngyCc7oilj2WdY3QS
	CwPWtro53NY/Oqiuj9CAAA2uXRWY/rgkqcRyWW4bXNGp237zDS8fIVykmbMojcQIT+xScorUlzL
	r7dH+h3ojjX1OS/FEJld1XHN+Vru6gsGAaI/8pTRUx/8eJa9vNzOqPdpr2pXuXrm4IH9plgr3qq
	d5HI5NHbbpasV8eG+xPOvzsGW6a9dCo8OZ7EgzmaCclYYrQVnUDmfg3PlGOoSrF2XKIZ4d5a1aD
	KMuiTMahG/axrAWxASH8iCIbo7w8Ek8Yj1uCFZ0iN7exoFpkOk8h2o8qBh0iZRrdZyyRqvdhkYd
	ay+s0SDV7+6hNkDA+yUqZcrmR6usR/MDATIBhbc4CK4itb9zuBeoOoO3Z/SGcc6ejBuCjRiErVh
	kYfcb4iQOzIiB2VmdOU6rpBuT76FRdaH+JPaWkC0Gt4JAb3hr3qHMd/owni9z6A8s6Wi8vVf9Mh
	MCheHBYKEg==
X-Received: by 2002:a05:600c:6a0b:b0:493:c453:6002 with SMTP id 5b1f17b1804b1-4954a516453mr13102905e9.35.1784281448075;
        Fri, 17 Jul 2026 02:44:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a56c-5c01-55c4-777b-77ab-69e3.310.pool.telefonica.de. [2a02:3100:a56c:5c01:55c4:777b:77ab:69e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954966a033sm30243855e9.0.2026.07.17.02.44.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 02:44:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH v2] tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
Date: Fri, 17 Jul 2026 11:44:00 +0200
Message-Id: <20260717094400.67501-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hvc_dcc drives the JTAG DCC via the ARMv6/v7 CP14 debug registers
(mrc/mcr p14, 0, rX, c0, c1/c5, 0 in asm/dcc.h). That encoding is
undefined on older ARM cores, and also on ARMv7-M, but HVC_DCC only
depends on ARM, so it can be enabled on e.g. ARM926 (ARCH_MULTI_V5),
where hvc_dcc_console_init() runs __dcc_putchar() at boot and takes an
undefined-instruction trap before the console is up:

  Internal error: Oops - undefined instruction: 0 [#1] ARM
  PC is at hvc_dcc_check+0x50/0x8c
   hvc_dcc_check from hvc_dcc_console_init+0x18/0x48
   hvc_dcc_console_init from console_init+0x58/0x170
  Kernel panic - not syncing: Fatal exception

Restrict HVC_DCC to the CPUs where that encoding is valid: the
CPU_V6 || CPU_V6K || CPU_V7 set that arch/arm/include/debug/icedcc.S
guards it with, plus ARM64.

COMPILE_TEST keeps the driver buildable on the excluded cores, where
the p14 encodings still assemble.

Fixes: 16c63f8ea49c ("drivers: char: hvc: add arm JTAG DCC console support")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2: add COMPILE_TEST to keep arm build coverage, per Greg's comment

 drivers/tty/hvc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index c2a4e88b328f..51320f2f9a3f 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -79,7 +79,7 @@ config HVC_UDBG
 
 config HVC_DCC
 	bool "ARM JTAG DCC console"
-	depends on ARM || ARM64
+	depends on (ARM && (CPU_V6 || CPU_V6K || CPU_V7 || COMPILE_TEST)) || ARM64
 	select HVC_DRIVER
 	select SERIAL_CORE_CONSOLE
 	help
-- 
2.39.5 (Apple Git-154)

