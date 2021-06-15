Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B8C48BE5
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A72C6157F
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 14:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhFOO15 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhFOO1o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 10:27:44 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D6FAC0698DF;
        Tue, 15 Jun 2021 07:19:05 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4FC5E9200B3; Tue, 15 Jun 2021 16:19:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 49ADF92009D;
        Tue, 15 Jun 2021 16:19:03 +0200 (CEST)
Date:   Tue, 15 Jun 2021 16:19:03 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
In-Reply-To: <YMiX7LAEtL0uQuVl@kroah.com>
Message-ID: <alpine.DEB.2.21.2106151602120.61948@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk> <YMiX7LAEtL0uQuVl@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 15 Jun 2021, Greg Kroah-Hartman wrote:

> This patch series causes the following build warning to be added:
> 
> drivers/tty/serial/8250/8250_pci.c: In function ‘pci_oxsemi_tornado_setup’:
> drivers/tty/serial/8250/8250_pci.c:1258:32: warning: unsigned conversion from ‘int’ to ‘unsigned char’ changes value from ‘-129’ to ‘127’ [-Woverflow]
>  1258 |                 up->mcr_mask = ~UART_MCR_CLKSEL;
>       |                                ^
> 
> 
> Can you fix this up and resend?

 I've seen that, but that's not a problem with my change, but rather with 
<linux/serial_reg.h> making this macro (and the remaining ones from this 
group) expand to a signed constant (0x80 rather than 0x80u).

 I can fix the header, but that would be a separate change, and mind too 
that this is a user header, so it's not clear to me what the impact might 
be on user apps making use of it.

 We could use a GCC pragma to suppress the warning temporarily across this 
piece of code, but it's not clear to me either what our policy has been on 
such approach.

 Thoughts?

 NB casting UART_MCR_CLKSEL here to an unsigned type does not help as GCC
still sees the original constant through the cast; I've already tried that 
of course.

 Last but not least: do we need to have this warning enabled in the first 
place?

  Maciej
