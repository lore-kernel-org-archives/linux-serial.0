Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34130F927
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370773; cv=none; b=HB8khZRLYofniZ5CxZNBwcGVHI9qCMB0M+sZky5ipB4e4wH+szQ/y/FCadqeRg6tWpUen4u/9VOIT0N3UYLMG+hVXySUS4HapnkKorxrXIGCx28GZ3drGEbLBsDJHtvzDaaHrltoh814Lg/MQeb0WQo2Xc2l5DHuY0uZ56C1PCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370773; c=relaxed/simple;
	bh=7HAu9409XS2mSrrSyv0Alnlrsv+y0tOov9p9fjQcR0g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kafMtvUr2LQEaaG241adVRBZMPiw4Q4nYN9z6G8KYjkCclLwM+3Z965eNGo6XAqa0ptKTsyVCFh5P/E/i3FUcpR4fyxt4XRWvaVjn8/hN6656c9hsNwYNhFIyWoR6tDVnNhF3wF7WzXGHZwzHLEg9Jy7yVw5AVyqHhImzj9hbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBr3pA4W; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBr3pA4W"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d572f7437so5283239f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776370768; x=1776975568; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8nZc0xy0duswt5stMQc278vwujXUsWzZTQDCqL9tXM=;
        b=SBr3pA4WV/aglwfK7N06E2JiQAtYjbFBjNpzPXaxJ5AE1FtMiDDf3olCm4g73d6SaF
         eXt/5GAiZQNKccnhflbMboC/LnyvgLk2eZRnyTbZmBGkItN/KO9ok1pprBYYLvBW7k7t
         zwxybV8lMc2vTf72oeYvv8JMGzKXIFV/o0iW/UGXc5MH49xpYg0yOxYUfUde07Huqqb4
         VAf6bVJ7BGqPbYxhRmlUAlZF6JgQez8xVs3qXWoxj+Y0D46dCTr8SHFTBsYm0JUCqFQe
         lVtdrKn54uuN7rxH0PRgD4eXohlFw7jDSVDoSHKWmHmStsufJ1774UnCqlNWDYpjUgnq
         0xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370768; x=1776975568;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8nZc0xy0duswt5stMQc278vwujXUsWzZTQDCqL9tXM=;
        b=A6YxkPzwyzQTbLaYjwkNw/13Tl4i9MTUi47+IgLlHn899v6mr6j0Q5I8XCAOv4WPyP
         v5Vr+uGGmImFeVCz+RWzb/fFI9t/P8m7Ll64BeywHTFvTXelAESZbYbcpXH/dUlSSTHh
         xcUFGd2uI6Jg+btLzTLz0QcPb79pkxcmyLc5HQQfzoIKURhb+rfTilrKJcymttA34MZV
         Itltwynsd7UYgIGHy12T0Clc4NTrewy5935w5qG7H75r7H4emy6Ig8VZf6eX6j5wc8WP
         itdE1HJGh2tR9ewidd/o/g4WXIdGZEZnFhtvjijdk0zgbWpm1SithxQUQ8INyejWSSNu
         XlPw==
X-Forwarded-Encrypted: i=1; AFNElJ8zFXH9j3dcSlQ1UKq+6SCLN/d+dhnybGeXH4p6u3IUAw8M1TenfPO+rZvRSRJJTQBemcIG80PaB6O4+l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kZVjq/d/c7ySjueAntamyJ+ColfJnv8bUTHLJbG+Wn6UDzw0
	RY/j1n4bLiFxJAD8R4XJK6XGTJCq1ZxitA6gm0H6vJpaY6PYNyd6iRxQ
X-Gm-Gg: AeBDieuenp5DB6p52JksiB38+i8N/1AK7aW+RmoqfKQHJOJFyc7weuC/Mdyq8wSlm4W
	XTFB0HYEhxVchBV8B5EUwPvNAVlPlEl0UhAM0TNJc+SyhwSaKzb6bc3dzOR3d4l6cCK2oSZVlkx
	0bBDQ0KfGr/Xo70yQXB/H7rBNQX+VxLSMzC4lX82wneo8vaNyIVEQz2Q3LN6pRoj7bwUImXBpqU
	0awIiD/kqH6D7/8Him2e3ceUQEAT/F/ojRKPkI/3APcyXFg2zmLNZFs9/tTJ9/LUEBI8dBPwKWN
	h3qUVJsqoqILwObTJEK2iLHj74nKs+5+ANxcjjz+WiGfRDO43ZfeM+9vJtj5DtNdJOm+CP9w+o9
	2yhUZen8lTRDYKZ+C71W2ymJS6FpaPejjnrUTaRawnRfFnRuhK3+ejd8ZNYovqZd9cUc/6Z5Pwq
	SUGwS2kxwaXOXrTEhvrxZxCygCP9VHI9Wm2VJeUMLbsMCUvA==
X-Received: by 2002:a05:6000:22c3:b0:43d:3004:5fef with SMTP id ffacd0b85a97d-43fe0ea3667mr1302338f8f.7.1776370767968;
        Thu, 16 Apr 2026 13:19:27 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35c026sm16180624f8f.15.2026.04.16.13.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:19:27 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Subject: [PATCH v4 0/8] Add support for ZTE zx297520v3
Date: Thu, 16 Apr 2026 23:19:08 +0300
Message-Id: <20260416-send-v4-0-e19d02b944ec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADxE4WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3eLUvBRd02QDi1QDS9NU02RLJaDSgqLUtMwKsDHRsbW1APKUMK5
 WAAAA
X-Change-ID: 20260416-send-5c08e095e5c9
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 soc@lists.linux.dev, linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4069;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=7HAu9409XS2mSrrSyv0Alnlrsv+y0tOov9p9fjQcR0g=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp4URKrT6XMtZiyJrbaPR7qc/RFSCsMcn+h+B6/
 JgQ1+HrddiJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaeFEShsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiIu1BAAjlaJHP867qOApRxS4iItx61iEqXtDj6
 UDOM4lTZjUjVTnDxtQvhePQRk58NIRDpDCFcoGau64b1+E0H6+Rtt4V409u5suYtD3PFmK8LDHJ
 6jPtYooFJ+VIcqfylazdeVELYKHYapukRAmsft7FykhxLSoOAf7hzebqqC4ZBjhM6C3wvat8V68
 +bn4GJT11BYeFkZKfYaosuZ5W5ScLD8AiCJqNyEsrNfOXU2gm6nCT8hJoHhFd7xxJZtKBNySssv
 8r+7LC/jCTasqR/8uuA2s8uSly1LKJhJvqTIt2MGpFj+5rXyU9QYOa8ZeYewGje43HUSB31gcgm
 blVjAWzBLyurMsqIcQnEW8cQN0Gsls78sYyv9LFyreYHGd3HYNxFeA1KeEBvl08Az4VYvHxY6lX
 CXI0r/CsjWykTCKYoELJBaTCb7kvKbOMKeqBKEyyGsd/hUYy55oIfl8rkWhN6dhSws++b3S3qSj
 av75J8cYPxxxw0m3gMB1I1niwcjFvIJoc2kQiSVDZ8icrQTebOc2rZuAeMHH9ffQTuR2ojSwRuE
 dk5CZhW6WR5quSpi+M3RpJnzTKqWt4xlBpP+0o3On+XwtqfykvyE1dnWVBSr6rNNijmTSXE0JO4
 jrRfmJBlifeFvGqUnmxqQYMq/fsfymG5KG8qh3jOLOpLC/b+acD8=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

Hi,

This is a follow-up on my RFC patches from January [0] for ZTE's 
zx297520v3 chipset. This chipset is popular in cheap LTE-to-wifi routers 
sold in developing countries. My goal is to run OpenWRT on them. I made 
more progress in more work on this SoC and it is time to get serious 
about code review and upstreaming.

Since my version in January I managed to get more hardware running: SPI, 
I2C, PMIC with real time clock and voltage regulators, Watchdog. LTE is 
not working yet, but I am able to start the coprocessor that handles it 
and talk to it via mailbox + shared memory. Wifi is working on a few 
more devices. Since WiFi, USB and Ethernet are working, the devices can 
have actual use with OpenWRT even without LTE.

Another hacker created a free software program to talk to the USB loader 
[1] and boot U-Boot and Linux without modifying the on disk files. At 
the moment it needs a proprietary blob, so my documentation is 
emphasising booting with the on-device U-Boot.

This patchset here is mostly unmodified from the version I sent in 
January. It is the bare minimum to get an interactive shell working on 
the UART. Future patches can be found on my git repository [2] for those 
curious to peek ahead. The first 30 patches are in reasonable shape, but 
the further you go the more cleanup is necessary. I expect all of the 
patches go require a few rounds of feedback though.

My plan for upstreaming is largly this:

1) This bare minimum boot patchset
2) Add clock and pinctrl drivers
3) Add standard hardware to the device tree
4) Add zx29 specific drivers one by one: Watchdog, spi, i2c, DMA, PMIC, 
battery
5) SDIO backend for rtl8xxxu
6) rproc, mailbox and rpmsg

I am willing to maintain support for the SoC within reason. My patches 
add myself as maintainer. This is a hobby project for me though, keep 
that in mind if you want to ship a commercial product with these SoCs 
and upstreaming Linux.

Cheers,
Stefan

0: https://lists.infradead.org/pipermail/linux-arm-kernel/2026-January/1099306.html
1: https://github.com/zx297520v3-mainline/zx297520v3-loader
2: https://gitlab.com/stefandoesinger/zx297520-kernel/

Patch changelog:

v4: rename zx29.yaml to zte.yaml and add board enums
v3: Remove [RFC] tag, add defconfig
v2: checkpatch.pl fixes

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
Stefan Dösinger (8):
      ARM: zte: Add zx297520v3 platform support
      dt-bindings: arm: Add zx297520v3 board binding
      ARM: dts: Add D-Link DWR-932M support
      ARM: zte: Add support for zx29 low level debug
      ARM: dts: Add an armv7 timer for zx297520v3
      ARM: zte: Bring back zx29 UART support
      ARM: dts: Declare UART1 on zx297520v3 boards
      ARM: defconfig: Add a zx29 defconfig file

 Documentation/arch/arm/zte/zx297520v3.rst      | 158 +++++++++++++++++++++++++
 Documentation/devicetree/bindings/arm/zte.yaml |  25 ++++
 MAINTAINERS                                    |   6 +
 arch/arm/Kconfig                               |   2 +
 arch/arm/Kconfig.debug                         |  12 ++
 arch/arm/Makefile                              |   1 +
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/zte/Makefile                 |   3 +
 arch/arm/boot/dts/zte/dlink-dwr-932m.dts       |  21 ++++
 arch/arm/boot/dts/zte/zx297520v3.dtsi          |  83 +++++++++++++
 arch/arm/configs/zx29_defconfig                |  90 ++++++++++++++
 arch/arm/include/debug/pl01x.S                 |   7 ++
 arch/arm/mach-zte/Kconfig                      |  24 ++++
 arch/arm/mach-zte/Makefile                     |   2 +
 arch/arm/mach-zte/zx297520v3.c                 |  19 +++
 drivers/tty/serial/amba-pl011.c                |  37 ++++++
 include/linux/amba/bus.h                       |   6 +
 17 files changed, 497 insertions(+)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260416-send-5c08e095e5c9

Best regards,
-- 
Stefan Dösinger <stefandoesinger@gmail.com>

