Return-Path: <SRS0=RakX=7L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70BC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 05:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF8C207BC
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 05:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgE2FvG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 May 2020 01:51:06 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:56498 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2FvG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 01:51:06 -0400
Received: from zenbar.fritz.box (p57bc97c6.dip0.t-ipconnect.de [87.188.151.198])
        by mail.bugwerft.de (Postfix) with ESMTPSA id D3BF24230C3;
        Fri, 29 May 2020 05:51:04 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 0/2] sc16is7xx: IrDA mode and threaded IRQs
Date:   Fri, 29 May 2020 07:50:56 +0200
Message-Id: <20200529055058.1606910-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a resend of the first two patches of the series to bring IrDA
support to the sc16is7xx driver.

The "linux," prefix is now dropped from the DT property.

The patches are rebased on top of the other 4 that have already been
merged.

Pascal Huerst (2):
  dt-bindings: sc16is7xx: Add flag to activate IrDA mode
  sc16is7xx: Add flag to activate IrDA mode

 .../bindings/serial/nxp,sc16is7xx.txt         |  4 ++++
 drivers/tty/serial/sc16is7xx.c                | 20 +++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.26.2

