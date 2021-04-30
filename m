Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824E6C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453C661186
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhD3Rvh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Apr 2021 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhD3Rvh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 13:51:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70AC06174A;
        Fri, 30 Apr 2021 10:50:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1F2961F43C63
Received: by jupiter.universe (Postfix, from userid 1000)
        id F0ED14800BA; Fri, 30 Apr 2021 19:50:44 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Ian Ray <ian.ray@ge.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, kernel@collabora.com
Subject: [PATCHv5 0/2] Fix imx53-ppd UART configuration
Date:   Fri, 30 Apr 2021 19:50:36 +0200
Message-Id: <20210430175038.103226-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

IMHO PATCHv4 was better, but in the end I don't have strong feelings
about this. Btw. I think this patchset is a good demonstration of
frustrating upstream kernel development can be considering PATCHv5
is basically the same as PATCHv1. Thanks for making us go in
circles :(

Changes since PATCHv4:
 * https://lore.kernel.org/lkml/20210305115058.92284-1-sebastian.reichel@collabora.com/
 * use DT property instead of sysfs config option, like the initial patch
   version did as requested by Greg.

Changes since PATCHv3:
 * https://lore.kernel.org/lkml/1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com/
 * rewrote commit message to provide a lot more details why this is needed
 * rebased to torvalds/master (5.12-rc1-dontuse), also applies on top of linux-next
 * use sysfs_emit() instead of sprintf

-- Sebastian

Fabien Lahoudere (2):
  serial: imx: Add DMA buffer configuration via DT
  ARM: dts: imx53-ppd: add dma-info nodes

 .../bindings/serial/fsl-imx-uart.yaml         | 12 +++++++++
 arch/arm/boot/dts/imx53-ppd.dts               |  2 ++
 drivers/tty/serial/imx.c                      | 25 +++++++++++++------
 3 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.30.2

