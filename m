Return-Path: <SRS0=VMdU=AA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDF5C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 11:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECF4207FC
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 11:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgFSL0o (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:26:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:58706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbgFSL0m (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jun 2020 07:26:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2AFDAF1F;
        Fri, 19 Jun 2020 11:26:39 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:26:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/6] console: unify return codes from ->setup() hook
Message-ID: <20200619112638.GL3617@alley>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
 <20200619093917.GK3617@alley>
 <20200619094726.GD2428291@smile.fi.intel.com>
 <20200619102132.GB310968@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619102132.GB310968@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri 2020-06-19 19:21:32, Sergey Senozhatsky wrote:
> On (20/06/19 12:47), Andy Shevchenko wrote:
> > On Fri, Jun 19, 2020 at 11:39:18AM +0200, Petr Mladek wrote:
> > > On Thu 2020-06-18 19:47:45, Andy Shevchenko wrote:
> [..]
> > > I am going to push it the following week via printk tree unless
> > > anybody complains.
> > 
> > Thanks, Petr, I guess you may also incorporate Sergey's patch
> > he proposed. Sergey, are you going to submit it officially?
> 
> I can send a patch, unless Petr has objections.

Go ahead :-)

Best Regards,
Petr
