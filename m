Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1750EC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 07:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhKXHe2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 02:34:28 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:44373 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhKXHe1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 02:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637739078; x=1669275078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8WkWMBh7mhUC/fu+8ZsBr6oE6Yix9szdTfD51q4IMY=;
  b=KnOzPsqXziIN7Pl4iIH2i52V7Bve4s3MmutxvcWNWr83sw6op+4V2x3b
   hwabkhxqxSPLOqacZvqb8NGHfuGCEKAtJciucci2/zQ85hKVnBmmoWV8J
   AddQ1s2HqGfVRXrK29Y8mHHk7SFv5/Cn8psHqHrsNn37qNWgc5P9dqsYv
   5zmOYKIiyouxeTILmPDmnJmSgpp5OuwGu+5IcPO0cx6nEY8df0ZCwqC3O
   n/sP5cWMbO03izXN9KVuZXCrX8TLQNIlUjNeYIKm1/m/QrjlR0+c28F+k
   n35gBOWYSHyOKnQOh+GlpAu3KVHxMSvawOhnnqnDrv98J/3EbHZr5CMbH
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631570400"; 
   d="scan'208";a="20638338"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Nov 2021 08:31:16 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 24 Nov 2021 08:31:17 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 24 Nov 2021 08:31:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637739076; x=1669275076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8WkWMBh7mhUC/fu+8ZsBr6oE6Yix9szdTfD51q4IMY=;
  b=TGkYfNEOV7oB/FcXSD9erwQw71566D2YEcmEDQqA0EAV8GDW2BIB8zpZ
   4lR/Tyb6xydkeXYk1pfcziuMk3unHMJk+diDXXwlzV5LU79FfU0kyTYqI
   i5gDepr3IWrhjAKcEWD3MJjXo1l5wYvlEX/PlBvy0pMuv4ggDu8sxQJOs
   O+AWOZnO7u4jsnc/e95taW8l+eRjPpGdA33/Ke/qzUBARyx27SIhnMX+X
   mfme4tY+/0ysgpZlH0qizoJ7Si80GM5FarHdZKO0j9laPt7gZ0SoNvIpJ
   6HtsForpAXHw3IesJ7K2XsTHqFuMpDbT4VYQEaF5WJPKR6+HppsR94/gm
   A==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631570400"; 
   d="scan'208";a="20638337"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Nov 2021 08:31:16 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 34325280065;
        Wed, 24 Nov 2021 08:31:16 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] Revert "tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP"
Date:   Wed, 24 Nov 2021 08:31:09 +0100
Message-Id: <20211124073109.805088-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Revert commit b4b844930f27 ("tty: serial: fsl_lpuart: drop earlycon entry
for i.MX8QXP"), because this breaks earlycon support on imx8qm/imx8qxp.
While it is true that for earlycon there is no difference between
i.MX8QXP and i.MX7ULP (for now at least), there are differences
regarding clocks and fixups for wakeup support. For that reason it was
deemed unacceptable to add the imx7ulp compatible to device tree in
order to get earlycon working again.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Following the discussion from [1] and [2] lpuart should not be
considered compatible on i.MX/ULP and i.MX8XQP/i.MX8QM.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2021-November/698082.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2021-November/698318.html

 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b1e7190ae483..ac5112def40d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2625,6 +2625,7 @@ OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart", ls1028a_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
 
-- 
2.25.1

