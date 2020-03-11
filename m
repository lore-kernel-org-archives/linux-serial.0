Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8045C10F29
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84481222C3
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgCKFGz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:06:55 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:42626 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgCKFGw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 01:06:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B7691181D3025;
        Wed, 11 Mar 2020 05:06:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jewel27_1e8115a6f7d16
X-Filterd-Recvd-Size: 2301
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:49 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:19 -0700
Message-Id: <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/tty/serial/8250/8250_uniphier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index e0b73a5..a2978ab 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -75,7 +75,7 @@ static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
 		break;
 	case UART_LCR:
 		valshift = 8;
-		/* fall through */
+		fallthrough;
 	case UART_MCR:
 		offset = UNIPHIER_UART_LCR_MCR;
 		break;
@@ -101,7 +101,7 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 	case UART_SCR:
 		/* No SCR for this hardware.  Use CHAR as a scratch register */
 		valshift = 8;
-		/* fall through */
+		fallthrough;
 	case UART_FCR:
 		offset = UNIPHIER_UART_CHAR_FCR;
 		break;
@@ -109,7 +109,7 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 		valshift = 8;
 		/* Divisor latch access bit does not exist. */
 		value &= ~UART_LCR_DLAB;
-		/* fall through */
+		fallthrough;
 	case UART_MCR:
 		offset = UNIPHIER_UART_LCR_MCR;
 		break;
-- 
2.24.0

