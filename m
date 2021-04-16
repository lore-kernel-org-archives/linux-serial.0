Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53E0C43460
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF91610F7
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbhDPOL6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244099AbhDPOLx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Apr 2021 10:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8BEC61184;
        Fri, 16 Apr 2021 14:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618582288;
        bh=RbEk1jw6IaZjWEoMENUnrfOM8eKQp0DhaXfiKPCopFI=;
        h=From:To:Cc:Subject:Date:From;
        b=aEdN9V16msvkNcbyBCrytXg/mDtHvkZoyk58irSCa4BcUv7axsE4CFpgN8awspn/F
         N94E8jUVEOEQz8vPcwJxZcr7yrjl9GvA3ewa/qDk4DuT19h9Q4nmPWV+QBA388BrBn
         WKM50zxReSVbPvdN12EBTGyWxkWiEs5OmYX4BY1FWI4ZvzBJtJdwequ+WYrhMbZ/zc
         Nbf5OGr1+JChX+jeLhix26D4Nyi9ZoSqH0aj3AziK4sNCLbPiNyN0Nf6dgeD8JUOj8
         HXjYYlghtEfSR9Kv0U9Ky7+q0YMSfp4XJ37hzmu8ZhQHDt+V0mjY8foWC8PfklhNdg
         0UBGvU2tHtFdg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lXPBx-0006a7-AQ; Fri, 16 Apr 2021 16:11:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dillon.minfei@gmail.com, Erwan Le Ray <erwan.leray@foss.st.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] serial: sysrq cleanup and stm32 fixes
Date:   Fri, 16 Apr 2021 16:05:54 +0200
Message-Id: <20210416140557.25177-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The first patch cleans up the interrupt handlers that rely on deferred
sysrq processing by not needlessly saving the interrupt state.

The second fixes the threaded interrupt handling of the stm32 driver
and properly fixes a couple of deadlocks that were incidentally worked
around by a recent commit.

The third patch cleans up the stm32 console implementation by switching
to deferred sysrq processing, thereby making the console code more
robust and allowing it to be used with PREEMPT_RT.

This series is against tty-next and and have only been compile tested.

Johan


Johan Hovold (3):
  serial: do not restore interrupt state in sysrq helper
  serial: stm32: fix threaded interrupt handling
  serial: stm32: defer sysrq processing

 drivers/tty/serial/8250/8250_aspeed_vuart.c |  5 ++-
 drivers/tty/serial/8250/8250_fsl.c          | 11 ++++---
 drivers/tty/serial/8250/8250_omap.c         |  6 ++--
 drivers/tty/serial/8250/8250_port.c         |  6 ++--
 drivers/tty/serial/qcom_geni_serial.c       |  6 ++--
 drivers/tty/serial/stm32-usart.c            | 36 ++++++++++-----------
 include/linux/serial_core.h                 | 10 +++---
 7 files changed, 39 insertions(+), 41 deletions(-)

-- 
2.26.3

