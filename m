Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1707FC7EE23
	for <linux-serial@archiver.kernel.org>; Tue, 23 May 2023 08:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjEWI70 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 May 2023 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjEWI7W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 May 2023 04:59:22 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B8133;
        Tue, 23 May 2023 01:59:09 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 9EEA71C000A;
        Tue, 23 May 2023 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684832347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=n5OoiN38+Tb5qIVrVBMydqviPDrb5KnWgUBxvNt3wp4=;
        b=odkNJNXzegTUbmKcjoDx9lyrTjHB5WVsnumGgwV3sFrCw2GLFG/eejqhRQgBz6CEbgdXgh
        oGbjFSO3lkfLPaMRGOnQ52TAdfh5844E0khwB/z7kOnsWhor6lE/a+gvCYXlnsIQyQolYF
        pFbHcLtnBsRKX7+CL5Ca/1IrifMpiSDgCI/nqlNuUcJ3tQqkwlTi8fTjXDQeGpqW3kap1A
        8/8bQPHYntAzghpWXH6h8aP0Rkf/04sI3041ziIplpDzrKtOguPYmHlyOC+OD4Ml5OkkW5
        s0m1r5uy+qFvsRxlbZU66ZUPIkXlBiB8xvssHRsEYH6NouiK9+xFrZSQqwe0EQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/2] Fix COMPILE_TEST dependencies for CPM uart, TSA and QMC
Date:   Tue, 23 May 2023 10:59:00 +0200
Message-Id: <20230523085902.75837-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series fixes issues raised by the kernel test robot
  https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/

In COMPILE_TEST configurations, TSA and QMC need CONFIG_CPM to be set in
order to compile and CPM uart needs CONFIG_CPM2.

Compare to the previous iteration
  https://lore.kernel.org/linux-kernel/20230522082048.21216-1-herve.codina@bootlin.com/
this v2 series fully removes COMPILE_TEST from the CPM uart
dependencies.

Best regards,
Hervé

Changes v1 -> v2
 - Patch 2
   Remove COMPILE_TEST dependency

Herve Codina (2):
  soc: fsl: cpm1: Fix TSA and QMC dependencies in case of COMPILE_TEST
  serial: cpm_uart: Fix a COMPILE_TEST dependency

 drivers/soc/fsl/qe/Kconfig             | 4 ++--
 drivers/tty/serial/Kconfig             | 2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.40.1

