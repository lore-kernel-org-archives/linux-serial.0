From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: [PATCHv2 0/2] tty: serial: fsl_lpuart: add 32-bit register support and dt-binding
Date: Mon, 14 Jul 2014 17:41:09 +0800
Message-ID: <1405330871-9038-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-by2lp0239.outbound.protection.outlook.com ([207.46.163.239]:54996
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752879AbaGNK13 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jul 2014 06:27:29 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This two patches change the fsl-lpuart dt-binding to exact SoC product revision
and add 32-bit big-endian register interface support which can be found on
Freescale LS1021A SoC platform.

---
changes in v2:
Fix undifined lpuart32_reg error.

----------------------------------------------------------------
Jingchang Lu (2):
      dt-binding: fsl-lpuart: use exact SoC revision to document binding
      tty: serial: fsl_lpuart: add 32-bit register interface support

 Documentation/devicetree/bindings/serial/fsl-lpuart.txt |   6 +-
 drivers/tty/serial/fsl_lpuart.c                         | 645 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 642 insertions(+), 9 deletions(-)


