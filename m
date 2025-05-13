Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DE21ADB0;
	Tue, 13 May 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173603; cv=none; b=b8LrPoYBUGcPERasZb2d+WVi+OpQNVEjJpJ8DwAfORjIO+NLK3+aklF2KVTEkSlsYcsRcbvy9W70xEXtlXQ/eUSXhxw1uLXaNlOSK7L5ISCpOvkVP6spHcmqb3DbSKQHuNnFZKTv1BH8EYuwZKS+nJGQuY+s5UY0AT5EhYFruig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173603; c=relaxed/simple;
	bh=KytDEG2rZK2nxmftE17Y9osIJn/dpALlYzKwo0Q8mDQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pg1QT+0ZyJQixK3cavVbWzMQSclNXFAvnKrq7uJVj8ttkDH8yCa/y+OWL1Ydyv7S+HuV/RJbDr0x5D9NFcG91VB+fBcaqKy2mhqaLzzduECEWMseDQtCWPZj6jmN+2kehVdRJAFyNhs1XGoM+1uVPIM90bG+GGige9xNgxaHNeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ERIPej2x; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ERIPej2x"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54DLxZs22431440
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747173575;
	bh=jnHT8pxDxVP+7w5heuoy29BHYqRqmLa4rbZcp55hLz8=;
	h=From:To:CC:Subject:Date;
	b=ERIPej2xrbzviCKtULWnltF915ieOQyQ737wTjYJ3yrGmUpTP4MagUxPdM8O0F1Pt
	 EbklfBSl+HoN5NdjbmKOLjpTXimwonpHNs1xOKiqdUj5SdD12gZFIeRATv9Jfavpnm
	 2HmrTZKeOXO4CeBS5q2InDFhaOwDku6AnqMAYj5Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54DLxZQb033002
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 16:59:35 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 May 2025 16:59:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 May 2025 16:59:34 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxYdB111031;
	Tue, 13 May 2025 16:59:34 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Andrew Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/7] Introduce PRU UART driver
Date: Tue, 13 May 2025 16:59:27 -0500
Message-ID: <20250513215934.933807-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The PRU_ICSSG subsystems in am64x SoC, the PRU subsystem in am62 SoC, and
PRU_ICSS subsystem in am335x SoC include a UART sub-module. This patch
series introduces the driver and the corresponding binding documentation
for this UART sub-module.

The DTS patches for adding PRU UART nodes and enabling PRU UART is added
in this v1 version, but marked as DONOTMERGE since the patches only add
context to this series.

This driver version has been tested on the following boards: am64x SK and
am62x SK.

The RFC version of this driver has been previously tested on am335x SK as
well. DTS patches for enabling PRU UART for am335x SK will be sent as a
separate series once this series is merged.

Changes since RFC:
- Add DTS patches 3-6
- Fix include list
- Switch to platform_get_resource & uart_read_port_properties
- Remove custom speed hack in pruss8250_get_divisor
- Use port->serial_out functions provided by core driver instead of
  local writel() functions
- Switch to UPIO_MEM32 since largest UART register is 18 bits in length
- Cleanup whitspace, comments, variable/structure names, error paths
  and GPL licensing

Link to RFC:
https://lore.kernel.org/all/20250501003113.1609342-1-jm@ti.com/

Bin Liu (2):
  dt-bindings: serial: add binding documentation for TI PRUSS UART
  serial: 8250: Add PRUSS UART driver

Judith Mendez (5):
  dt-bindings: soc: ti: pruss: Add documentation for PRU UART support
  DONOTMERGE: arm64: dts: ti: k3-am64-main: Add PRU UART nodes
  DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable PRU UART
  DONOTMERGE: arm64: dts: ti: k3-am62-main: Add PRU UART node
  DONOTMERGE: arm64: dts: ti: k3-am62x-sk: Enable PRU UART

 .../bindings/serial/ti,pruss-uart.yaml        |  54 ++++++
 .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   7 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |   9 +
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  14 ++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  18 ++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  16 ++
 drivers/tty/serial/8250/8250_pruss.c          | 178 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |  11 ++
 drivers/tty/serial/8250/Makefile              |   1 +
 9 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ti,pruss-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_pruss.c


base-commit: edef457004774e598fc4c1b7d1d4f0bcd9d0bb30
-- 
2.49.0

