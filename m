Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D9C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8353720706
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 13:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHRNOZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:14:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:43760 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHRNOW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 09:14:22 -0400
IronPort-SDR: 6W+Z5Qg0U19Qf6mTezwEiV/l/nmIcsazURgZwtb4cvtTksYO58RnRT+QjURHYhqJ2blI5oAh7+
 jrQr+HViX8RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="239721046"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="239721046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 06:14:22 -0700
IronPort-SDR: C11I1yanpgMrEx772U0BmhqlpbZtBtIyHJ4Ihp0okQu5vVkXPTDl80TrCZGMn/J5/tAJFEDRF5
 tY2sNCfCLxPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326724846"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 06:14:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k81RO-009eUD-Vf; Tue, 18 Aug 2020 16:14:14 +0300
Date:   Tue, 18 Aug 2020 16:14:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] uart:8250: change lock order in serial8250_do_startup()
Message-ID: <20200818131414.GQ1891694@smile.fi.intel.com>
References: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
 <20200814095928.GK1891694@smile.fi.intel.com>
 <20200818125218.GC17612@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818125218.GC17612@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 18, 2020 at 02:52:18PM +0200, Petr Mladek wrote:
> On Fri 2020-08-14 12:59:28, Andy Shevchenko wrote:
> > On Fri, Aug 14, 2020 at 10:38:02AM +0900, Sergey Senozhatsky wrote:
> > > We have a number of "uart.port->desc.lock vs desc.lock->uart.port"
> > > lockdep reports coming from 8250 driver; this causes a bit of trouble
> > > to people, so let's fix it.
> > 
> > I guess we may add some tags here
> > 
> > Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Reported-by: Raul Rangel <rrangel@google.com>
> > BugLink: https://bugs.chromium.org/p/chromium/issues/detail?id=1114800
> > Link: https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/T/#u
> 
> "Link:" tag should point to the mail that is applied using git am.
> I am not sure if there is a tag for related discussion in another
> mail threads.

It's fine to have several Link tags and in the past we have them for bug
reports thru mailing lists or so.

> Andy proposed many changes. Sergey, could you please send v2?

There is a v2.

https://lore.kernel.org/linux-serial/20200817022646.1484638-1-sergey.senozhatsky@gmail.com/T/#u

-- 
With Best Regards,
Andy Shevchenko


