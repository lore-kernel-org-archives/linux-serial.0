Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E610BEB64DB
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jun 2023 04:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjFNEqL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jun 2023 00:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFNEqK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jun 2023 00:46:10 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0A4DC5;
        Tue, 13 Jun 2023 21:46:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C231780F9;
        Wed, 14 Jun 2023 04:46:08 +0000 (UTC)
Date:   Wed, 14 Jun 2023 07:46:07 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: don't kfree device managed data
Message-ID: <20230614044607.GF14287@atomide.com>
References: <ZH7tsTmWY5b/4m+6@moroto>
 <ZH8xwKuI9WqRUu5H@smile.fi.intel.com>
 <c1a2467b-7a30-4eaa-9206-3b47d3ae64e6@kadam.mountain>
 <ZH9I1DCyfa8tEzIz@smile.fi.intel.com>
 <dbd168c0-1ef2-4270-b6e2-3a489cdf6a14@kadam.mountain>
 <20230606161840.GL56720@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606161840.GL56720@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Dan,

* Tony Lindgren <tony@atomide.com> [230606 19:18]:
> * Dan Carpenter <dan.carpenter@linaro.org> [230606 15:01]:
> > On Tue, Jun 06, 2023 at 05:55:16PM +0300, Andy Shevchenko wrote:
> > > 
> > > I'm okay with the above, but it seems at the same time we need to limit the
> > > messages:
> > > 
> > > 	dev_err_once(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
> > > 
> > 
> > Yeah.  I would prefer if that was only printed as a debug message.
> > -EPROBE_DEFER is supposed to be a normal part of the process.
> 
> Debug here should do the trick yeah.

Just wondering.. Are you going to send this fix or do you want me to type
it up?

Regards,

Tony
