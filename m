Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8552BE034
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258133; cv=none; b=V2hgoYCOfh6RZr2fFKbllFJDusjEP5potjZDvOVVBG9v2jh15gmgnrRSPr4KsBuUXtp950OKZoGiPpYbqcscaBA08BoPPBL2HLoPqUe7OTSoLJ6D9oTqlJcvszH7/ii1EP9OU430LeVzykEwinGaxZn8Zix3jMloHRlSOQlwOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258133; c=relaxed/simple;
	bh=IR+TmzD0ysZ78J6bQx6x1iu6Ze00HgqHkro6FF8QR4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=tAdih6uRHMLL75CPOtPtOLP4oXzLlf4k8tmv5Wt2sKX8kMRiAz5yj8G+XmLO2FIXmaB9FtZ5tkRBqOGwaTHuvr6RMoaX7ihv9Vi6knJyi2Y64LKS7A99JMCgdEh9Dyguh0H1xOoYSVG75rkkccoyL/gF8mUlFXPWal+YDWvPNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4L8AwoT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4L8AwoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768258131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CDN4F6qUleOsb4lA4R6ey6LptN7RZrVSPyp7G30h+N4=;
	b=a4L8AwoTMefBEreS8Nnn6IbpOk7rpVXhssyIoWY+mzTbX+CP5Zg2oKGlpvest9LJReYjdM
	4hjcUOzXsQUYk7csaDWdIDkHdbBuuZCeY/NyntM+Brk4DCIf27+uK5msZCStzRXWxqggr5
	9xTHGRHhjHMDNt3rXrwS3itDIg0xlCY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-n9ZIV0jJOx6gvggvIEC12A-1; Mon, 12 Jan 2026 17:48:48 -0500
X-MC-Unique: n9ZIV0jJOx6gvggvIEC12A-1
X-Mimecast-MFC-AGG-ID: n9ZIV0jJOx6gvggvIEC12A_1768258128
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b6a9c80038so744178885a.2
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 14:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258128; x=1768862928;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDN4F6qUleOsb4lA4R6ey6LptN7RZrVSPyp7G30h+N4=;
        b=pTwRu9ZF0MuLQQuH+hjKYvvmLIsR2/BwU5s2fjriJD7X6V2v4uTDf4voHht6oqpulu
         IPbsmU+HsIuo612jljuJlMU7wEWqOQR0/l/XxynNACCSaOllWHCAs4DfxM7ysbhqBc/3
         Z8PAE8TJrPN+fy4t7zYYwfEe5ohMwOyHhUyRF6bLzE+WX71Piq+NpAPRWxCwb+8ej0GZ
         lvkaH0ztc6ca55/XXzdQ0kwZLS3TNB0lf9Y6r8Ahq4S5dUNKEVDfAgM3uN6F7gTwKSPZ
         l01Oy3WPnBvhP/0u0GCwlqQ0uXmVHtci5sUwq0kxTw6S7iX3mEWcXslXXWDfK/7fQufS
         Ie/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaJqnpjs55iVkdaFhbGqqMXmvDhb3tVyrm9aXbDl6Ktik5HJRM0f/rxD4Qfwlbh54TTTAccyknnOxhfbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23fwuFHJXDbi7ISB80lrUoKO5dF8LbRXkR4ACsyEDnyKy3ctz
	0kq3g6GFdZNmCiG3EQRb+a1Z+GdKlsRjXreZnjJoO2jOQYZieBAsqKj6Ws1M8nnMbhN+1bPc+ct
	iVGqrHMkO5NUuWmgc/B4hJ9y34m5TAlbLhBlLqPNZiH61tl3fxQrJ+WSHWgMzyRcwJg==
X-Gm-Gg: AY/fxX4FhAOxeY/1PsQ9fLZfDJdu61meSCxOOOQw6/+oepyGtC3x9n/QTm9isubr1su
	rcIvio0NnWcBoicME6D86x53+m81S5ocJmLT+RFMgAwnh00LtoSRr1rykjOEi6LAEx0zno04eQo
	3HcHK0VQhViCNBdmUCMBg+IJ/6ubPrlR17rljyziFntkLYDhOEqokmz0cqewVhXcDN+gwUWsS3a
	b1oEHeJ7HVyYiu9rDy8DLW3v1X7PacNFV74u7MpCTTRMdABlyVJXRffbQP7CvsxdNE3MtLqzzMU
	ucobTJku+qre26xL4otEAV5om3eZcLVTFGFzdDZeiJgg5HTCzd0aqKg5aa3Gt3tNJnnxZi/cX/L
	uy5F+T7HyjmeC9k3+8YzCmE7S0kenz09eD6nYxaPzYosCDBodpA==
X-Received: by 2002:a05:620a:7006:b0:85d:aabb:47d4 with SMTP id af79cd13be357-8c38935623bmr2691046085a.6.1768258127764;
        Mon, 12 Jan 2026 14:48:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPWoMDwjxnx/GbtLVN9v7SkK/Oem+cPThs6QHS1OCzHbaG/d9S6MNcqujdu0QuZzSKVaAHBQ==
X-Received: by 2002:a05:620a:7006:b0:85d:aabb:47d4 with SMTP id af79cd13be357-8c38935623bmr2691042185a.6.1768258127283;
        Mon, 12 Jan 2026 14:48:47 -0800 (PST)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6145sm1580930385a.5.2026.01.12.14.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:48:46 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH v2 00/16] MIPS: move pic32.h header file from asm to
 platform_data
Date: Mon, 12 Jan 2026 17:47:54 -0500
Message-Id: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7ZhSUqCuvIdhMWlHOwsoaUmjI
 dzdygVcvpf893fInIQz3JodEhfJEpcK+tKAC7S8GMVXBq10r1plcZY14yqu0xiYPCecY2HsyVn
 bG6JBEdTxmvgp7zP8mCoHyVtMn/OntD/7N1laVGjtaKwzZhg7f0/sA21XF2eYjuP4Aujw+zW9A
 AAA
X-Change-ID: 20260109-mips-pic32-header-move-6ac9965aa70a
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
 Guenter Roeck <linux@roeck-us.net>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4095; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=IR+TmzD0ysZ78J6bQx6x1iu6Ze00HgqHkro6FF8QR4M=;
 b=kA0DAAoWt9LdJ11+wIcByyZiAGllekmh22P+k6CeusMIsB362YoldoNTBXKzHnQigMdhcoiqY
 Ih1BAAWCgAdFiEEpG0ycFhlqj3e3CkEt9LdJ11+wIcFAmllekkACgkQt9LdJ11+wIceKgD/SEAc
 bSRBT/Jj0eRj2tXH2aaKIXYIIMlFs1D6D5TiKGwBALz0AAkbBM0CbyCjIuHXQecAXPi/aSbVCNb
 /4zNda2QI
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gj92dbP62O2MniQ7PCKxK7rXtIylcNytSUsLsmzIOT0_1768258128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

There are currently some pic32 MIPS drivers that are in tree, and are
only configured to be compiled on the MIPS pic32 platform. There's a
risk of breaking some of these drivers when migrating drivers away from
legacy APIs. It happened to me with a pic32 clk driver.

Let's go ahead and move the pic32.h from the asm to the platform_data
include directory in the tree. This will make it easier, and cleaner to
enable COMPILE_TEST for some of these pic32 drivers. To do this requires
updating some includes, which I do at the beginning of this series.

This series was compile tested on a centos-stream-10 arm64 host in two
different configurations:

- native arm64 build with COMPILE_TEST (via make allmodconfig)
- MIPS cross compile on arm64 with:
      ARCH=mips CROSS_COMPILE=mips64-linux-gnu- make pic32mzda_defconfig

Note that there is a separate MIPS compile error in linux-next, and I
reported it at https://lore.kernel.org/all/aWVs2gVB418WiMVa@redhat.com/

I included a patch at the end that shows enabling COMPILE_TEST for a
pic32 clk driver.

Merge Strategy
==============
- Patches 1-15 can go through the MIPS tree.
- Patch 16 I can repost to Claudiu after patches 1-15 are in Linus's
  tree after the next merge window. There is a separate patch set that
  fixes a compiler error I unintentionally introduced via the clk tree.
  https://lore.kernel.org/linux-clk/CABx5tq+eOocJ41X-GSgkGy6S+s+Am1yCS099wqP695NtwALTmg@mail.gmail.com/T/

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes in v2:
- Fix native MIPS build by updating include files
- Link to v1: https://lore.kernel.org/r/20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com

---
Brian Masney (16):
      MIPS: pic32: include linux/io.h header on several files
      MIPS: pic32: include linux/types.h on pic32.h
      MIPS: pic32: drop unused include linux/io.h from pic32.h
      MIPS: copy pic32.h header file from asm/mach-pic32/ to include/platform-data/
      MAINTAINERS: add include/linux/platform_data/pic32.h to MIPS entry
      MIPS: update include to use pic32.h from platform_data
      clk: microchip: core: update include to use pic32.h from platform_data
      irqchip/irq-pic32-evic: update include to use pic32.h from platform_data
      mmc: sdhci-pic32: update include to use pic32.h from platform_data
      pinctrl: pic32: update include to use pic32.h from platform_data
      rtc: pic32: update include to use pic32.h from platform_data
      serial: pic32_uart: update include to use pic32.h from platform_data
      watchdog: pic32-dmt: update include to use pic32.h from platform_data
      watchdog: pic32-wdt: update include to use pic32.h from platform_data
      MIPS: drop unused pic32.h header
      clk: microchip: core: allow driver to be compiled with COMPILE_TEST

 MAINTAINERS                                             |  1 +
 arch/mips/pic32/common/reset.c                          |  3 ++-
 arch/mips/pic32/pic32mzda/config.c                      |  3 +--
 arch/mips/pic32/pic32mzda/early_clk.c                   |  3 ++-
 arch/mips/pic32/pic32mzda/early_console.c               |  3 ++-
 drivers/clk/microchip/Kconfig                           |  2 +-
 drivers/clk/microchip/clk-core.c                        |  6 +++++-
 drivers/irqchip/irq-pic32-evic.c                        |  2 +-
 drivers/mmc/host/sdhci-pic32.c                          |  2 +-
 drivers/pinctrl/pinctrl-pic32.c                         |  3 +--
 drivers/rtc/rtc-pic32.c                                 |  3 +--
 drivers/tty/serial/pic32_uart.c                         |  3 +--
 drivers/watchdog/pic32-dmt.c                            |  3 +--
 drivers/watchdog/pic32-wdt.c                            |  3 +--
 .../mach-pic32 => include/linux/platform_data}/pic32.h  | 17 ++++++++++-------
 15 files changed, 31 insertions(+), 26 deletions(-)
---
base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
change-id: 20260109-mips-pic32-header-move-6ac9965aa70a

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

