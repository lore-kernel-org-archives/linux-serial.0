Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C11C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3106F2074D
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHNPkn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:40:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:56432 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHNPkm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 11:40:42 -0400
IronPort-SDR: DcPcegE9sBRsyuDENPq7NanjR5TLCnTpi0WtEZgq5mVoMhhYLC0xt9pBylOv04oRvQ3BxzJ6Bd
 iUckvrwWkxow==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="151841353"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="151841353"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 08:40:42 -0700
IronPort-SDR: 2n8Dv52TQCnaJMSaXNHBD7I/V/ERIxy0eV4qjA+xlPnn/ZAln4dQwa5NB5A/1Wj5sITFH+8o86
 XJ2xTSMdEK5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="325755433"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 08:40:39 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6bor-008g8v-SY; Fri, 14 Aug 2020 18:40:37 +0300
Date:   Fri, 14 Aug 2020 18:40:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] uart:8250: change lock order in serial8250_do_startup()
Message-ID: <20200814154037.GU1891694@smile.fi.intel.com>
References: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
 <20200814095928.GK1891694@smile.fi.intel.com>
 <20200814112940.GB582@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814112940.GB582@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 14, 2020 at 08:29:40PM +0900, Sergey Senozhatsky wrote:
> On (20/08/14 12:59), Andy Shevchenko wrote:

...

> > I think we can stick with newer:
> >
> > 		if (port->irqflags & IRQF_SHARED)
> 
> I'll take a look.

Thanks!

One more thing, perhaps update prefix to be 'serial: 8250:'.

-- 
With Best Regards,
Andy Shevchenko


