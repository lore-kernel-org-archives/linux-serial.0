Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4C9C2BC11
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 08:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E25921BE5
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 08:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgINIJO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 04:09:14 -0400
Received: from muru.com ([72.249.23.125]:44632 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgINIJF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 04:09:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2F6CC804D;
        Mon, 14 Sep 2020 08:08:30 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:09:16 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] serial: core: fix console port-lock regression
Message-ID: <20200914080916.GI7101@atomide.com>
References: <20200909143101.15389-1-johan@kernel.org>
 <20200909143101.15389-3-johan@kernel.org>
 <20200909154815.GD1891694@smile.fi.intel.com>
 <20200910073527.GC24441@localhost>
 <20200910092715.GM1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910092715.GM1891694@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [200910 09:27]:
> +Cc: Tony, let me add Tony to the discussion.
> 
> On Thu, Sep 10, 2020 at 09:35:27AM +0200, Johan Hovold wrote:
> > And what about power management
> > which was the reason for wanting this on OMAP in the first place; tty
> > core never calls shutdown() for a console port, not even when it's been
> > detached using the new interface.
> 
> That is interesting... Tony, do we have OMAP case working because of luck?

8250_omap won't do anything unless autosuspend_timeout is configured for
the uart(s). If configured, then the 8250_omap will idle when console is
detached and the PM runtime usage count held by console is decremented, and
the configured autosuspend_timeout expires.

The console is still kept open by getty, so I don't see why shutdown() would
be called for the console port. But maybe I don't follow what you're
concerned about, let me know if you want me to check something :)

Regards,

Tony

