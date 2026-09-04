Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7C442FDF;
	Fri,  4 Sep 2026 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514436; cv=none; b=BmtYCmrc1FRWcnVtpKfKJSp13tW/Il4V3yyN+xudiC/k0tf3jKcTWrxxGP9oz/o7U2wasJ+laBmcQFnIaTre0Vni46RAJ/LsD+09VrVunUjq7+N8oAEqr5EMpDgvNFXCcEDyi2oRPcDT8bAEPUaZuZDyTvc+CFHcVJdRc349qwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514436; c=relaxed/simple;
	bh=Zn1U5ffYpSJaLNd/aCsQl2YHo2hUPA0Q1cg/IA7sWU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCvkmlygh8mcmrxVnBQ8rv99DXLTan14aI23wPs9F3ZurzHhaM2OaTQPmc3/NbMojVhUMo1bDlerkkGzNBqike996lf9h7W8Buge4xsyNFqX9KeZebgmkEJxHHE528x7SdPsNoEAe31aKoB1ove+weQzE6+gF7rZK/r/CN/p0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07440947|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00195578-2.50775e-05-0.998019;FP=2437436341041654015|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.j5Rterl_1788514423;
Received: from LAPTOP-VQRD5F43.hs.edatec.cn(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.j5Rterl_1788514423 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 17:33:44 +0800
From: zjzhao@edatec.cn
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	zjzhao <zjzhao@edatec.cn>
Subject: [PATCH v2 0/2] WK2xxx SPI to UART bridge driver
Date: Fri,  4 Sep 2026 17:33:38 +0800
Message-ID: <20260904093341.100826-1-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904072027.67473-1-zjzhao@edatec.cn>
References: <20260904072027.67473-1-zjzhao@edatec.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zjzhao <zjzhao@edatec.cn>

Hi,

This series adds a driver for the WK2xxx SPI-to-UART bridge ICs
(WK2124, WK2132, WK2168, WK2202 and WK2204) by WKmic (Chengdu Weikai
Microelectronics), together with a DT binding and the "wkmic" vendor
prefix.

There is no existing driver that could have been only extended instead:
unlike the NXP SC16IS7xx and Maxim MAX310x parts (which implement the
16550-style register set over regmap/SPI/I2C), the WK2xxx uses a
proprietary register map and SPI protocol - the sub-UART number and a
page-select bit are encoded in the SPI command byte and dedicated FIFO
burst commands are used - and it has no modem-control registers and
supports 8 data bits only. Just as sc16is7xx and max310x live in
separate drivers although the former is derived from the latter, a
dedicated driver is the appropriate model here.

Each channel is described by a serial@N child node of the SPI device
(see the binding); serial and RS-485 properties of a child are applied
to that channel only, following the max310x pattern.

Changes in v2:
- Binding: model each UART channel as a serial@N subnode, add a default
  for clock-frequency and a trailing newline (Sashiko review, round 1).
- Driver - Sashiko review (round 2) and Jiri Slaby's review:
  * request the IRQ before registering the ports and free it again
    before tearing the ports down (no devm), fixing both a
    late-interrupt use-after-free and an open-before-request race;
  * keep the shared polling loop running while any port is open and
    stop it only when the last port is closed;
  * propagate SPI read errors instead of relying on uninitialized data;
  * use DMA-safe shared transfer buffers (no stack buffers);
  * no self-deadlock of the kthread worker in polling mode;
  * no 64-bit division, so the driver builds on 32-bit;
  * return IRQ_NONE/IRQ_HANDLED correctly for shared IRQs and bound
    the drain loop;
  * honour CREAD by dropping received data while the receiver is off;
  * disable the RX time-out interrupt in throttle() so that flow
    control actually holds;
  * advertise no RS485 RTS delays (RTS timing is hardware-driven; the
    serial core sanitizes non-zero requests to zero);
  * drop the no-op request_port/release_port ops and use UPIO_BUS
    instead of the membase workaround;
  * use the kernel cleanup guards and drop the hand-rolled
    lock/unlock/goto patterns.
- The TX path intentionally does not use the uart_port_tx() helpers:
  pushing bytes requires sleeping SPI transfers, which cannot run while
  holding the port spinlock, so TX is driven from the kthread worker
  under a dedicated mutex, as in sc16is7xx/max310x.
- Known hardware limitation: the FIFO-status error flags are FIFO-wide
  and sticky, so a batch read must apply the same line status to all
  bytes of the batch.

Tested on Raspberry Pi 5 boards (EDATEC IPC1200 with WK2132 on SPI0 and
SBC2300 with WK2204 on SPI1); loopback TX/RX tests pass.

zjzhao (2):
  serial: wk2xxx: Add WK2xxx SPI UART driver
  dt-bindings: serial: Document WK2xxx SPI UART bindings

-- 
2.43.0
