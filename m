Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC962C4338F
	for <linux-serial@archiver.kernel.org>; Sun, 22 Aug 2021 03:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB836124B
	for <linux-serial@archiver.kernel.org>; Sun, 22 Aug 2021 03:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhHVD20 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Aug 2021 23:28:26 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:7362 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbhHVD2Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Aug 2021 23:28:25 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26121c42b7db-f2047; Sun, 22 Aug 2021 11:27:41 +0800 (CST)
X-RM-TRANSID: 2ee26121c42b7db-f2047
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.250.151])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36121c429ec8-65203;
        Sun, 22 Aug 2021 11:27:41 +0800 (CST)
X-RM-TRANSID: 2ee36121c429ec8-65203
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, paul@crapouillou.net,
        jirislaby@kernel.org, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux@prisktech.co.nz
Cc:     linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 0/3] serial: Use of_device_get_match_data
Date:   Sun, 22 Aug 2021 11:28:03 +0800
Message-Id: <20210822032806.3256-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all:

This patch series replace 'of_match_device' with
'of_device_get_match_data', to make code cleaner and better.

Thanks

Tang Bin (3):
  serial: 8250_ingenic: Use of_device_get_match_data
  serial: tegra: Use of_device_get_match_data
  serial: vt8500: Use of_device_get_match_data

 drivers/tty/serial/8250/8250_ingenic.c | 6 ++----
 drivers/tty/serial/serial-tegra.c      | 6 ++----
 drivers/tty/serial/vt8500_serial.c     | 7 ++-----
 3 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.20.1.windows.1



