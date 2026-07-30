Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB8409273;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409595; cv=none; b=K6YzhSLja444kVVSGpndd9vYun8XehDYsYDgZUchxGZU5T8J4F1cVwDpV2WIeg57sKrQcnNGmzs0m71Pz4opVccx+PyHiUT+ROEWy3UDLk1pOgHMFGdTAf28Gc0GWE/qPKjYedBWMiKhQtY/mcBt5JTJQ8pNfzH/Fj1U2PG+NDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409595; c=relaxed/simple;
	bh=JJfiLbJ3fwSf+fMfQDgsOpGGAiaWQyVX3U4sg7NpQy8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QxJh1rX+xDTj+MLPeQ+ornmtWa8wKJnHLar7BLfh0kyE4v9XiR8mFprBqmeBxmxPvns3hZoSqe+JKXlg6S0bvz5S2zLoN2RhGEiGvwOXFVkCqOkP8mYz8QDj1VVKs16jVdvQ/7U2gc8B//O0FdVKx/UGNVcQBNvkWJbQU2GYS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=ZwinZ+Rr; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="ZwinZ+Rr"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA6Egi3332841;
	Thu, 30 Jul 2026 10:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=com20210415pp; bh=B6cfWYY
	HjbHbSBK9jmV76tchnVz9XZL5/OBjKoitaAM=; b=ZwinZ+Rrn+owSGRoCGjFkOv
	oCahNOH7dLjDIsCRc1FgIkTm+gGMCTHQt3vck5Hxp4qiOiJxRwELivMrFyWgV4Mj
	TXjSRv3wnKgK4cHBhmn7tfJo9rJmgzZEY78Az/BX0FIHADh0XDrOHwXwUp5iyzDB
	3qmj8HSLj3fUi9lBadgv4OTk9rKJ6x10ptQr/jWH/Opg1Bl8Ifg1rE2YSYb75FDV
	+bRynujtvwA+RtKiCvr9hxklb0i2kbtd38inAy3cfg7eTv5PWD6N9Agr/MSjBT3Z
	yXF8pn6+CQi1jAuYacFrsqXIAgwnXHFxUPCsOfjii5PDuQHi9r8B+imxOTbJzPQ=
	=
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:39 +0000 (GMT)
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambus-ex-se2.ambarella.net (10.1.4.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:37 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-cas3.ambarella.net (10.2.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Thu, 30 Jul 2026 18:43:36 +0800
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:34 +0800
From: Long Zhao <longzhao@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <soc@lists.linux.dev>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>, <linux-gpio@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        Long Zhao
	<longzhao@ambarella.com>
Subject: [PATCH 00/10] Ambarella CV75 SoC minimal bring-up
Date: Thu, 30 Jul 2026 18:43:20 +0800
Message-ID: <20260730104330.81367-1-longzhao@ambarella.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: QvM4xzgoxCOLYd73qqOIgifnYq3f3tNj
X-Proofpoint-ORIG-GUID: QvM4xzgoxCOLYd73qqOIgifnYq3f3tNj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX1tEdZe81ZO4K
 QUPuxLiDizW8+3XNrG4D/MWaVod+ialWZrPUV2BCCYtp7p6QCk5xaQDaDjwQszi8q6F1SAwoV33
 WmbyJcAML59SksXNAzZz8OFgstkSmk/mtjQ07X+vMNyUPxMqZ5TVlWZy7QzO1hCDJMs5zi8QOha
 pHmNZVkgSO4VoB4cqHByNCYIAE+//GWLw+OyFJlEGHFdgXArYf4QAcQaquaeq/n5tCPyQPEfqBi
 zqGOelsd5neibQ6Sdx0eTFIcu0kGxEk2r7+457mNKtJG3/m3uoXXM50z1EWBnV45VBd83bKfj8T
 6xx5+ESvIFddqKuD/olVZ39vCTdc/U9hZLQNUeJIRfU2AaInokXrzfonGMf+j2U2BNSJIuX5XYn
 tPB0eElLah2iI3a31OvdnY1/Do33KUnOBcRDBtOTb47O5vAMrc/MvIsR3CUQFyxt0eVCtdMn8PZ
 LKMzPYRdH01FfT3bPJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfXxeGiWCanzM/o
 +tPbj2ZnDJZUnL7aZmtSVWBhshynav+dwoOGtai8QjKipUziA5qnSH9pLRP5fgc5wrABnuxS1P0
 uQ5dMSrYGcrck01AR/7/K2pfw1JRu+cOp65frmshp9CLNZMi0CqO
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2adb cx=c_pps
 a=DgnZYc2JwZ3KnY28M5UqXQ==:117 a=DgnZYc2JwZ3KnY28M5UqXQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22
 a=KblO7da7ppA7TBl3N-nE:22 a=2LzS6VQafNHXJvlkB2cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

This series adds minimal Ambarella CV75 support sufficient for early
bring-up with a serial console.

It introduces DT bindings and drivers for the RCT clock controller,
pinctrl, and UART, plus ARCH_AMBARELLA, a minimal CV75 EVK device tree,
arm64 defconfig entries, and a MAINTAINERS entry.

The goal of this first submission is a small, reviewable console-capable
baseline. Further SoC peripherals can follow in later series.

The series is based on linux-next. It has been booted on CV75
hardware with the serial console working.

Testing:
 - Booted to console on CV75 EVK with initramfs
 - scripts/checkpatch.pl --strict
 - make dt_binding_check DT_SCHEMA_FILES=3Dambarella

Long Zhao (10):
  dt-bindings: arm: add Ambarella CV75 platforms
  dt-bindings: soc: add Ambarella secure scratchpad
  dt-bindings: clock: add Ambarella CV75 RCT clock controller
  dt-bindings: pinctrl: add Ambarella CV75 pinctrl
  dt-bindings: serial: add Ambarella UART
  clk: ambarella: add CV75 CCU driver
  pinctrl: ambarella: add Ambarella pin controller
  serial: ambarella: add Ambarella UART driver
  arm64: ambarella: add ARCH_AMBARELLA and CV75 EVK DT
  MAINTAINERS: add ARM/AMBARELLA SoC support

 .../devicetree/bindings/arm/ambarella.yaml    |   23 +
 .../bindings/clock/ambarella,cv75-rct.yaml    |   94 +
 .../pinctrl/ambarella,cv75-pinctrl.yaml       |  167 ++
 .../bindings/serial/ambarella,uart.yaml       |   55 +
 .../ambarella/ambarella,sec-scratchpad.yaml   |   41 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |   18 +
 arch/arm64/Kconfig.platforms                  |    9 +
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/ambarella/Makefile        |    3 +
 arch/arm64/boot/dts/ambarella/cv75-evk.dts    |   30 +
 arch/arm64/boot/dts/ambarella/cv75.dtsi       |  151 ++
 arch/arm64/configs/defconfig                  |    3 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/ambarella/Kconfig                 |   16 +
 drivers/clk/ambarella/Makefile                |    6 +
 drivers/clk/ambarella/ccu-cv75.c              |  296 ++++
 drivers/clk/ambarella/ccu_common.c            |   60 +
 drivers/clk/ambarella/ccu_common.h            |   25 +
 drivers/clk/ambarella/ccu_mux_div.c           |  223 +++
 drivers/clk/ambarella/ccu_mux_div.h           |   35 +
 drivers/clk/ambarella/ccu_pll.c               |  374 ++++
 drivers/clk/ambarella/ccu_pll.h               |   70 +
 drivers/pinctrl/Kconfig                       |   15 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-ambarella.c           | 1561 +++++++++++++++++
 drivers/tty/serial/Kconfig                    |   21 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/ambarella_uart.c           |  937 ++++++++++
 .../dt-bindings/clock/ambarella,cv75-clock.h  |   17 +
 .../dt-bindings/pinctrl/ambarella,pinctrl.h   |   11 +
 32 files changed, 4268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ambarella.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ambarella,cv75-=
rct.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ambarella,cv7=
5-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/ambarella,uart=
.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/ambarella/ambarel=
la,sec-scratchpad.yaml
 create mode 100644 arch/arm64/boot/dts/ambarella/Makefile
 create mode 100644 arch/arm64/boot/dts/ambarella/cv75-evk.dts
 create mode 100644 arch/arm64/boot/dts/ambarella/cv75.dtsi
 create mode 100644 drivers/clk/ambarella/Kconfig
 create mode 100644 drivers/clk/ambarella/Makefile
 create mode 100644 drivers/clk/ambarella/ccu-cv75.c
 create mode 100644 drivers/clk/ambarella/ccu_common.c
 create mode 100644 drivers/clk/ambarella/ccu_common.h
 create mode 100644 drivers/clk/ambarella/ccu_mux_div.c
 create mode 100644 drivers/clk/ambarella/ccu_mux_div.h
 create mode 100644 drivers/clk/ambarella/ccu_pll.c
 create mode 100644 drivers/clk/ambarella/ccu_pll.h
 create mode 100644 drivers/pinctrl/pinctrl-ambarella.c
 create mode 100644 drivers/tty/serial/ambarella_uart.c
 create mode 100644 include/dt-bindings/clock/ambarella,cv75-clock.h
 create mode 100644 include/dt-bindings/pinctrl/ambarella,pinctrl.h

--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
