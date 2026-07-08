Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4057439354
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525107; cv=none; b=HBkCyqazlE6O/ycygWsBxhi/hjyv8McKKmpsNs51J90q1bvhLinrHR6QV5EMXtKivekw/EJjfww9DVUqHJRDX6As7JM06CH9MLUtiRm+yNKRgYO1sAudFxSWpWkNDo/c5xyBkvcTVOL69s0KFkGPTqnKDnEhdDg1HBmr2eJVr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525107; c=relaxed/simple;
	bh=rZwb5msXLDO0ijxU1KD3LNPVM3/IbyHTEZVytr4lgfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PzjRrjasjrVy6xMVaRX+ybYUVH+ArIh7zt1oINKoBj+YFCOJA+KukAElfPU1zE6AFqHcL4oENPycMd+aauZ3Fj4W9Em5X5pYYLoLoPGQKU/HNS0Bch1VbV8wvpOpblIl3pL0L/MXVxEMbEC7qBv+9gtUl3HhAjOH0lD+STk7vOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=E+pSZqPf; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="E+pSZqPf"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-493af9b574cso2409385e9.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525103; x=1784129903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6E2M/OW82zq935Lg7IK8OFbhLBXo8GmRMpNDGq8g+oA=;
        b=E+pSZqPfFqo8XnZPryNcXJ7Q92gGxst3VQISbHy9IwmCPfvjqZtHH0SULct7kGBLO3
         893TNvNUZVN2Z7TsjZb7EU9PEKuk8RE2ojKVIrW8W+teuacZoANps2WBA+Y7BzycJs7X
         XBRWwbOvuVj5z9/FwXa+ak01sBDAeOxeV96BZyTGgrs4V6IhZTkb4yrQ7pUuONQI3Xt9
         tTsuiu4LXSBzR7Ofa71WOvQ4VxFCCEPooIZ72W0kyobKD5Rew2zHt1pHLXxq+xR0Z67g
         ggFClrfdiN+/UbsSryEuZckMlnJZNxjoD+BG/esa5APiDI0/0PXC0XtxVMoIqFn5GVqB
         EUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525103; x=1784129903;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6E2M/OW82zq935Lg7IK8OFbhLBXo8GmRMpNDGq8g+oA=;
        b=ioT8DClxk9Mch7Jkpgi4VvllTMskGxryJxEyrqv6MClT2pnSIjs0BiTsbK3wUYurdc
         zhTyHL+NXo7phQ7GrlR7XrFNee7ghuAvoZHXUb87TYUvMPazMrStaw7NWDPaGgRsLuLq
         WCKVr38xR8+Jy8f52xczFvMJNN4qUoElawuLqSeqUIXiqPm3sfnoGGaO7SHhrK4WvEXr
         36OHtgHhgGFGfRLqSTPnooof3vPwGfRMcnFFidHnt3JF7PU8V3PcAejsD9kgrdcHyaYf
         469x1BWY5R2KPLUdUbV0Qv1xhiL07pM3eVDZLQ3pegpm0i+jnlBlmtC8AAILHrWcLMRT
         Om8g==
X-Forwarded-Encrypted: i=1; AHgh+RqvgqOiurhsC89dLis0YUN3fZqosImFuUBLGrRPGg52Qn3YeLSPl4RlJsWBcZOeTPrYUtHgshpTKTT0QrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeK7oBmoCxLxQbamHZ1cWxRp+DEPb5ZfJffZUWgXDplr78ODs
	qNq2ollgejzCiw+6LiDFsC01NwU3Us8AtmrtUfuOhzZT78W3F5imetJ3QKmunGO8QKk=
X-Gm-Gg: AfdE7cllNlVOczu8sRVmWUt+izjAqk8EVK6seAXi0S/FglkylPgNc32R3/C6O8qBQKG
	U0GS5eeQPLlN8UEwvLaldkIBh8d76YhyNAaQmE8GbIIjlOrZjD8+MHfoSQkZcK6di6uIJ9L0/sN
	isGThbvCiehTd5hJEYrZ+K+pk0HUqwRRU9WAg83KusZ3NRggHuwjZRymEosErRSknzvBXIgrQRR
	ke/zc2dKAUBSlx9mJRe1K7vXUctI7/0dzuWfVteRO/bKucl8gyStjK9jv/624/yo9W0xgd6QHmM
	Yw7gitb+aQTl/cl/qerZL3pS8ZvuD8svOaWzcdyPsjr99PEYvg07CwMQDm7dT0oJQP9Dv9ccULe
	I+jlX667VeODp08Ar9Kqhskdbo622/lWRFRVSkUuUKIl0PDYz3McnRVIU5A9gudlBJE5aKkWTF7
	YaWLeLoMM5Cag7GJPLl+htumkaTityClvOXPNLClTGiuHUMqtQmCKPNaRE+BiTnIxMm1hB2hkBP
	iCvslj7DDLAnMf7HTKBaDkgdzd0
X-Received: by 2002:a05:6000:1ac5:b0:45e:f302:95b with SMTP id ffacd0b85a97d-47df078ba55mr3258189f8f.37.1783525103272;
        Wed, 08 Jul 2026 08:38:23 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:22 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 0/7] soc: aspeed: Add BMC and host driver for PCIe BMC device
Date: Wed,  8 Jul 2026 15:35:52 +0000
Message-ID: <cover.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a v4 for upstreaming the VUART over PCIe BMC device driver.
The initial driver is from the ASPEED kernel SDK (master-v6.18) [1].

There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe.

The virtual UART is an 8250-compatible register set.
On the AST2600, two VUARTs can be exposed over PCI via the PCI BMC device.

The host cannot access the BMC's memory. Only the exposed features are
accessible. These are the KCS4 channel and 2 VUARTs. There is also some
mailbox register functionality for a communication between
the host and the BMC. More information can be found here [2].

The v3 and this v4 mainly modifies the BMC driver and focuses on VUART.
The BMC driver is now incorporated into the '8250_aspeed_vuart' driver.
A specific flag can be set to indicate that the VUART should be used
over PCI. Several changes have been made to the 8250 device tree binding
and the 'aspeed-g6.dtsi'.

This v4 serves as a resend of the v3 while applying Krzysztof's review.

Changes since v3 [3]:
- Add the aspeed,ast2600-vuart compatible entry to the '8250' DT binding
- Add the aspeed,ast2600-vuart compatible property in 'aspeed-g6.dtsi'
- Add the aspeed,vuart-over-pci boolean property to the '8250' DT binding,
  only for the aspeed,ast2600-vuart
- Add the syscon phandle property required for aspeed,vuart-over-pci.
- Add the aspeed,vuart-over-pci flag and syscon phandle to the vuart3 and vuart4
- Cleanup the VUART over PCI code in the '8250_aspeed_vuart' driver.
- Further cleanup of the host side driver.

The host-side driver is still in /soc/aspeed/, as it is very specific to
this SoC for me. I didn't receive any feedback on where to put this
driver. I can, of course, change this to the relevant location.

It's important to consider that the host driver will do multiple
functions. The AST2600 also supports LPC over PCI, with a specific KCS
channel (KCS4). This driver should also be used to enable the IPMI
automatically via this KCS channel. The UART and the IPMI will depend on
the same PCI resource (BAR1), so this must be configured in one driver.

As with v3, VUART data flow and MSI interrupts have been verified
working on the test hardware.

Tested on:
BMC:
- Asus IPMI Kommando Card R1.01, AST2600 A3.
- OpenBMC
Host:
- Linux kernel v7.0.0

This series only supports AST2600; the AST2700 is not supported.

Same as v3, I would like to know whether I should add the 'lpc-io-reg' and
'lpc-interrupt' values to the vuart3 and vuart4 nodes directly in the
'aspeed-g6.dtsi'. The host driver is not capable of finding the vuart
address on its own, so they are hardcoded to 0x3f8 and 0x2f8. It will
not work with other addresses, so perhaps they should be in the .dtsi to
ensure the correct configuration for the 2 vuart over PCI.

For the interrupt number, my test is working with interrupt = 0
for vuart3 and interrupt = 1 for vuart4. I don't fully understand how
the silicon routes MSI numbers to the VUART but the following
combination is working :
       | host MSI idx | BMC lpc-interrupts |
VUART3 |      16      |       0            |
VUART4 |      17      |       1            |

The original ASPEED driver used MSI index 15 for the VUART4.
I tested every lpc-interrupts on the BMC from 0 to 15, but none of them
worked with the host MSI index set to 15.

For me, the silicon only routes the MSI index 16 to VUART3 and 17 to
VUART4, and the lpc-interrupt needs to match the 4 least significant bits.
I might be wrong on this explanation but the data path is working with
those numbers. There is no explanation for any of this in the datasheet.

[1]: https://github.com/AspeedTech-BMC/linux/tree/aspeed-master-v6.18/drivers/soc/aspeed
[2]: https://lore.kernel.org/linux-aspeed/CAFi2wKYOAotiezepDqaR5PZDqDaPKKDfAEnpx5EHC0mL39hy6w@mail.gmail.com/
[3]: https://lore.kernel.org/linux-aspeed/cover.1782224059.git.gregoire.layet@9elements.com/

Grégoire Layet (7):
  dt-bindings: serial: 8250: aspeed: add compatible string for ast2600
  dt-bindings: serial: 8250: aspeed: add aspeed,vuart-over-pci bool prop
  serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
  serial: 8250_aspeed_vuart: add VUART over PCI
  soc: aspeed: add host-side PCIe BMC device driver
  ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
  ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4

 .../devicetree/bindings/serial/8250.yaml      |  46 ++++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  12 +-
 drivers/soc/aspeed/Kconfig                    |  15 ++
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c      | 174 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c   |  87 +++++++++
 6 files changed, 323 insertions(+), 12 deletions(-)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c


base-commit: 564edaca14861ba9e58d4e646d272c677296d285
--
2.54.0
