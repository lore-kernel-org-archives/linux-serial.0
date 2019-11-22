Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E7C432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E625120714
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 10:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfKVKeF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:34:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfKVKeF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 05:34:05 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iY6GI-0002wX-Nd; Fri, 22 Nov 2019 11:34:02 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iY6GF-0003jP-8l; Fri, 22 Nov 2019 11:33:59 +0100
Date:   Fri, 22 Nov 2019 11:33:59 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "festevam@gmail.com" <festevam@gmail.com>, kernel@pengutronix.de,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH tty/serial 1/1] tty: serial: imx: fix sysrq lockdep issue
Message-ID: <20191122103359.fud44lh5wl5d3gxe@pengutronix.de>
References: <1574416632-32321-1-git-send-email-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574416632-32321-1-git-send-email-fugang.duan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Fri, Nov 22, 2019 at 10:00:53AM +0000, Andy Duan wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> commit dbdda842fe96 ("printk: Add console owner and waiter logic to
> load balance console writes") introduces the lockdep issue for imx
> serial driver in sysrq case:
>      CPU0                    CPU1
>      ----                    ----
> lock(&port_lock_key);
>                              lock(console_owner);
>                              lock(&port_lock_key);
> lock(console_owner);
> 
> It should unlock port_lock_key in handle_sysrq().

I already discussed this problem some time ago but then failed to
complete the topic. You might want to look at the old discussion, see
https://www.spinics.net/lists/kernel/msg3266353.html.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
