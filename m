Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3FFC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 10:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9B20789
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 10:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHRKqs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:46:48 -0400
Received: from muru.com ([72.249.23.125]:40772 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgHRKqs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 06:46:48 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4FAF9810D;
        Tue, 18 Aug 2020 10:46:47 +0000 (UTC)
Date:   Tue, 18 Aug 2020 13:47:14 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] n_gsm: Fix write handling for zero bytes written
Message-ID: <20200818104714.GR2994@atomide.com>
References: <20200817135454.28505-1-tony@atomide.com>
 <1b8538a8-d8b6-4287-36e1-aa1e0863ff2d@kernel.org>
 <20200818095609.GQ2994@atomide.com>
 <ea5e0639-4419-c60b-059a-8fbd057fc6e3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea5e0639-4419-c60b-059a-8fbd057fc6e3@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [200818 10:14]:
> On 18. 08. 20, 11:56, Tony Lindgren wrote:
> > Hi,
> > 
> > * Jiri Slaby <jirislaby@kernel.org> [200818 08:24]:
> >> On 17. 08. 20, 15:54, Tony Lindgren wrote:
> >>> If write returns zero we currently end up removing the message
> >>> from the queue. Instead of removing the message, we want to just
> >>> break out of the loop just like we already do for error codes.
> >>
> >> When exactly does the only writer (gsmld_output) return zero for
> >> non-zero len parameter?
> > 
> > I ran into this when testing with the WIP serial core PM runtime
> > changes from Andy Shevchenko earlier. If there are also other
> > cases where we have serial drivers return 0, I don't know about
> > them.
> 
> Sorry, I don't understand: my gsmld_output() ignores the return value
> from drivers' write and returns something greater than zero or a
> negative error. What tree/SHA do you run?

Oh right, good catch. I also had my WIP serdev-ngsm patches applied
that uses gsm_serdev_output() and returns the bytes written. Andy's
patches do not touch n_gsm.c.

Hmm sounds like we should also start returning value also from
gsmld_output()? Any objections to making that change?

For reference, Andy's WIP serial cor PM runtime changes are at:

https://gitlab.com/andy-shev/next.git/ topic/uart/rpm-plus

Regards,

Tony
