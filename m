Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8BC4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 21:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE7E2083B
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgKDVaK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKDVaJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 16:30:09 -0500
X-Greylist: delayed 4601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Nov 2020 13:30:09 PST
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C8C0613D3;
        Wed,  4 Nov 2020 13:30:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 16C7DC21;
        Wed,  4 Nov 2020 22:30:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7gAZfkZ-VP_y; Wed,  4 Nov 2020 22:30:07 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 2977D29E;
        Wed,  4 Nov 2020 22:30:07 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kaQM1-003eHu-Ok; Wed, 04 Nov 2020 22:30:05 +0100
Date:   Wed, 4 Nov 2020 22:30:05 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Matthias Reichl <hias@horus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crash when specifying non-existent serial port in speakup /
 tty_kopen
Message-ID: <20201104213005.khivjvcwkaz7kz4g@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Matthias Reichl <hias@horus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201104145737.GA11024@camel2.lan>
 <20201104201323.dzyt73tbd2jykcrt@function>
 <20201104211504.GA20012@lenny.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104211504.GA20012@lenny.lan>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Matthias Reichl, le mer. 04 nov. 2020 22:15:05 +0100, a ecrit:
> > This looks like only a warning, did it actually crash?
> 
> Yes, scroll down a bit, the null pointer oops followed almost
> immediately after that
> 
> [   49.979043] BUG: kernel NULL pointer dereference, address: 0000000000000090

Ah, [   50.102938]  tty_init_dev+0xb5/0x1d0

probably the trailing release_tty call that does

tty->port->itty = NULL;
(itty is after a struct tty_bufhead + the tty pointer, that looks
plausible).

so probably an if (tty->port) in release_tty could help?

Samuel
