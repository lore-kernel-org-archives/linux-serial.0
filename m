Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235E6C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 08:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiFOI3m (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345028AbiFOI3T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 04:29:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB6133E10;
        Wed, 15 Jun 2022 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655281758; x=1686817758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zOK8QFqvftAZi3/z0cv6PPWHLAU9HWQJ53pRU+8Ya2w=;
  b=Agrd8VYS71SLQi9NvbiBi3gg19fOd6FwTV2zTs5frQWZgETKkX4G/pK+
   +dFNi44+tQdE00RFW+bvq1V/InZ7/xi0E1lVGGnNjKpY/h4C4V//u46SM
   HkjC6Wn7JZ1PXyHp/Cy+dhbl/iRlmsSbeAd8wnjINf6KmDcDoGIfGe/In
   uMRvWRt18yy365wrSPyVNO/N6Pekl6deiZwWkN9iiFbzFkmjlzPc8Hz6b
   9NtQWRmV4BY8Wfr3Gkcn1Qkb6uq79Yhj5vJ40KHv1U2WZA8kEv5SirP1S
   M5y8XU84JCjsHMWpPysbzKZMNGGsrAo63Sox21rqVLoXBCqB98dpQe+xA
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="178025144"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 01:29:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 01:29:18 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Jun 2022 01:29:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/4] serial: atmel: cleanup code
Date:   Wed, 15 Jun 2022 11:31:40 +0300
Message-ID: <20220615083144.1882142-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

The following patches does some cleanup for atmel_serial driver by
switching to dev_pm_ops and improving clock management code. Along with
it I took the chance and introduced a patch for st-asc which removes the
include of pm_runtime.h.

Thank you,
Claudiu Beznea

Changes in v2:
- split patch 2/3 from v1 in patch 2/4 and patch 3/4 in this
  series
- collected tags

Claudiu Beznea (4):
  tty: serial: atmel: stop using legacy pm ops
  tty: serial: atmel: use devm_clk_get()
  tty: serial: atmel: remove enable/disable clock due to
    atmel_console_setup()
  serial: st-asc: remove include of pm_runtime.h

 drivers/tty/serial/atmel_serial.c | 93 +++++++++----------------------
 drivers/tty/serial/st-asc.c       |  1 -
 2 files changed, 26 insertions(+), 68 deletions(-)

-- 
2.34.1

