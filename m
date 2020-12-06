Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B0BC433FE
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 11:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5151B229C4
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 11:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgLFLOC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 06:14:02 -0500
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:36018 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725767AbgLFLOC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 06:14:02 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Dec 2020 06:14:02 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 2EF3418015424
        for <linux-serial@vger.kernel.org>; Sun,  6 Dec 2020 11:04:59 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EF590181D337B;
        Sun,  6 Dec 2020 11:04:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pigs78_0c0172f273d5
X-Filterd-Recvd-Size: 3318
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Dec 2020 11:04:16 +0000 (UTC)
Message-ID: <ddd2feaa6dd064b20cb7015a2e569a92484dccdd.camel@perches.com>
Subject: Re: [PATCH 1/8] tty: serial: jsm: Fixed file by added more spacing
From:   Joe Perches <joe@perches.com>
To:     Clement Smith <rclemsmith@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 06 Dec 2020 03:04:11 -0800
In-Reply-To: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
References: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 2020-12-06 at 13:09 +0530, Clement Smith wrote:
> Fixed a coding style issue

Don't send 8 identically titled patches that each change a single line.

Send one patch, with an updated title like:

	Subject: [PATCH] jsm_tty: Whitespace neatening

that changes _all_ the whitespace that you believe should be updated.

And ideally, instead of just whitespace changes, the code would be
updated to eliminate the code duplication by using temporaries and a
single line conversion.

> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
[]
> @@ -607,7 +607,7 @@ void jsm_input(struct jsm_channel *ch)
>  				 * Give the Linux ld the flags in the
>  				 * format it likes.
>  				 */
> -				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
> +				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
>  					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
>  				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
>  					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);

Something like:
---
 drivers/tty/serial/jsm/jsm_tty.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 689774c073ca..b48ca17f38d3 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -607,14 +607,20 @@ void jsm_input(struct jsm_channel *ch)
 				 * Give the Linux ld the flags in the
 				 * format it likes.
 				 */
-				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
+				u8 error = ch->ch_equeue[tail + i];
+				u8 read = ch->ch_rqueue[tail + i];
+				int type;
+
+				if (error & UART_LSR_BI)
+					type = TTY_BREAK;
+				else if (error & UART_LSR_PE)
+					type = TTY_PARITY;
+				else if (error & UART_LSR_FE)
+					type = TTY_FRAME;
 				else
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
+					type = TTY_NORMAL;
+				tty_insert_flip_char(port, read, type);
+
 			}
 		} else {
 			tty_insert_flip_string(port, ch->ch_rqueue + tail, s);


