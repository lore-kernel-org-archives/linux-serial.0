Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F9423177
	for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2026 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490046; cv=none; b=BUvVQf8TbM7dUrobkusOAUz64D0ywafCQej4OLH2q78rRUPBbwbKRDOxixz7C7qqKZ4nvw5gsR/LzQeH0TmX3HvETe/zLkdM/eKRW57FwgxT8LCB0weAv/4cXDwchGmLXUV4XOtPeTp4JyXhLs89iDTI1Np3rh/cAhUs0n66Vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490046; c=relaxed/simple;
	bh=t5k3po+A4cuSA2YIZhcJJigylx7p9W5bSmm5u0NQ+Cw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bgzzLAdvEuctc2T4/U41THlM1sV7rDEORPWsj43OJrUZTWyGQMv/go9DqHnVzu8FdwrqzAQH4zEDPFcXuhFiulU+5R66KkKqt2HjRYGJ102V1d7vwBrhbKHRnu3FgZNhwx7xhzRHA6Mq67x1eV12z7varGGo7TvX3gPPfrfdapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spCk5MH4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spCk5MH4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so799105e9.2
        for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2026 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777490043; x=1778094843; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4YPN2a1724ERpeTq05iIb6Sk6BGrlz93FpHuJBlSq8=;
        b=spCk5MH4jdBuapJkvfcCuWGUx57/oOJfEPlJE35G9/uFo01wF+yPMZC2xMYqyy2To/
         OBnHe+u87CF376YeIYt+H8mHO2QUcwLRcbgcILJ7K36K8hcQP8/cbwV6YFaxBvWSMduC
         OVuTJJnqRhE4criStNYmNoXaM3EsirnK0UYx9WIO1CSFeOeUqor00ZHc03lHAQFfH39j
         lNtPmu2t9zZvWVlpVaEZ/aS46bDbQr9bSAr/IUJXnUrz3InrNw2FN5ScITvu2wGQNXZs
         YvBttQ2HVWJ0iDufpru9q+8LOW4hwhBO5RXIRf/VTdk3VVTa01WJSKyIhSNzE+NmrCTq
         loWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777490043; x=1778094843;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4YPN2a1724ERpeTq05iIb6Sk6BGrlz93FpHuJBlSq8=;
        b=c+QJrbjTButIctQmyiuXote4eblJ1QxEkVOERij7wLaIvquPR3Ht7nUeJcZ1nGvNT2
         Bj7bGlaz4evgpnXDlOaRgnJOL/yhDJubSUxmGOVywICTrBUKCThRuyp0vudq5RvVsdes
         wo/TSsKAYFtMPrOU7sy53R6zpN89eZ59c1vgx7oTqXiQX8Pe12v09xEH+oYD3EJcyc8q
         P+69SGBXSAQ5HF/1xEanpgUnhAtGVSoQAhhOQpPj3xtkOyZlkSbxF7awxAeIJGTURyaK
         us/owLsJrdQf8bo0v2CVWKYDywYKxYf44SMi/ra1X1DxrnXglCjwUlLKZvUv321QOwUB
         Fj0w==
X-Forwarded-Encrypted: i=1; AFNElJ+o7OCGqBgm2E1sMKVX3sPtNiqLV8poDIV7BrPyLaijorpEPiz7OHzCZklvEWNbBYiPtf9JaHaeAdXlHrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzexffplPe23i5QQMwDRpkJzh156dwKeVaoElatwCTbllnMFJCX
	nRU2jNl6Z2ZuthXO4IA2aHx5RLNkkdWviZL/XhCi4yHTtE1QqV6KU/ZX
X-Gm-Gg: AeBDietO6MxbKxs85QhGDQ2iHtssFMrMmjB10NZhNlCXPS0h+FCJrHurAPYvu1Li/N2
	eauz1bF+ydEzx9P1op6ugfz8hx2fFBgYmb6rJ1U34PRionw3fSsagS+hosk7mKcWRCUz+C3LMJE
	SNKEbN8a/QlDvGjbcct6YINT1AEsPYbV4dGsf3zW79oS79rRiT74EGV+ZEDZb0KOgMveI+mAzpM
	M/X51asktiwZNlog3GZ5SYA6zwY1abvLelxPx28eI79sOBJoYXro+lMmsdzMtIIuKFGMLiCXMVd
	CnVi2cOXGPINpHgDL7OSANluf7V+zE1W+WctAxF/ai+n31l/xIb6VgGJdkTnV3LJsxct+2RYwGc
	gLV2NGg48HaAAeVlyxswxQ5YeD3mpk3nBZbuEQI9gY0+Tx9pLxntHjJivIhQ1rvlyjchhA/vUrN
	P77AF+4zL1y81SoIBVaL4CajNS6OCML0j8rLIY6YSiFq8=
X-Received: by 2002:a05:600c:528d:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48a7b546b7dmr93117815e9.24.1777490043058;
        Wed, 29 Apr 2026 12:14:03 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c316d7esm23315005e9.24.2026.04.29.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:14:02 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Subject: [PATCH v7 0/6] Add support for ZTE zx297520v3
Date: Wed, 29 Apr 2026 22:13:11 +0300
Message-Id: <20260429-send-v7-0-b432e00d2db8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEdY8mkC/13N0QqDIBTG8VcJr+c4mlruau8xdmF6KmHV0CEb0
 bvPYoPo8jv4+zuTiMFjJJdiJgGTj34a86hOBbG9GTuk3uVNOHAFgikacXRUWqgRtERpNclPnwF
 b/94yt3vevY+vKXy2ahLr9RBIggJFph3wRguB9toNxj/OdhrIGkhyhzj7IZmRsQhljaqUTB6R2
 qP/TyojJzS2puJNA3qPlmX5Au3xbZUCAQAA
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
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4820;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=t5k3po+A4cuSA2YIZhcJJigylx7p9W5bSmm5u0NQ+Cw=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp8lhvyzAaWRv3CHmoM3cqn8kYjaOUR7FHRYCRn
 nzhcNhgreSJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCafJYbxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiKJMQ//WPAwdy4kKKxkQcYfsF2g/x7pkl+ujmg
 qFJHkbWSz7P/SDMYH9diyoX56Cyljvt3n7tzX+wnJBHM2scfszzNo4odcWtiOOGi8zymKnvo3V3
 Gc9OZRM+d8XI3/+mCOZXGHCO4s3D4+37J+Cjw35Y3RbMU4R0NnBFsUOdpl5zEoheV/Zs6QPjd/L
 alXQtCdqkGZsXvfze9L69t3Ln6YnPiv8zXiVFoCXQbI98JX955jw8BRrQJR6ixxqYu7oU6/G+3J
 JoINggCygb/JzuYWpmEyQIRNRPVOBXXDCiogMRpBdBfIdu2tap4FHcH6nbF12usC3q8+BBqJgDP
 kfIm3/zLnRyGfpaFgDkkEmQgdBeroW2eaMrYgjTGqAD4Hn21dRHI9D/UgSt+1w1JOGm21ODqNDe
 jxcCr1jx+JLIhFDh8d76I2K0/R+HqmA09UrCcnhjg8eVwRmmfHF+dDKkmZqZrHaXoTwMc98EuoK
 SLmQ2W3ki2AuvP1YUGzdnDn75t0qA5pTKZlyhgTVc0D6qTt1oAVL+72hQxgQgAoJ8vnb7mHMTA8
 6kYW1UyxOmrssAvfAQyvRho4qAgpOa98eD35PTSfh8sFpyaqyYqHNva5FuQQXIZDKh7RUJ7VR/a
 Oq8/lb3MpIcBTRwlGoXxZ4pfJFw76UK4bLUmQh2xVDIafUfXXecs=
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
Changes in v7:
Fix line order in mach-zte/Kconfig
Use "zx297520v3 SoC" as the option name for CONFIG_SOC_ZX297520V3

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

