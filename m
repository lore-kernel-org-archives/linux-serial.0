Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1197BC49EA7
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 04:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C546195B
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 04:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhFZEN0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Jun 2021 00:13:26 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60026 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFZENX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Jun 2021 00:13:23 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 01B3392009C; Sat, 26 Jun 2021 06:10:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F08EE92009B;
        Sat, 26 Jun 2021 06:10:57 +0200 (CEST)
Date:   Sat, 26 Jun 2021 06:10:57 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     linux-serial@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 0/2] serial, Malta: Fixes to make the CBUS UART work
 big-endian
Message-ID: <alpine.DEB.2.21.2106260509300.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

 Earlier this year I noticed the CBUS UART, a discrete TI16C550C part 
wired directly to the system controller's device bus and supposed to come 
up as ttyS2 in addition to ttyS0 and ttyS1 ports from a Super I/O device 
behind the PCI southbridge, is not recognised with my MIPS Malta board 
booting big-endian.

 I got to the bottom of the problem now and as it turns out we have two 
long-standing bugs causing it, one in generic 8250 code and another in 
Malta platform code, and this has never worked in the big-endian mode.  

 Here's v2 of the series, addressing minor issues with 1/2 pointed out in 
the review.

 Please apply.

  Maciej
