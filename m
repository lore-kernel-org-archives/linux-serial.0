Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A19C433E2
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 16:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF1C20657
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJQaZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:30:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:49555 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgGJQaY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 12:30:24 -0400
IronPort-SDR: sENGk+H2KHqLXB2nbdqwm1ZJnwX1ZZR9LeclV8xKlQYrTaM9B92cFNXqeBaR9r5TU5uvzhnI9T
 rQvdhCBmMEoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="166326898"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="166326898"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 09:30:24 -0700
IronPort-SDR: Bu+5xxTAogr6Qt9XOPyehtNn9fg/iuQTF9n2tDXiNLJVDnikQ3AGeb47w6O4F+a0qG9QJneOBO
 DD3RAqgq/ppA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="316651372"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2020 09:30:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtvuo-0015OA-Qu; Fri, 10 Jul 2020 19:30:22 +0300
Date:   Fri, 10 Jul 2020 19:30:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH 1/1] tty: serial: owl: Initialize lock before registering
 port
Message-ID: <20200710163022.GT3703480@smile.fi.intel.com>
References: <89f6393934fc6d493f8b9e87c1a6e916642b6a18.1590749143.git.cristian.ciocaltea@gmail.com>
 <20200529113419.GA1631227@kroah.com>
 <20200710120549.GA11293@BV030612LT>
 <20200710133542.GA2172832@kroah.com>
 <20200710155806.GA10457@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710155806.GA10457@BV030612LT>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 10, 2020 at 06:58:06PM +0300, Cristian Ciocaltea wrote:
> On Fri, Jul 10, 2020 at 03:35:42PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 10, 2020 at 03:05:49PM +0300, Cristian Ciocaltea wrote:

...

> > But I think we now have a core fix for this, no need to do this in any
> > individual driver, right?  Can you test my tty-linus branch to see if
> > your change is still needed or not?
> 
> I was not aware of the alternative approach, at that time Andy
> confirmed the expected behaviour is to have a proper initialization
> of the spinlock in the driver:
> https://lore.kernel.org/lkml/CAHp75Vcz0a87LSnb6Ubt5_bSF3wUcs21GbP119trXER5KBDxbQ@mail.gmail.com/
> https://lore.kernel.org/lkml/CAHp75Vf8xJ2yX-11JsTDnRvZQOK+16aePcB1AUzq=5oO-mFCGQ@mail.gmail.com/
> 
> I have just checked the tty-linus tree and the only related change
> seems to be f743061a85f5
> ("serial: core: Initialise spin lock before use in uart_configure_port()")
> 
> I tested it on top of 5.8.0-rc4 and I confirm it fixes the splat,

Thank you for the testing!

> however I'm a bit confused now regarding the recommended approach since
> there is at least one more commit in the tty-linux tree that still 
> handles a similar issue in the driver specific code:
> f38278e9b810 ("serial: sh-sci: Initialize spinlock for uart console")

They now should be reverted.

-- 
With Best Regards,
Andy Shevchenko


