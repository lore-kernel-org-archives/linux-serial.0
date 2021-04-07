Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C232CC433ED
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501E6113B
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 10:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350889AbhDGKXd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235325AbhDGKXd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 06:23:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2867610D0;
        Wed,  7 Apr 2021 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617791004;
        bh=GVI/CJ7tbqSphedOWlTuzX+dxcsHHCkBtzLwBBxqfKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPFHdIjDtxtYxNYw7wnd34dvp0Fy6Ox3BIdt389hG+6ol/q5sz6uiFFHfe6GJph+p
         LpituZkQfOMI6WA+rwz5PU5DdsMRSo+6oJp/mCQNQLwqFfTE5S9t5FMo1uuprYKshS
         Tfade1EHSsNUonmYZlJt7Pap3h6dukLjAtbgLRzM=
Date:   Wed, 7 Apr 2021 12:23:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] serial: sh-sci: Respect deferred probe when
 getting IRQ
Message-ID: <YG2IGQ8f0n+joxom@kroah.com>
References: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 07, 2021 at 01:17:13PM +0300, Andy Shevchenko wrote:
> With platform_get_irq() and its optional variant it's possible to get
> a deferred probe error code. Since the commit ed7027fdf4ec ("driver core:
> platform: Make platform_get_irq_optional() optional") the error code
> can be distinguished from no IRQ case. With this, rewrite IRQ resource
> handling in sh-sci driver to follow above and allow to respect deferred
> probe.
> 
> Fixes: ed7027fdf4ec ("driver core: platform: Make platform_get_irq_optional() optional")

I've already reverted this commit, sorry.  Please feel free to resend
this as a patch series.

thanks,

greg k-h
