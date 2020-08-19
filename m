Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EC0C433E1
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 09:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2326206FA
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 09:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHSJdh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:33:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:6523 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHSJdg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 05:33:36 -0400
IronPort-SDR: /Vyaa0pSjDfYNRbPHtEVa/dSQrGH0vjaEroyYUbImuuMgRZdSwRlRAAwGe7/2o9kvEAU2sc9vX
 5ghQVgxM3GuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="156146059"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="156146059"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 02:33:35 -0700
IronPort-SDR: DHEW4HwCb7NHMrMF6gWZzR6tWQZAO+kBu/alt0pJsdX5BBIamIHw7Ggk/JKpfOSaLGw2XGoD3/
 628hvGGm7Xmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="327033254"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2020 02:33:33 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k8KTL-009qU8-Dr; Wed, 19 Aug 2020 12:33:31 +0300
Date:   Wed, 19 Aug 2020 12:33:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCHv2] serial: 8250: change lock order in
 serial8250_do_startup()
Message-ID: <20200819093331.GD1891694@smile.fi.intel.com>
References: <20200817022646.1484638-1-sergey.senozhatsky@gmail.com>
 <20200819092106.GA4353@alley>
 <20200819092726.GB3302@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819092726.GB3302@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 19, 2020 at 06:27:26PM +0900, Sergey Senozhatsky wrote:
> On (20/08/19 11:21), Petr Mladek wrote:
> > 
> > The patch is committed in printk/linux.git, branch for-5.10.
> 
> Petr, as far as I can tell, Greg has applied it to gregkh/tty.git

It's fine to have it in two or more repos, during merge the first one will go,
the second and consequent will be just no-op. It works the same way as
immutable branches/tags.

-- 
With Best Regards,
Andy Shevchenko


