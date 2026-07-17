Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8922301
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272587; cv=none; b=VirFV4hfJ2zr+HbazETHqCBDjvl9HFSXlRV0P4bJqAcW9RzPprEuDOYxWBs481KFRAUe3o6Pi40oyBKEMPYIdXOrTMqC1iVZsOfSwx4s6P+cPYnT+xF99jfrbLdbg0mEIsr1A0ltkmWjuLNd/BgNw/+5v0seHX+Zua1QYbcwLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272587; c=relaxed/simple;
	bh=fcjBT/w9JzL9ABJ0LLwmom8IDXXr0yiX6kOkAhdelVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eEAnCA4k7bgdNUK+RgF/tvf+S4fjk53yYR2Wtav4oDmz49/BStrKfgXgOvlk9Po31uV668kO0DYBMK6R94poMrcjDiWsLDigbnRlneRrhe/RizSfJFUI3//jc99+5LuEVB5Mw6lKkzzTN14zqdoATiVjhh4sAmNg3l5fM6orkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwyOffWQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwyOffWQ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so2911281f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784272584; x=1784877384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z7B2/UyciMgdTUi/MjWg/q4S3SwELAi8KcQQY6ik/Mg=;
        b=OwyOffWQN1weSVbnpRc2jrAWKSWXqIDLcoLFDHpMCNNiqWER3D4UuBF1184xz6F9T2
         Q+nGRr44g/S5xvIeNlqB9Focj8jkM6mtdDJIWWn575tIxAZ6iKOrU4P4O3NlV6e3y5yV
         1Dgxt4EpcMNVTp8glgsjEch2TDqFWor69vvMLLPFYliOHUiav2RJcx7//VDL+MMW6CSQ
         eSnT0Vl5iXqmhg8MydGZ4pQNpGXvokxHCV69N97fEeI5oLwshJYrFdV8Z/QKPyn99TTe
         w2sh8nQSd+0pEiZSkuz+iCYK8Rk9UPCzlumXm95z/46Py1Fdx8pSE1GNVDKdjL1rj7EP
         dfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784272584; x=1784877384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7B2/UyciMgdTUi/MjWg/q4S3SwELAi8KcQQY6ik/Mg=;
        b=iftZ7Q2WffmgJPHZieJmtwex+RSUIEXqqbeUGFVuZJ05RBcq0fp2uWFJBUw2bqL6lW
         SYG+k4OxjfPbJQkn+gCgzHmLZixlwysLTWZqzLcIzVPm5O1ZryF0xQRnU+9VD+41+f5H
         sGRW7+McK5FBWg/0aAK/9TXOwiBrAY+HyOy8TShufHNaoWgmZpGQFdpUAQMpkOkh4xqZ
         LhW4CnazKyhdDu8vSY32DFCfHi1lFBfU96S/vpVPCz3hENQS/I+ZQtmoGy8dmc2A2/7G
         tB4ESrhh0vovSnKbt2d90OUWJJxftoKbSpyJId3PglCfkajMj/bv6HHMUVH0msJVz4LX
         e6ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYgGXebbAhnaSose207QgETZggPsBmZ+he10pDXXRz+PG5kkCVa3zZSC1PeS3Tq2wen6v0djCK2NXYB0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGLG9T4rmHBLIFqHjtOD+H9emshg7YUe0IyHbsYEIfzKWA5iy
	XokPWtEaz3BSProFQaV8rpcuZ77st9Wfo+U8562ZyPv1rKT/TAp6p2Hp
X-Gm-Gg: AfdE7cm82RezOiXcIJccV5x+N8JZkD+jbGW8MpnpmhPIwb4+vWyCKn5sa/3ul/2AtL0
	j/1AB1sS4k3trn+DbVkRA/vqfaX8WkVnslc5qha9H1tWFgvYAq08nm5GV+ekwTSOLXLeUOvXzdU
	jsrgMUdbhkHLO0A/9xoLzN1gfW3KaVaAQlYAZKrqCKYT2hVF06ofAs0KwzMinxa2k+iavICArmB
	uYKiIDYo0NcRDPKfPLzIsAuizBWWYRspV/OFLZKhFCg4gJiAHPwlt3i+0RB0h0u3PgvwZJi4Acv
	LBPIB/TsX1fpr6qH2YU9T5VI6w4A0pQQxGHvnWj4CESNxH/2xz1K7qlmmvFhrkcPORox47ezQsx
	diJjVWG9DlKOqWJGEqSH9Fi8Xykotys5ZkQxsNPE804T/FX7hOghKM7yvuqoSPQ1wy7tzoFDwbF
	kw/MseYlzZACPJipM3UzFV8CRMIWfv9O1HNM0Au0a3l9YexwjrQljiKKGoUkiOu6YMkH4m8VYDW
	ZCacFbURgteCanyoZuGBwUVunqW14SSJxMEOp4BG3hwqY074URx8qnHo36pPcuNmJ80kcErLTtt
	7Wp6jwLTnA==
X-Received: by 2002:a5d:5e06:0:b0:47d:e9eb:743d with SMTP id ffacd0b85a97d-47f623388f5mr1845851f8f.57.1784272584036;
        Fri, 17 Jul 2026 00:16:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a56c-5c01-55c4-777b-77ab-69e3.310.pool.telefonica.de. [2a02:3100:a56c:5c01:55c4:777b:77ab:69e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm1377430f8f.10.2026.07.17.00.16.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 00:16:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH] tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
Date: Fri, 17 Jul 2026 09:16:16 +0200
Message-Id: <20260717071616.91423-1-kmehltretter@gmail.com>
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

Fixes: 16c63f8ea49c ("drivers: char: hvc: add arm JTAG DCC console support")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/hvc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index c2a4e88b328f..5866195de26a 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -79,7 +79,7 @@ config HVC_UDBG
 
 config HVC_DCC
 	bool "ARM JTAG DCC console"
-	depends on ARM || ARM64
+	depends on (ARM && (CPU_V6 || CPU_V6K || CPU_V7)) || ARM64
 	select HVC_DRIVER
 	select SERIAL_CORE_CONSOLE
 	help
-- 
2.39.5 (Apple Git-154)

