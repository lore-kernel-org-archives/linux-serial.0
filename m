Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A2C4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 10:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F63223FD
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 10:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgKDKxu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:53:50 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:35314 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKDKxq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 05:53:46 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.156])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id ABD7B482CFA;
        Wed,  4 Nov 2020 18:53:42 +0800 (CST)
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
Date:   Wed,  4 Nov 2020 02:53:29 -0800
Message-Id: <20201104105331.16654-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh4dSB5OSEseHUhKVkpNS09PQ0xJSUlCTUlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Dww5Ej8iAR8fKUwCCAo3
        SzgKCzlVSlVKTUtPT0NMSUlIT0NMVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5NWVdZCAFZQUpCS0k3Bg++
X-HM-Tid: 0a7592e4167893bakuwsabd7b482cfa
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch sereies optimise code like:
{
case XXX:
	return XXX;
	break; //The break is meanless, so just delete it.
case YYY:
	goto YYY;
	break; //The break is meanless, so just delete it.
......
}

Signed-off-by: Bernard Zhao <bernard@vivo.com>

---
Bernard Zhao (2):
  drivers/tty/nozomi.c: delete no use break after goto
  drivers/tty/serial/imx.c: delete no use break after return

 drivers/tty/nozomi.c     | 4 ----
 drivers/tty/serial/imx.c | 5 -----
 2 files changed, 9 deletions(-)

-- 
2.29.0

