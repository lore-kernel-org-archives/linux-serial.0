Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022089.outbound.protection.outlook.com [52.101.43.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C64345753;
	Fri, 17 Jul 2026 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260293; cv=fail; b=mE6JViOElS7wSzXMeYDgXpNsprRV+I8HqUHJvTs+mLdKBsR+M5ERirsW8NIEwuqZkxHghbJTAcRNJhr2evxWqhnIPYVm9V1PBrHkeq/Rijq90NZb62NmlaBfO5iJV8H23l8zcAInJl2LXKzrV3oOuUkLb6d1QZpueQ81sPQe9lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260293; c=relaxed/simple;
	bh=+2IbP4jom5H0MWntxYE6HS0QfBov9fKgkwXKA8HCETM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tagGMVFgLlV9pcgBwCdVyeyxjt3Be8XKBUvv/x6NP9LbMPZRPVxB6DgQwETD/XF+rgx20cUtf782A2q2tzoEsfvYfoKr8sWDtNx0cmrIEo4E7L0OKEgONum/M4rLIIL2pUTh8IkDSd3NWD8cr7NhDycrOTGWwH8XKrQWuForEoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=pPrPMmTB; arc=fail smtp.client-ip=52.101.43.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="pPrPMmTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhZuGtWnNKEkoY+14deFTvJIjCSYGrbPiJBz3fg/j2ItVyW3XqUvD9sYiPz1rbB7ayBVFpeXkFTlvbBGnDsmLcoWu58/55dRjDU1+zHidXYiFFhlv66MhI6VB6BQ7Nni3Iu9OcV969hxoHprJyqJC88nP2ovHdRb08btYxYSQnRAUsJp3NQTk+SNbW7qwo0sMzcvuaDXCkNByLO742yLy+MeaJw3mjmct5sY4Oe8yRZidKzDFGXCxokB1jNq2WHMGKDVjrYvYdharepP0rIxm8hrGwXn4QGYGjgc+JGQnnxEI+hSk0nEcM6ELI/pJNi91hwtvXqMxUyeAd/pWU4hAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZJ5QwWCYQ5HnaXprcs0OoAWsLNddU/cXHGddPoVIHE=;
 b=qFMefhMxnEctxROayWeNiRj1JgLPEky+n+LO+9yzq7TUAnLQrycaXaBnXWcCIbUQKMqt9tkQ5rhtKnU5IWz+GrQ70gSc8z28yoYg1NQ+q9tyQHX+c6QfHy48GFSOuq9saYPTPOj37XmUvxKokfCK4salmvJcxdE/qCR8YesNtBPqXj9RiwLmb45O1W3pzNvovxKXingB0wsd6mqZBhoA77BNyb8lvr7PzHkE6qwHZrDFJJhl0exHkhlMVdUmSL+XaZqBZtz9MTLdd1kAULf025TWSif99g85jGQfFy5zZI3QYTML/AGPCEvgyGaLDa7Og054GAEqNAeJkk58BTKqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZJ5QwWCYQ5HnaXprcs0OoAWsLNddU/cXHGddPoVIHE=;
 b=pPrPMmTBflVRBJG4x9noxXrzhWQzNrk54i0yxamminykBT0wOMH4JprORIytYMl3D7bxpvYCfv7XWjhMmg2Tou6L/LeZqqFFbOz/W0H09mF2mLaXoGH37SWBYJL5v/gNDMK/AamfwbTNFaoeokTQ/+RcBuVQOEV8rNidsjjfwC+lgT32PfOi+HzqsjzZNaUSmYVq2oRmh+fGkF+5m+ipwSUTgRoG7JK/Hon104BV6f3Q3YkAk1MCq9CH3FOnnP5Ky77tXw+JneVwYz3Ab5v+9vHrjpZD2Erc3dltZ5Y7hsI98MyVJWmlwmsjjVPJFLkqkt1d0FhEOTO7zA3n+6LOSg==
Received: from DS1PR02CA0012.namprd02.prod.outlook.com (2603:10b6:8:452::9) by
 MN0PR18MB5898.namprd18.prod.outlook.com (2603:10b6:208:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:51:27 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:452:cafe::57) by DS1PR02CA0012.outlook.office365.com
 (2603:10b6:8:452::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 03:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 03:51:26 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 2FD184186B52;
	Thu, 16 Jul 2026 20:51:26 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Subject: [PATCH v3 0/8] arm64: Add Axiado AX3005 SoC and EVK support
Date: Thu, 16 Jul 2026 20:51:07 -0700
Message-Id: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKumWWoC/4XNyw6CMBAF0F8hXVszLeXlyv8wLvqULqCkxQZD+
 HcLmqAL42pyJzPnzihob3VAp2xGXkcbrOtTyA8Zki3vbxpblTKiQEsoSYXvQxi95h3mk+XKpZE
 DFPtaCGiqGjg1yqCkDF4bO20Nl2vKrQ2j84+tMJJ1+7Yp+2tHggFLKIQCIRtC2fl1eJSuQyse6
 Q5Wn5+/QJpAqoxQhLHa1OQLXJblCYD/73MgAQAA
X-Change-ID: 20260617-upstream-axiado-ax3005-upstream-bb09780a2fdf
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Jan Kotas <jank@cadence.com>, Michal Simek <michal.simek@amd.com>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Mathias Nyman <mathias.nyman@intel.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, Swark Yang <syang@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=syang@axiado.com;
 h=from:subject:message-id; bh=+2IbP4jom5H0MWntxYE6HS0QfBov9fKgkwXKA8HCETM=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqzIZVsDfPgv3bk+Zc3yP9POGK511OZX0p+dvn737+2CR
 Z38sdYnO0pZGMQ4GGTFFFm+6nzLP5mrfa9z78pSmDmsTCBDGLg4BWAiy5Yz/K/bcezq3jO1BnyP
 niit458U8NNIN8HpRGz+hXmmwotftrgz/DN/lLpcRtv9xeU5TElPtb91PtpTWOO5rnWd2dGOVPF
 VJ3kA
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|MN0PR18MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 1892b789-5753-44ef-8dbf-08dee3b6ad93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|23010399003|82310400026|3023799007|56012099006|10067099003|13003099007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	8UZW6EVyU1pJc9aIo4Mc2jLX3ucxijopYyEPzz49LIesmtfrTEjyvCsq4Gx2MbNmvgHKTR9xXKOxH5sD4sh9G8mJoXDUQVgHCypHUj6hjgwO2h7ub1bj6xXOeKb8LfRCSqACRrZBu3xyn7TtvDE+mD36JZ9LZhFeXxTbWX9UKsdzUKcZbKgMasLUcmK+Vxk97Sc5lCmEOljCMA3JBxII7dQvO5A0aFt4iVTUlfXT3U0gY6yARt0aTMpCjSg55LE0vop6D2CnMvDsxeGIZ1mWhhp+93cu50wJJJ/r1fl+36luA/xuQ1r4qlLgn73tha0KS5tY60n3+TquYV/cvRxFiHq0OjfMT1AucJXMbpVdEpwCLJURo3RPTuClgNXlX/Hk4yc1ruvkwrW56it/1XkxLDwa4mYpdXDjGFnPaWZvDA6iTIQVRvoOF7oYCWPTim8WXhv10VOcW2eZApyQ5+ukJwEAi4ns2kgB9keZFQTKXGOZ6cLBEF6WqmUQgIjjTHalgNrOxfG3xTMm3BusJ1nAQ1ezAf8DnxUapj3u7GeCcbzGzGKVBCjkCmMX35E8YBxBeQO7pQkiXvgMkdVif0NtFWgovgSsE0ULydmsI90gaY3L5PLyj2F2qIGRGvNqKYApOwXEoZPItBhnTb3XwtbarB8JJTu0M936Ztb55bl0S1A5jG2kxaXQsDx4wIdUi5an9w/y6bYMhkFSyG+8YrGOfQvZrNFpNfoftpH5k5+CoyunuwRh6qEQmDhrN6Wd7okb
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(23010399003)(82310400026)(3023799007)(56012099006)(10067099003)(13003099007)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5/z5dw5mG57hUDZ8cZr97I2CX5sGHWOm3iT3EHFSqCBrY7t4Z0CL8AQmfxm3wonXPfAGhQMFOqjE5GcmuBgCXBC/mhVrTzbnkAnUvR6An2WsoJFm0QlDD+o7GJ4F21MQkeWlhfsX39CwLGk1fiYVBVkSbs2m2GkIXeupIfP8HP5YM8a1B6G2VgOSxr3OWUGvi7U6M4qHsOJsKH0vMGkP1ExNnj+oLE6m+pY0Tf/wW0fnGNTepaASUn3EwjM27czvrj2TcJtdDdM41UNPGp2NhkC3oHR1yb12pbfb19AG1Zyp6lRuTA4Op3MD8GAYPJd6uSmIffRW0d/c0kVA9+rXnwvoFTDOVn3zikjfolhtARYCTnL51OA3x2EY1fGUKfQq9uWbP2Qe0DjB5HletqVcMf7M2Osvl5VXusOTHKUhTTkVhlTPWcXYy0dL/UU4ORJi
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:51:26.7563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1892b789-5753-44ef-8dbf-08dee3b6ad93
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5898

This series adds initial device tree support for the Axiado AX3005 SoC
and its evaluation board (EVK).

The AX3005 uses Cadence-derived UART/I2C/I3C/GPIO and Synopsys
DesignWare SPI IP blocks. These are already described by 
existing bindings, so the device tree reuses the "axiado,ax3000-*",
"cdns,*" and "snps,*" compatible strings; only a new SoC/board 
level compatible is added.

Patch 1 adds the AX3005 board/SoC compatible strings to the Axiado
platform binding.
Patch 2 adds the AX3005 SoC dtsi, the EVK board dts, and the Makefile
entry. The EVK enables the CPUs, timer, GPIO, UART, I2C, I3C, SPI and
USB controllers.

Validated with:
- make CHECK_DTBS=y axiado/ax3005-evk.dtb
- make dt_binding_check DT_SCHEMA_FILES=axiado.yaml
- boot-tested on the AX3005 EVK (to init CLI via ramfs)

Signed-off-by: Swark Yang <syang@axiado.com>
---
Changes in v3:
- Added SoC-specific compatibles (e.g., axiado,ax3005-gpio) with appropriate
  fallbacks to all IP blocks (UART, I3C, I2C, SPI, USB, GPIO).
- Added corresponding dt-bindings patches for all updated IPs.
- Renamed l2-cache0 node to l2-cache to drop the unnecessary unit address.
- Fixed DT node sorting.
- Link to v2: https://lore.kernel.org/r/20260705-upstream-axiado-ax3005-upstream-v2-0-2dfbd1448f81@axiado.com

Changes in v2:
- Confirmed with internal team that AX3005 BootROM multiplexes the
  single release address for SMP bring-up.
- Corrected architectural timer PPIs and VGIC maintenance interrupt
  polarity to active-low.
- Aligned memory node unit-address with reg base address
  (@81000000).
- Removed 'arm,cpu-registers-not-fw-configured' property from the
  timer node.
- Collected Conor Dooley's Acked-by for the dt-binding patch.
- Link to v1: https://lore.kernel.org/r/20260624-upstream-axiado-ax3005-upstream-v1-0-c05bd0bc9124@axiado.com

---
Swark Yang (8):
      dt-bindings: arm: axiado: add AX3005 EVK
      dt-bindings: gpio: cdns: add Axiado AX3005 GPIO variant
      dt-bindings: i2c: cdns: add Axiado AX3005 I2C variant
      dt-bindings: i3c: cdns: add Axiado AX3005 I3C variant
      dt-bindings: serial: cdns: add Axiado AX3005 UART variant
      dt-bindings: spi: dw-apb-ssi: add Axiado AX3005 SPI variant
      dt-bindings: usb: generic-xhci: add Axiado AX3005 xHCI variant
      arm64: dts: axiado: Add initial support for AX3005 SoC and eval board

 Documentation/devicetree/bindings/arm/axiado.yaml  |   6 +
 .../devicetree/bindings/gpio/cdns,gpio.yaml        |   7 +-
 .../devicetree/bindings/i2c/cdns,i2c-r1p10.yaml    |  10 +-
 .../devicetree/bindings/i3c/cdns,i3c-master.yaml   |   1 +
 .../devicetree/bindings/serial/cdns,uart.yaml      |   1 +
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   4 +
 .../devicetree/bindings/usb/generic-xhci.yaml      |   4 +
 arch/arm64/boot/dts/axiado/Makefile                |   1 +
 arch/arm64/boot/dts/axiado/ax3005-evk.dts          | 327 ++++++++
 arch/arm64/boot/dts/axiado/ax3005.dtsi             | 842 +++++++++++++++++++++
 10 files changed, 1198 insertions(+), 5 deletions(-)
---
base-commit: 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
change-id: 20260617-upstream-axiado-ax3005-upstream-bb09780a2fdf

Best regards,
-- 
Swark Yang <syang@axiado.com>

