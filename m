Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D27C77B73
	for <linux-serial@archiver.kernel.org>; Tue,  6 Jun 2023 16:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjFFQVR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Jun 2023 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjFFQVQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jun 2023 12:21:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5960211A;
        Tue,  6 Jun 2023 09:21:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A24DC80AE;
        Tue,  6 Jun 2023 16:21:13 +0000 (UTC)
Date:   Tue, 6 Jun 2023 19:21:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: don't kfree device managed data
Message-ID: <20230606162112.GM56720@atomide.com>
References: <ZH7tsTmWY5b/4m+6@moroto>
 <ZH8xwKuI9WqRUu5H@smile.fi.intel.com>
 <20230606133749.GK56720@atomide.com>
 <ZH9IiAUeIf/pi+E1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH9IiAUeIf/pi+E1@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230606 14:54]:
> On Tue, Jun 06, 2023 at 04:37:49PM +0300, Tony Lindgren wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230606 13:16]:
> > > On Tue, Jun 06, 2023 at 11:26:25AM +0300, Dan Carpenter wrote:
> > > > The put_device() function will call serial_base_ctrl_release() or
> > > > serial_base_port_release() so these kfrees() are a double free bug.
> 
> ...
> 
> > > These labels are also called without device being even added.
> > > So, this is not good enough as far as I can tell.
> > 
> > I guess you mean the possibe error returned from the call to
> > serial_base_device_init()?
> > 
> > If serial_base_device_init() fails, we return error and end up doing
> > the put_device().
> > 
> > We have serial_base_device_init() call device_initialize(), is that
> > not enough for put_device()?
> 
> It's not. The error is returned when device release callback is not assigned
> yet.

OK thanks for clarifying.

> And also just noticed since we return deferred probe, the message there should
> be ratelimited or given only _once().

We should be OK with debug here like Dan suggested.

Regards,

Tony
