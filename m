Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B81C433E2
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 18:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E735A207C4
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgESSV4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 14:21:56 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:40390 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgESSV4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 14:21:56 -0400
Received: from zenbar.fritz.box (pd95ef292.dip0.t-ipconnect.de [217.94.242.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 585E040AEC3;
        Tue, 19 May 2020 18:18:58 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 0/6] sc16is7xx: IrDA mode and threaded IRQs
Date:   Tue, 19 May 2020 20:21:41 +0200
Message-Id: <20200519182147.218713-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is v2 of the series.

v2:

 * Change single bool properties into an array
   (suggested by Rob Herring)
 * Add a patch first try TRIGGER_LOW and SHARED interrupts, and then
   fall back to FALLING edge if the IRQ controller fails to provide the
   former (suggested by Maarten Brock)
 * Add a patch to check for the device presence

Daniel Mack (4):
  sc16is7xx: Always use falling edge IRQ
  sc16is7xx: Use threaded IRQ
  sc16is7xx: Allow sharing the IRQ line
  sc16is7xx: Read the LSR register for basic device presence check

Pascal Huerst (2):
  dt-bindings: sc16is7xx: Add flag to activate IrDA mode
  sc16is7xx: Add flag to activate IrDA mode

 .../bindings/serial/nxp,sc16is7xx.txt         |  4 +
 drivers/tty/serial/sc16is7xx.c                | 73 +++++++++++++------
 2 files changed, 56 insertions(+), 21 deletions(-)

-- 
2.26.2

