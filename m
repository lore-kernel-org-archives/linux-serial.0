Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76F45FFBB
	for <linux-serial@vger.kernel.org>; Wed,  5 Aug 2026 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932432; cv=none; b=Tf4AYGmFJxkmRLzhy7Io0nLcTIj/d6/js+euP/6zB+QzCZowL/KCSGyK1zm2HoEDvDJ6+ByGePJOsvdYkJEPS6MSP1pGVIV8A8wwmvaaJL5gS1pMttiN/1XFmcf4zWReGOxqxj3vLSArvZf77xTV8gM9g8fNZkOybDKUDy3bT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932432; c=relaxed/simple;
	bh=xl1cOK/dGjUW1mBNDOJNs68D8duvgWXHAALZFiZHDPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FfZmW8+vqilrTjVRccP6d5dpZ7IGsapfnGs73RxlNO4kNwZdugnK0QGuF30pTO4m9uu3gzfWkNBhOBWGNXcy6sDPaoCgULZBGieWqDGyZzgS9/WsJ4gNSTk/OtqJgf2ArtJsbkhaRbdAQIljA34lAADHdho8x6AyCyJuNqqlVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=VNf1+RCx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="VNf1+RCx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so7361475e9.0
        for <linux-serial@vger.kernel.org>; Wed, 05 Aug 2026 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932427; x=1786537227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dp0YqgID/4phtDgYq1gE5Cv1WezComCCtY1tYXFFVXw=;
        b=VNf1+RCxaaRT+n6/oljqRy5WVe0G/0k5bfZoJ3cfJhSUWka6QruCDxMSHn1xcHnFuj
         KKlP0lq7O+Gi9E6K/W/BjVK8kP41+aEwtJ6YkX7juY8eJR+005CrmJE4ai2v8XLEtUrT
         WOiDlzbFgLa0BM6I7D5ojPXiIuE893z7Imq2jmW7MqYPodAoFsD/w5rBNwCPMrdHDqda
         a9BX543vkiIoTtpYpU3MzwSQP3zCqu7lCDvXXl4LwB4isHgAjNnoTJBdpLF3p5KDDTt9
         y/j5gEHE8O/1i2we8WCXjxAWkdHieON2CPZolWmckq2e8lXccQmHp1UDtsYW7PBNK9hr
         31mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932427; x=1786537227;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dp0YqgID/4phtDgYq1gE5Cv1WezComCCtY1tYXFFVXw=;
        b=MNOozuMhgA92zUF39YghlTXBu9d1+awsHGIOaNAODIESUkmCNS8VnskSSwFvZEGMdF
         AZXSm8OIkZRfYSVJu0d5F48r4tWWhkhKBoh7m1IulPoYQjg48D8KiYfFXieliSrkPpPl
         USp9CSXDrYSfLkLqixWjYHdlB7soOqv1ER2vx5zMGTOPsirJT75mDa9ynadQetvSa+yP
         1da37q2EMNhz6fr0ApGomgEhhULZ6INmrn6d9ydZvKTJVZgQsQJKdgNgd+Jx/0HPp0B4
         gZP48C345ALlP1Z5ORb951XdsYvmGovgXi5nvvwXjeqTrIeh8uvPxMRjXMc4xxHg10fL
         FHsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlABFAO648meLZ0lBkaIpvpDqblI6YSHgatjzhf5AT8570kfUJxsJnSM5R5/WK1toxlrvBVPziBP997RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDWR5xjic/BhQ4q0h9yoDFQCVU4qTfP4gFS0Wywf4XtrWF5Uf
	ZcK4E36Ihf70fi7gWI5ElIv7IEEx2uNhDsfISTorHnBlZ+mh+qgRv6t69zFrsT9Nc0s=
X-Gm-Gg: AR+sD13eUDaEm0PlVPRKGsTwUz4s0UqqPmChY7au8Pi+h/AGrqVo/R1lHNc9aQGLyS7
	+qx2qtUkT4lMMIcZfukO6N638YvVJK8AbcnOCeKo/F31uLvuAclx61QFhSIMu5WNfrwv7nZ17dN
	gwBgqgw0mpsmybmS3jOwgRv+iEni+lLEkOfcTeWFvqX/kSWck/RKDR3oFcBQLBKjudOWGLbOh95
	4N/BhZOiBn75SpWr7hbsM4DuoEvxURLnj+euj467Uz9GcRYovGFLk4eqtdlPmIq0LHckV7JuUXg
	fK0Kj8qOFlzd2lopos07T0awyODYRdEmAHJqU0f4Zfdkffp+4UydtRisdOBTGgYSMPB3s0TLuCH
	AnobfnoUxUkH29yLgvW6Yb74Yebs702huuwVsMUNrG67ACKYtOnXqlt/GUUv9RyjwsLR4Jj4AYx
	Rf0DDz+2TZYSQDYFQRZgFV2NjjK2uXuqGBDid8rLdgrysgeg0sjWOehCmZ/D0jqVwOq7C/N3KFc
	cHu8XQv4PT5zkna8mhXK2i4kMBdkVMYmSqp3EHDH8y7/ZpeVz0nsD6ZsYw3Qblep18hXKSDKazj
X-Received: by 2002:a05:600c:4e87:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-4994e7c0356mr76610975e9.11.1785932426940;
        Wed, 05 Aug 2026 05:20:26 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:26 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 0/6] soc: aspeed: Add BMC and host driver for PCIe BMC device
Date: Wed,  5 Aug 2026 14:19:47 +0200
Message-ID: <cover.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the v5 for upstreaming the VUART over PCIe BMC device drivers.
The initial drivers were taken from the ASPEED kernel SDK
(master-v6.18) [1].

There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe.

The virtual UART is an 8250-compatible register set. It is called
'virtual' because it is internally a simple FIFO.
On the AST2600, two VUARTs can be exposed over PCI via the PCI BMC device.

The host cannot access the BMC's memory. Only the exposed features are
accessible. These are the KCS4 channel and 2 VUARTs. There is also some
mailbox register functionality for a communication between
the host and the BMC. More information can be found here [2].

Changes since v4 [3]:
- Squashed '8250' DT binding changes in one patch based on Krzysztof's
  review.
- Removed 'aspeed,sirq-polarity-sense' support on new
  'aspeed,ast2600-vuart' compatible string as it's a deprecated property.
- Renamed 'syscon' to 'aspeed,scu-syscon' in '8250' DT binding.
- Cleanup in BMC driver:
  - Changed bit 14 to RESERVED macro
  - Changed macros ordering
  - use FIELD_PREP macro
- Cleaned up of the host-side driver:
  - Removed unused INTX. Only use MSI interrupt.
  - Proper use of dev_err_probe.
  - Use of 'module_pci_driver'.
  - Used managed functions and simplified exit code.
- Changed the host side driver location:
  - Now in driver/mfd/aspeed-pci-core.c
  - Changed code to use MFD cells.
    VUART are sub driver of the core driver.
    This allows for easy expansion for KCS support.
  - The core driver now only sets up MSI interrupts and
    instantiates the 8250 sub-driver.

The host driver will performs multiple functions. The AST2600 also
supports LPC over PCI, with a specific KCS channel (KCS4). This host core
driver should also be used to enable the IPMI automatically via this KCS
channel.

Tested:
As with v4, VUART data flow and MSI interrupts have been verified
as working on the test hardware.
BMC: Asus IPMI Kommando Card R1.01, AST2600 A3 running OpenBMC
Host: Linux kernel v7.0.0

This series only supports the AST2600; the AST2700 is not supported.

The findings regarding the MSI interrupt numbers are explained in the v4
cover letter [3].

As with v3 and v4, I would like to know whether I should add the
'lpc-io-reg' and 'lpc-interrupt' values to the vuart3 and vuart4 nodes
directly in the 'aspeed-g6.dtsi'. The host driver is not capable of
finding the vuart address on its own, so they are hardcoded to 0x3f8 and
0x2f8. It will not work with other addresses, so perhaps they should be
in the .dtsi to ensure the correct configuration for the two vuart over
PCI.

[1]: https://github.com/AspeedTech-BMC/linux/tree/aspeed-master-v6.18/drivers/soc/aspeed
[2]: https://lore.kernel.org/linux-aspeed/CAFi2wKYOAotiezepDqaR5PZDqDaPKKDfAEnpx5EHC0mL39hy6w@mail.gmail.com/
[3]: https://lore.kernel.org/linux-aspeed/cover.1783524645.git.gregoire.layet@9elements.com/

Grégoire Layet (6):
  dt-bindings: serial: 8250: aspeed: add ast2600 and
    aspeed,vuart-over-pci
  serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
  serial: 8250_aspeed_vuart: add VUART over PCI
  soc: mfd: add ASPEED AST2600 PCIe BMC device driver
  ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
  ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4

 .../devicetree/bindings/serial/8250.yaml      |  42 +++++-
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  12 +-
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/aspeed-pci-core.c                 | 120 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c   |  92 ++++++++++++++
 7 files changed, 280 insertions(+), 6 deletions(-)
 create mode 100644 drivers/mfd/aspeed-pci-core.c


base-commit: 253b1036b9163f23f7b18274a0d4e904ac8821c5
--
2.54.0
