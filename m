Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAE451982
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049105; cv=none; b=CqMGPA/ab7LUUC84aaybOxGuB362gWOuAyFyrR0HZG0Oqhs40qsxJVxk7sgqw5OA+1q/sJP+Dhn6Nua1tW0xh9htVvc/Nnp6ygZMh2YKnhIi9PUOVGtwZ9YFAlhdtIPemK8BNIJAIjWZSDbFdDWaC0HIXDa3eC8xjOIgmcRJvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049105; c=relaxed/simple;
	bh=zdf7YbsGr17j4IBQi976SWW4xGeMan6sdZEmC9JWzII=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KOqRaHBGLsMT2dhw65nxdKNnbfHsBjhv/L+qEmfEt4pokWAQdT/5HlrJIgAGiQgki01lrlm3xkgwbt7Jv8GRQfDOmTRAlZKXYrO/CapKrmC4sSKrnlA9F/PpZJOzhMbMbII3zyVjGr5D6Nj12s2nqB+JipbmBkB9+dC5PfCWtYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=UQqrdzlw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="UQqrdzlw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso44435375e9.3
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049101; x=1787653901; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iRzYJ7RHlmt5faDVd4SQiUF+QBz3mgu2M1pqY/9IwAk=;
        b=UQqrdzlwm+uoEMvLBU8cI6IwLin8x47ZsKL/NDJ8Wd+H2cWQDNoqBWyQ0fFKJuG++0
         gBxKSapAaPGZqKjKlz/6ngyF3+VMve+2TdNYjpicQXa2r6T9i6p85N6WV3QNpu+XqEUd
         GMi/jkOvuHZSwx2TqpcMyuoOKgTWlQ41Ksh7+iOpooZ51AGcUGbEnb9adJXtzOxukiVQ
         Up7/mKPz7JYf5U0Q6SoOvnG1uMU97Pv1UU4rTg+jJBBIfOIoC7Q4Jyx3BcDP1azsLOaC
         ywBOXpQUChhIppy4Wud8wNDdEMAOOtfiXCke1cVW6m2Gps/fGvlSlLrIAQS5PPSI4j27
         i5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049101; x=1787653901;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iRzYJ7RHlmt5faDVd4SQiUF+QBz3mgu2M1pqY/9IwAk=;
        b=m4xZv5lbKGRDFAm6VLWyuc9/7GmMnuWwrkiQmVkRDEi7CSSTTnKgCN9pFPNysiplk+
         rSVIc+6JnhqScKEtcb+IXZOALxd7u39CDvOyWd8upvU0FSUMQSBMcTeQLfoXTQV8lNL8
         d2OYveZn+kA638mTWoYiiGKqziy+8r1y7rEEW8G/7h2RzClgF57RumZIsz1DVBixquvl
         PYsZD7TifBL++TEgJvY9d7DNdFFvtDvz5N6NRhfW/i9PcadYrgwp38KaXi4ZtQh+DHnn
         HKsUMLmijcn36ocdELxnvjk/Mxup7qvd5SemzxEQhcbasdaUcXBhbVySsKETpHbeoOtj
         gLwg==
X-Forwarded-Encrypted: i=1; AHgh+RooW/MGZMNGG12YusIUrHl4m6es+xpgLjqbAb3eKF2OZo3vDy5l79ZH9eLB7nOJ06ylphXhvEN1eTFYtjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQW96mb8/4Rg5PHpA3Om2IzhIBp0LLKdvxB9e4lHDlnyeuf/Ee
	vfd0HLMZu92xwOjC+K+xpMRUsskyISG9Y+1ol5QGz9Qf+H2q2Cbx7SmtxcxhwV/ndto=
X-Gm-Gg: AR+sD10KJbUSM0VyJ4JX8VP9kIgai82ophJ62fGdm5/0SdM/lkCPC2U357uzamlxq+a
	8hczPjhi23huIBIQoxUR8MZ6mto3ajNtpgngVLDpdybjR2Q9IjgPw6GKG5MLVaiy0NWRL8Y8eO8
	m1akP9WBiEKa5kJi7StGNRlYdX3KaY3cEJWY+SrX5nhR05qoBJ2IL8aXoglsAGqItE3Vfhx5A8H
	oD37qnUtCQT5GDcJHiosG8vakS++dxzAcalT4fJ3d09BvyV5xPEVJzsWRGveCneUEUpdanjuC5p
	69XfBjSwJvUF9fCEhFYqSE7rU5A01jK/n6Nr2rVTViDGxHvj5R50lnmnZyQnUOp/p+STwK88T9t
	+jW52MbMV1N166cGPYq04is+7Tld8KFveRhUEe7vjy11oWh/uyezW4OM896HCiH249qVVENRNyN
	XdMJbj7u+YbZwE45/g7OcC7xXtIcyV1+4RPV+PDZ5f9Q3Xnl1gLQs3QlH1GtO9nDvHAQcs3pjqB
	7xBFo9TuwbzR4Qfxk2kXryZ2ahDdjDCLVyr2wV39VO53fS/FZ4HhlJ3IKWC81e6fSK7t0E=
X-Received: by 2002:a05:600c:6089:b0:499:86ce:465e with SMTP id 5b1f17b1804b1-49987941e38mr561900575e9.4.1787049101182;
        Tue, 18 Aug 2026 03:31:41 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:40 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v6 0/6] soc: aspeed: Add BMC and host driver for PCIe BMC
 device
Date: Tue, 18 Aug 2026 10:29:13 +0000
Message-Id: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPkzhGoC/yXMyw6CMBBG4Vchs3YSyqUBX8W4KO2PjgskM9qYE
 N6dqstvcc5GBhUYnauNFFlMnkuBP1UU72G5gSUVU1M3vh7cwMFWIHFSyVDOntM0jn0bQ+c6RyV
 bFbN8fsvL9W97Tw/E1/dD+34AwrvMHHQAAAA=
X-Change-ID: 20260818-aspeed-driver-v6-db9953ca4141
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

This is the v6 for upstreaming the VUART over PCIe BMC device drivers.

The initial drivers were taken from the ASPEED kernel SDK
(master-v6.18) [1], and have been adapted greatly.

There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe.

The virtual UART is an 8250-compatible register set. It is called
'virtual' because it is internally a simple FIFO.
On the AST2600, two VUARTs can be exposed over PCI via the PCI BMC device.

The host cannot access the BMC's memory. Only the exposed features are
accessible. These are the KCS4 channel and 2 VUARTs. There is also some
mailbox register functionality for a communication between
the host and the BMC. More information can be found here [2].

Changes since v5 [3]:
- Fix small formatting issue in Patch 4's commit message.
- Use static const for MFD cell and uart_port in the mfd driver.

The host driver will performs multiple functions. The AST2600 also
supports LPC over PCI, with a specific KCS channel (KCS4). This host core
driver should also be used to enable the IPMI automatically via this KCS
channel.

Tested:
As with v5, VUART data flow and MSI interrupts have been verified
as working on the test hardware, in both directions and on both VUARTs.
BMC: Asus IPMI Kommando Card R1.01, AST2600 A3 running OpenBMC
Host: Linux kernel v7.0.0

This series only supports the AST2600; the AST2700 is not supported.

The findings regarding the MSI interrupt numbers are explained in the v4
cover letter [4].

As with v3 and v4, I would like to know whether I should add the
'lpc-io-reg' and 'lpc-interrupt' values to the vuart3 and vuart4 nodes
directly in the 'aspeed-g6.dtsi'. The host driver is not capable of
finding the vuart address on its own, so they are hardcoded to 0x3f8 and
0x2f8. It will not work with other addresses, so perhaps they should be
in the .dtsi to ensure the correct configuration for the two vuart over
PCI.

[1]: https://github.com/AspeedTech-BMC/linux/tree/aspeed-master-v6.18/drivers/soc/aspeed
[2]: https://lore.kernel.org/linux-aspeed/CAFi2wKYOAotiezepDqaR5PZDqDaPKKDfAEnpx5EHC0mL39hy6w@mail.gmail.com/
[3]: https://lore.kernel.org/linux-aspeed/cover.1785932211.git.gregoire.layet@9elements.com/
[4]: https://lore.kernel.org/linux-aspeed/cover.1783524645.git.gregoire.layet@9elements.com/

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
Grégoire Layet (6):
      dt-bindings: serial: 8250: aspeed: add ast2600 and aspeed,vuart-over-pci
      serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
      serial: 8250_aspeed_vuart: add VUART over PCI
      mfd: aspeed-pci-core: add AST2600 PCIe BMC device driver
      ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
      ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4

 Documentation/devicetree/bindings/serial/8250.yaml |  42 +++++++-
 MAINTAINERS                                        |   6 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  14 ++-
 drivers/mfd/Kconfig                                |  12 +++
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/aspeed-pci-core.c                      | 115 +++++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |  92 +++++++++++++++++
 7 files changed, 277 insertions(+), 6 deletions(-)
---
base-commit: 6fdec78001b3b94f1b6000bbb2f9ec3498f1c73e
change-id: 20260818-aspeed-driver-v6-db9953ca4141

Best regards,
--  
Grégoire Layet <gregoire.layet@9elements.com>

