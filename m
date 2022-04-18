Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B011C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 18 Apr 2022 05:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiDRFfw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Apr 2022 01:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiDRFfw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Apr 2022 01:35:52 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C702C13E12;
        Sun, 17 Apr 2022 22:33:13 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Mon, 18 Apr 2022
 13:33:09 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V2 0/2] Add q 12MHz internal clock rate to calculate
Date:   Mon, 18 Apr 2022 13:32:00 +0800
Message-ID: <20220418053202.24528-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

1.Added 12Mhz as the clock source for calculating baud rate.

2.Added S4 SOC compatibility. 

Yu Tu (2):
  tty: serial: meson: Add a 12MHz internal clock rate to calculate baud
    rate in order to meet the baud rate requirements of special BT
    modules
  tty: serial: meson: Added S4 SOC compatibility

V1 -> V2: Change format as discussed in the email.

Link:https://lore.kernel.org/linux-amlogic/20220407081355.13602-3-yu.tu@amlogic.com/

 drivers/tty/serial/meson_uart.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)


base-commit: f398e0aa325c61fa20903833a5b534ecb8e6e418
-- 
2.33.1

