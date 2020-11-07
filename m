Return-Path: <SRS0=t3fu=EN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04718C5517A
	for <linux-serial@archiver.kernel.org>; Sat,  7 Nov 2020 03:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60A620882
	for <linux-serial@archiver.kernel.org>; Sat,  7 Nov 2020 03:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgKGDjI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Nov 2020 22:39:08 -0500
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:55921 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgKGDjH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Nov 2020 22:39:07 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id 1E156582166;
        Sat,  7 Nov 2020 11:29:37 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH 0/2] drivers/tty: delete break after return or goto
Date:   Fri,  6 Nov 2020 19:29:22 -0800
Message-Id: <20201107032924.25044-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTRkdTUxJSkgdTBgZVkpNS09MSkJMTExPTU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006FCo6Hj8pKxw3GlEdTTAT
        LDlPChdVSlVKTUtPTEpCTExMQ0hCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUpDSEI3Bg++
X-HM-Tid: 0a75a0c0965598b6kuuu1e156582166
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, Greg:

This patch sereies delete code which never run:
{
case XXX:
	return XXX;
	break; //The break is meanless, so just delete it.
case YYY:
	goto YYY;
	break; //The break is meanless, so just delete it.
......
}

Bernard Zhao (2):
  tty/serial: delete break after return
  drivers/tty: delete break after goto/return

 drivers/tty/nozomi.c     | 4 ----
 drivers/tty/serial/imx.c | 5 -----
 2 files changed, 9 deletions(-)

-- 
2.29.0

