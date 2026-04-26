Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07B327204
	for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204487; cv=none; b=POrvJXYwe1kGdDKb3SdrzLB1ayib0JEDwuTEwbei9WqjBeYPH6NmFak0v9yfN6WQZdItGPWTM8t339wobSTFKSnmx9vTvWQbwE9dvDGIC8dqjAGFuMm0H6GD3XU3j1UtGS5ZYxylvCganT1i83UdPLkue+obArbTjzuMVjwthfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204487; c=relaxed/simple;
	bh=177MnobEW4AW8zxVOoT5YiyKBdemluGYegbd8Mp3tz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nyoJ9OD0OK1DIeSeTdu44UIp/2+IchdV1Caes092WA8jZaqB+XxHxZMl2W88v6xEPRD6ExC27EQfcUliBcyhQr1RjLwwSmZTAiyrzqcbhMN3Uefp63uPehauIH8qUS0+/IxzzOypsYdlFI5yz2QqNQXKGkXuu8LCwNAdl9lTYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm69J2k/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm69J2k/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso97387745e9.1
        for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777204484; x=1777809284; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Izl2nx9ZI1GiQgBb28dSYIy+N6GwTm8NILzzFVKNNVo=;
        b=Jm69J2k/bmobPQHrve652/+Gy5PTAYWrtj1HAeMIPSV7oQz1Jk9EI5IdMGBD8zbAZy
         0dBVx4NhLHJGD/AAJl347tf0ueDyzEZnb9UEamQxd4ynBR+nvlDp3X2GBZCJ4+ugU/em
         wXB3Tgmpx5ukK1ijcdOl+WGtKAsEXXaC8xCSzLJYIFN9w21z0yiEfw3K9LxcISzVgTqL
         JV+jRUfal6o4Z/CMEfIlAs/TXLUG7jv3xfhVb8HCLWT7IOC0Y1SeX0+RctjDRQLhOItf
         I4e+D2lUi9zR5iC8AT6sSZKMrhzHaWEtgNtWInQwwRtMcNRhkQc2gQZReE1M0zsF0jRY
         lMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777204484; x=1777809284;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izl2nx9ZI1GiQgBb28dSYIy+N6GwTm8NILzzFVKNNVo=;
        b=rebeIhk45NBgweyGFc7B/OS4ptD9AUYnIJeUV7V6ZChLWgho+QGtjc6uQ5lJzw4GGm
         c642WnmO5oIiKetFqY2/TBZZkvttbzM9yAAYv3ygHUzUq9n5nL4ZAwrRZpjZrchz0UPd
         TXQXhHRsAZ1p03vxpqYvmx4nIrO7I7ng755Bhq4uIAQa7ukNBQgRjfvnDYDhYXbi5I09
         redA4AnTUNqJRp58fIh8DSU1aYB7mecJ9uu7xV89+NDgQRL/3ycmPIGI/lBpfs45E2c2
         MR0eM1Rm4LA+9QAIgbdBAaI0YTCcfEcaIJGUIvYbWUUWEpBTuz6ws/kZzDIb8KmS2kup
         Ayag==
X-Forwarded-Encrypted: i=1; AFNElJ9fMFeCPPrh8tDdADQyg9qNys0okVZcnpmBXDT15mNFjO5w6+Iud+RPhhGghdCpvSftM2ntG4dPaqophhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyoN3RDN5Ap1vn3yD11A7Wdun10SU8Rb4aZji28ApS1iudf+e
	wyvBYyo7/sJ8+qjXtQMw0sNf6IskIUG4NrrBU2cqZFgvjr4VkmmXzD8o
X-Gm-Gg: AeBDiesraKRid3oPZ1vGiPN0hg1M1pvzS91HenycoTsGBmcjHNdl1NhuHlbUGs/4iwP
	v2WKLZ7XMQqsYI3MDp5aW48qAMVE+dChacIJ2/ob/7GhtXAnNgdISoIkxeNyAepPoPxzYioMm3G
	Ew3B0ugts/MswqjOvIvL7HaMNEHBfhQCtpDqtTGppCY712HwUUcZpf4rf8t/yHRrut/sbZD36pB
	DVdy79EqV9NZA1DasisjmMsu3plfXIFVgypEf5iEBEfpb0HC4QFQYKzZ9ZGgSvFudFlOsNt+jU8
	Zk8aSVvip3zJBTsuBEfrCll8zzjW0lIiw9wWv26K5y/zhcRbqVKYxn7nuJUEh/VmTHQ3vMYe/O1
	sg29FM+/b3aAmcF8rvBMeBHu5Ivi4QK3egAvb0HTNjfm7yp+OdMrScLfUB5340DSe4dUlTByQZO
	9BzpE//zC2NNr6R5i1uR8n7M6strXLrsw+AUJHvon9O07pP9yMcIw=
X-Received: by 2002:a05:600c:1f83:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-488fb787afemr547647045e9.24.1777204483792;
        Sun, 26 Apr 2026 04:54:43 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm424018575e9.0.2026.04.26.04.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:54:43 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Subject: [PATCH v6 0/6] Add support for ZTE zx297520v3
Date: Sun, 26 Apr 2026 14:54:13 +0300
Message-Id: <20260426-send-v6-0-d49efa72bb09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOX87WkC/12MQQ6CMBBFr0Jmbc20tA115T2MC2xHmETAtKbRE
 O5uIS6Iy/fz35shUWRKcKpmiJQ58TQWsIcKfN+OHQkOhUGhsqilFYnGIIzHhtAZMt5BuT4j3fm
 9ZS7Xwj2n1xQ/WzXrdf0LZC1QkHQB1c1pTf7cDS0/jn4aYA1ks5OU/EmmSK0nrBuytZFmLy3L8
 gX2YWVzzQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4719;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=177MnobEW4AW8zxVOoT5YiyKBdemluGYegbd8Mp3tz8=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp7fz+zJK87ZzFTWeE6ZPEmJKpc5rt9HdkrkwJn
 cKb/Epf+nWJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCae38/hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiI6HQ//V2CFvqcKUo8t2sbKt1+Udb0dTFGutWw
 6qPFskqk9n9FU5I46MswNt0vr/xH5AzLBcs0aY9ECAf7La1JBKkrMmi1byZfW0uIP+6EJSVNIik
 PvOE8inm72tdmMbIUvIgVNBgbzRKmiLOQnd6owWDm9EeCcDI1BoBYl4Nxg/RWXcxLtZn099Ffle
 Yj1Obf8hPu25jrcIyN2IqvtAZ9YDIP/WpO3WPE9YqZvpCyrUwdyE4ebrdreAStgLVqE/SnNbKp8
 iBGLGoywv18GWY1dSmW/ElT1DvISt3XKa2cYap67qYC5UCak0AXL+++0bk5ci1LD9tFjVPE4JvW
 +sRQfQZ2MJFy8/3X4611CtOWNyIIBdN6PJUclj/Vr7Q4CqMrMO/3JHmx7YoecdhiuAug0inyum9
 iG13sUBMbQ5OyxLeElvUOTGuZpKQeBUIbSulpMzP+t9pvY2la2PbM8e5Zed82ea0vkITq19ymHg
 M7sAulSk+4OiEDyhq0LrW2iHLmdnttFKXGGk+TA/IgBTLXwoHmm8svZrRdiphyMfs+i7dy7Zy01
 hhRM+j2dT0qWnPYDdzVcFZF7x0vEhkC0h05wt9PRwltat7Q+zhfI8J8/ZUq6xyWvt9GNqVSlv+L
 YeQoRyHXOWIllF3vBTgU1J7Pns/Gnn83bQCO/PmkJHb9wvVvgtGg=
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

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
Patch changelog:

Changes in v6:
Squashed DT commits into one
Removed for-now unused board DT bindings
Add "zte" to DT patch subject
Regenerate the defconfig with make savedefconfig
- Link to v5: https://lore.kernel.org/r/20260421-send-v5-0-ace038e63515@gmail.com

v5:
Spelling fixes
Renamed dlink-dwr-932m.dts to zx297520v3-dlink-dwr932m.dts
DT binding indentation fixes
Use a manufacturer 0x8b for the UART, fix patch prefix
Declare all UARTs, remove uart aliases for now
Consistent license declarations. I made every new file except the DT 
binding GPL-2.0-only but I don't particularly mind GPL-2.0-or-later 
either.
- Link to v4: https://lore.kernel.org/r/20260416-send-v4-0-e19d02b944ec@gmail.com

v4: rename zx29.yaml to zte.yaml and add board enums
v3: Remove [RFC] tag, add defconfig
v2: checkpatch.pl fixes

---
Stefan Dösinger (6):
      dt-bindings: arm: zte: Add D-Link DWR932M board based on zx297520v3 SoC
      ARM: zte: Add zx297520v3 platform support
      ARM: zte: Add support for zx29 low level debug
      amba/serial: amba-pl011: Bring back zx29 UART support
      ARM: dts: zte: Add D-Link DWR-932M support
      ARM: zte: defconfig: Add a zx29 defconfig file

 Documentation/arch/arm/zte/zx297520v3.rst          | 158 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/zte.yaml     |  26 ++++
 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  12 ++
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/zte/Makefile                     |   3 +
 arch/arm/boot/dts/zte/zx297520v3-dlink-dwr932m.dts |  22 +++
 arch/arm/boot/dts/zte/zx297520v3.dtsi              | 103 ++++++++++++++
 arch/arm/configs/zx29_defconfig                    |  54 +++++++
 arch/arm/include/debug/pl01x.S                     |   7 +
 arch/arm/mach-zte/Kconfig                          |  26 ++++
 arch/arm/mach-zte/Makefile                         |   2 +
 arch/arm/mach-zte/zx297520v3.c                     |  19 +++
 drivers/tty/serial/amba-pl011.c                    |  42 ++++++
 16 files changed, 485 insertions(+)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260416-send-5c08e095e5c9

Best regards,
-- 
Stefan Dösinger <stefandoesinger@gmail.com>

