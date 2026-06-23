Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DA331237
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224972; cv=none; b=mUbaopbs6hoOY/aif5NaLp9Dvhw38os9tPQXPv+GvyTZK0eatX4mGT6nhh/4z0+VAicu2andj7HJ4Lycf3/9hs2cqWXS83/1vys5Lw3ZSqp8UKCyGPzhefZCw6YyJTd+yn62nPdP+xqGhEldsaCLavv+5XQ+wkN9VLI2szogjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224972; c=relaxed/simple;
	bh=es1hlOJJb29LNCAz7u5GwCxs6irEkDSzvcvTQMOnO+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgCltxe3EYS791BRSubX1SUdgrGuzM2w/KfQExHj2WQym20xlHjj7Bg1YcDePY0a5W6grzYYHkzjeiNRTcecQc84dpwaxeKZpBak9nqfrMsIgv0iS9WsMkgMiaYXR8ySWiHyzoeIwzaHjytlgFari7SRjiiPZnqCkXSWVTNl3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Oakb4eEY; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Oakb4eEY"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490a76757e5so36113045e9.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224967; x=1782829767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H10VUnmTOcSqsdtPCuQYnfKlpPMwS75wksj7BtxL1Y4=;
        b=Oakb4eEYfiBDHz1lCHfmXfrUPwCzudUVExVyD5E0PTxNfdnR/NJOKrBEdPd4IyC88w
         5xTNjGY3gooUeDzA8POHtxNYrWOAHz40S7mtYDGWjFJPdT7Q/4erGsuMpPdT+kUrRE6X
         rtp6nWLrCi1xplDjRuzL/k5B1DRWX+o4kiZVrxoPxbjIx8ocRuew0uHopOg5EHOz4bpt
         VaFeyQOEDhqV4NJAro8Z8dSbXoMew2yuBei16Kdh6s1sriuopy0hAm9lDCB/q9xa6YbT
         kkBWv80C5ewPphpKHb34Oh2FVoEYphdyZwj4r3i0Rdx1u6VzpsxxiAoMe8d3FzzjXqEn
         7LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224967; x=1782829767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H10VUnmTOcSqsdtPCuQYnfKlpPMwS75wksj7BtxL1Y4=;
        b=Vtg2ZCWqaCh7DQMNETRYKI6ovqPDWX4cwIh/lb+iL6XDJlDSu4unhFC70luGCjDb0D
         OB+vpwUnxCf+mg/3D0ISK21m1ImmDepNedWlX0910H2ctaJq8k2uv3pJvcMYGGUWea51
         ueO8fzGkBajFatzoEl2Rnm31kWCj2iRQXZX5vmPh3RfCzltJCCOwR0FyoWp/XcGQfbaP
         R/6EfIT+J1Hjp5LnDxNjcu3BcKeQt3w+QMGb2XKVQdizLZikhZj9lTZFXkxXGJUxN/Di
         pSUUTfse/nNpA77e1HvmP/lBxoYxZDzgPXE4LE8tQ9Uyu/yzsL/UJZGV/SNcE2u5rvQI
         BqDA==
X-Forwarded-Encrypted: i=1; AFNElJ8PZmqb6xbAsiEFSprpevnxH4odOOEE3gL64mgnrlVzDUMS90cfaIH2DBQZLTK8dJ0QG5hMKv5FbNr1WJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMQLWm+F1tR/JKx1X4xrSmIsRQ+LpPmONX6o1gA9vqUArxpOB
	JZOLQyl0gbWAsm98lFLPVOCPqey21VygkpY0pmMDh7n8/osg1S/OkdrhfufA2VUJjd8=
X-Gm-Gg: AfdE7cm5EDyst3xtJnnacjVb0ZrwZAPVLwPn9EWIpXEs4o1QSJU5smRZik/jDaK5EXj
	/IBWJsJ2QHi/Q3hzfyPkGdAf39SIikPJFbsYiLsh4CDBBVaCp7BXsB7j0bVLzic2ku+gJPKMq4x
	hCYbHIhayBt+4zYjPZfhQDugMZx+/2Ls0Ek0iMESlC1VjWWjVURUgw4cMHDSkUA4c7EVT6nlLw6
	TcVPX6xBkQ3Xs2KG10tcihX2fFFT/jwAwNJrSUX5BzGYMlRQwPamtNK0OgQZLlmGqyboZtxVg4X
	C6W3qoYcitjEEtQprRF8W2IdU4xlIqwcBqvOzlPDdvggrC/ygmO2MV96asrT19wa6ZtnDcvqEzY
	cWzXLYSygl6/s2Xrk65zPfFlRD4cCq64x4b+ajQxET8De29j9zPrOy+9NZqClhqzSd91hjv6aub
	ycXxlajM2d8auvQKw9ZyzWieFtlHLpYaHWjwB6Jz/MYw6ldy877EFwxLOU+HwORo9OISM7JYzW5
	pem+BbfJg1fLTwxGM//5BVMI/zr
X-Received: by 2002:a05:600c:8b2c:b0:490:ba0a:1178 with SMTP id 5b1f17b1804b1-4925b3b1732mr44333735e9.28.1782224967252;
        Tue, 23 Jun 2026 07:29:27 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:26 -0700 (PDT)
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
Subject: [PATCH v3 0/7] soc: aspeed: Add BMC and host driver for PCIe BMC device
Date: Tue, 23 Jun 2026 14:25:38 +0000
Message-ID: <cover.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780929570.git.gregoire.layet@9elements.com>
References: <cover.1780929570.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a v3 for upstreaming the VUART over PCIe BMC device driver.
The initial driver is from the ASPEED kernel SDK (master-v6.18) [1].

There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe.

The host cannot access the BMC's memory. Only the enabled features are
accessible. These are the KCS4 channel and 2 VUARTs. There is also some
mailbox register functionality also exist for a communication between
the host and the BMC. More information can be found here [2].

This v3 mainly modifies the BMC driver and focuses on VUART.
The BMC driver is now incorporated into the '8250_aspeed_vuart' driver.
A specific flag can be set to indicate that the VUART should be used
over PCI. Several changes have been made to the 8250 device tree binding
and the 'aspeed-g6.dtsi'.

Changes since v2 [3]:
- Add the aspeed,ast2600-vuart compatible entry to the '8250' DT binding
- Add the aspeed,ast2600-vuart compatible property in 'aspeed-g6.dtsi'
- Add the aspeed,vuart-over-pci boolean property to the '8250' DT binding,
  only for the aspeed,ast2600-vuart
- Add the aspeed,vuart-over-pci flag to the vuart3 and vuart4 
- Add the aspeed,ast2600-vuart compatible property to the 
  '8250_aspeed_vuart' driver
- Add the VUART over PCI code to the '8250_aspeed_vuart' driver
- The v2 review of the host-side BMC driver has been applied.

The host-side driver is still in /soc/aspeed/, as it is very specific to
this SoC for me. I didn't receive any feedback on where to put this
driver. I can, of course, change this to the relevant location.

It's important to consider that the host driver will do multiple
functions. The AST2600 also supports LPC over PCI, with a specific KCS
channel (KCS4). This driver should also be used to enable the IPMI
automatically via this KCS channel. The UART and the IPMI will depend on
the same PCI resource (BAR1), so this must be configured in one driver.

As with v2, VUART data flow and MSI interrupts have been verified 
working on the test hardware.

Tested on:
BMC:
- Asus IPMI Kommando Card R1.01, AST2600 A3.
- OpenBMC
Host:
- Linux kernel v7.0.0

This v3 only supports AST2600; the AST2700 is not supported by this series.

I would like to know whether I should add the 'lpc-io-reg' and
'lpc-interrupt' values to the vuart3 and vuart4 nodes directly in the
'aspeed-g6.dtsi'. The host driver is not capable of finding the vuart
address on his own, so they are hardcoded to 0x3f8 and 0x2f8. It will
not work with other adresses, so perhaps they should be in the .dtsi to
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
[3]: https://lore.kernel.org/linux-aspeed/cover.1780929570.git.gregoire.layet@9elements.com/

Grégoire Layet (7):
  dt-bindings: serial: 8250: aspeed: add compatible string for ast2600
  dt-bindings: serial: 8250: aspeed: add aspeed,vuart-over-pci bool prop
  serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
  serial: 8250_aspeed_vuart: add VUART over PCI
  soc: aspeed: add host-side PCIe BMC device driver
  ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
  ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4

 .../devicetree/bindings/serial/8250.yaml      |  35 +++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  10 +-
 drivers/soc/aspeed/Kconfig                    |   8 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c      | 183 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c   |  87 +++++++++
 6 files changed, 312 insertions(+), 12 deletions(-)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.54.0

