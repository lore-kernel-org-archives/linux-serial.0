Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A30EC43217
	for <linux-serial@archiver.kernel.org>; Fri, 11 Mar 2022 09:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbiCKJqe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241803AbiCKJq2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Mar 2022 04:46:28 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC51BE4DB;
        Fri, 11 Mar 2022 01:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646991924;
  x=1678527924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jeowJQyOgKZ6cqeMbAKF3JC/lNT1RzSMTT/8wHCaDkk=;
  b=S03M0fhRJ4Tvi/6pdKjjoPz7oGAQB81kq8mXEjsFCPvLJVkNMpJ6frd9
   KRgCqQLd+NoKejQZU4mWOXigY92hO8CyKqKQ7fDPKIg5Nu7Lq0Ue1i1LP
   0RYPPyVMFPlV/jc8wuXC0qbdvbPHTva1c0hJjULRoHsEobB7imQQjj5HO
   YY3DfTBnYcCpb5rm9w7J4TIZHR7bM9UfK7w5woDIxykF4FiDdnVxliSwe
   qJ8QAScwnBtag2/Fsw6QIyjSEU+2n3jCDTlDui3X1oUVw1l8kVOzMCgZ/
   WHO+/YrM/InQuBgPLa5nJqkp193c3WTxDlrIwGHkICyYW2JA/nAx+iIbF
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <krzysztof.kozlowski@canonical.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <alim.akhtar@samsung.com>
Subject: [PATCH v2 0/2] Add support for ARTPEC-8 UART
Date:   Fri, 11 Mar 2022 10:45:13 +0100
Message-ID: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series adds support for the UART hardware on the ARTPEC-8 chip.  This
block is already supported by an existing driver so only a small patch to
describe the properties of the variant is required.

v2:
- This version is based on top of Krzysztof's "minor fixes/cleanups" series
  since they will conflict otherwise.
- Expand commit messages
- Define required clocks in binding
- Fix FIFO size

Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org
Cc: alim.akhtar@samsung.com

Vincent Whitchurch (2):
  dt-bindings: serial: samsung: Add ARTPEC-8 UART
  tty: serial: samsung: Add ARTPEC-8 support

 .../bindings/serial/samsung_uart.yaml         |  2 +
 drivers/tty/serial/Kconfig                    |  2 +-
 drivers/tty/serial/samsung_tty.c              | 37 +++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.34.1

