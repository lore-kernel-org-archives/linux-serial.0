Return-Path: <SRS0=+uUE=36=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A268C35254
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 04:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7F2208C4
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 04:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJEBT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 9 Feb 2020 23:01:19 -0500
Received: from muru.com ([72.249.23.125]:54062 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgBJEBS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 9 Feb 2020 23:01:18 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 1EC3F8081;
        Mon, 10 Feb 2020 04:02:01 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>,
        Johan Hovold <johan@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/4] n_gsm serdev support and mfd driver for droid4 modem
Date:   Sun,  9 Feb 2020 20:01:02 -0800
Message-Id: <20200210040107.10306-1-tony@atomide.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all,

Here's updated version of n_gsm serdev support with related MFD
driver for the modem found on Motorola Mapphone phones and tablets
like droid4.

This series only adds basic character device support for the MFD
driver, other serdev consumer drivers for specific devices will be
posted separately.

The patches are against v5.6-rc1, please review and test,

Regards,

Tony


Changes since v1:

- Simplified usage and got rid of few pointless inline functions
- Added consumer MFD driver, devicetree binding, and dts changes

Tony Lindgren (4):
  tty: n_gsm: Add support for serdev drivers
  mfd: motmdm: Add Motorola TS 27.010 serdev modem driver for droid4
  dt-bindings: mfd: motmdm: Add binding for motorola-mdm
  ARM: dts: omap4-droid4: Enable basic modem support

 .../mfd/motorola,mapphone-mdm6600.yaml        |   37 +
 .../boot/dts/motorola-mapphone-common.dtsi    |    6 +
 drivers/mfd/Kconfig                           |    8 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/motorola-mdm.c                    | 1204 +++++++++++++++++
 drivers/tty/n_gsm.c                           |  372 +++++
 include/linux/serdev-gsm.h                    |  168 +++
 7 files changed, 1796 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml
 create mode 100644 drivers/mfd/motorola-mdm.c
 create mode 100644 include/linux/serdev-gsm.h

-- 
2.25.0
