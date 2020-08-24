Return-Path: <SRS0=CzRg=CC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184CAC433E1
	for <linux-serial@archiver.kernel.org>; Mon, 24 Aug 2020 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F1B20738
	for <linux-serial@archiver.kernel.org>; Mon, 24 Aug 2020 17:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHXR35 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:29:57 -0400
Received: from elvis.franken.de ([193.175.24.41]:60888 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgHXR3R (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Aug 2020 13:29:17 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kAGHL-0001z8-00; Mon, 24 Aug 2020 19:29:07 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 217BCC0DE1; Mon, 24 Aug 2020 19:28:50 +0200 (CEST)
Date:   Mon, 24 Aug 2020 19:28:50 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 00/12] Convert WAR defines to config options
Message-ID: <20200824172850.GA11179@alpha.franken.de>
References: <20200824163257.44533-1-tsbogend@alpha.franken.de>
 <430f374e-d87e-0302-5b83-70670125f873@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430f374e-d87e-0302-5b83-70670125f873@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 24, 2020 at 10:10:07AM -0700, Florian Fainelli wrote:
> On 8/24/20 9:32 AM, Thomas Bogendoerfer wrote:
> > This patches convert workaround (WAR) defines into config options and
> > gets rid of mach-*/war.h files.
> 
> Most (all but octeon?) of those platforms are not particularly popular
> or widespread, but is not this going to make it harder for distributions
> and people doing CI by having an explosion in the number of
> configurations to test?

all options are only selected by arch/mips/Kconfig, so nothing should
change for any CI.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
