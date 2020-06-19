Return-Path: <SRS0=VMdU=AA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CCC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 09:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F2F2080C
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 09:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgFSJr1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:47:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:17096 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgFSJr1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jun 2020 05:47:27 -0400
IronPort-SDR: cgRpmXvdMW8UGbiPp3oL8e9Q2yp/PcqV6W/XX6gfD+kf0Imnof3ijzu9g5BkDKQwNce8IZZiJD
 eswpKQTonOTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="227591803"
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; 
   d="scan'208";a="227591803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 02:47:26 -0700
IronPort-SDR: E5YIUSutHfRfHqgpuop/R4ZPq4wQO+Qt/jK4cjePgZJLJgGSIdiomGH/aJ3aOAfXaxgUsGd5LN
 7NsNUQxm5z0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; 
   d="scan'208";a="277950284"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2020 02:47:24 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jmDcM-00ES0f-RQ; Fri, 19 Jun 2020 12:47:26 +0300
Date:   Fri, 19 Jun 2020 12:47:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/6] console: unify return codes from ->setup() hook
Message-ID: <20200619094726.GD2428291@smile.fi.intel.com>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
 <20200619093917.GK3617@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619093917.GK3617@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 19, 2020 at 11:39:18AM +0200, Petr Mladek wrote:
> On Thu 2020-06-18 19:47:45, Andy Shevchenko wrote:
> > Some of the console providers treat error code, returned by ->setup() hook,
> > differently. Here is the unification of the behaviour.
> > 
> > The drivers checked by one of the below criteria:
> > 1/ the driver has explicit struct console .setup assignment
> > 2/ the driver has assigned callback to the setup member
> > 
> > All such drivers were read in order to see if there is any problematic return
> > codes, and fixed accordingly which is this series in the result.
> > 
> > Andy Shevchenko (6):
> >   mips: Return proper error code from console ->setup() hook
> >   serial: sunsab: Return proper error code from console ->setup() hook
> >   serial: sunzilog: Return proper error code from console ->setup() hook
> >   tty: hvc: Return proper error code from console ->setup() hook
> >   console: Propagate error code from console ->setup()
> >   console: Fix trivia typo 'change' -> 'chance'
> 
> For the entire patchset:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I am going to push it the following week via printk tree unless
> anybody complains.

Thanks, Petr, I guess you may also incorporate Sergey's patch he proposed. Sergey, are you going to submit it officially?

-- 
With Best Regards,
Andy Shevchenko


