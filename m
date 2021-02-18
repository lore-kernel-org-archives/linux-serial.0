Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD4C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 07:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C6964D99
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 07:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBRHGt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Feb 2021 02:06:49 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:45825 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhBRHDn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Feb 2021 02:03:43 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 254F73A9C27
        for <linux-serial@vger.kernel.org>; Thu, 18 Feb 2021 06:53:37 +0000 (UTC)
Received: from windsurf.home (lfbn-cor-1-49-229.w86-211.abo.wanadoo.fr [86.211.141.229])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6020D20000C;
        Thu, 18 Feb 2021 06:51:30 +0000 (UTC)
Date:   Thu, 18 Feb 2021 07:51:27 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Alexander Shiyan <shc_work@mail.ru>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] Revert "serial: max310x: rework RX interrupt handling"
Message-ID: <20210218075127.5023d878@windsurf.home>
In-Reply-To: <20210218065553.864bbf0cc2b3d398504c5b95@mail.ru>
References: <20210217080608.31192-1-shc_work@mail.ru>
        <20210217235345.7326201b@windsurf.home>
        <20210218065553.864bbf0cc2b3d398504c5b95@mail.ru>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Thu, 18 Feb 2021 06:55:53 +0300
Alexander Shiyan <shc_work@mail.ru> wrote:

> I wrote a little inaccurately, I did not mean a physical interface RS-485,
> but rather a time-critical MODBUS protocol. (In our case it used on top on RS-485).

OK, so it's not about 232 vs 485.

> I do not know how best to solve this problem, it may be an additional parameter
> for the devicetree, but in this case it is not clear how to manage it if the
> devicetree is not used ...

No, it cannot be a parameter in the Device Tree, as what we're talking
about is not hardware description, but configuration of the hardware
for particular use cases.

> This could be a Kconfig item (but something's not very good either).
> Probably the best solution is to adapt some kind of IOCTL (or control via SYSFS).

Greg, Jiri, perhaps you could comment on what would be the appropriate
user-space interface to use or add to be able to configure such aspects
of a UART controller ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
