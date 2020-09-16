Return-Path: <SRS0=QtZL=CZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98597C433E2
	for <linux-serial@archiver.kernel.org>; Wed, 16 Sep 2020 17:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ABC20708
	for <linux-serial@archiver.kernel.org>; Wed, 16 Sep 2020 17:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgIPRiv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Sep 2020 13:38:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:9004 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgIPRip (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Sep 2020 13:38:45 -0400
IronPort-SDR: oQpOPea35FNEgTCG2kve8o1+wO8ofHJK6vh5mnMJ4hflh3tma/kh0s+ZqI538mtIQnCzJmqY9N
 Tca2RZobXDBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="160382095"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="160382095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 05:34:25 -0700
IronPort-SDR: fAAMCfAxslpICGFXpsfGDzerRPBktvTOoMcBeLkSQ9TIB5idsNhJK6E6IRn3hN2kgHIn7bKpFV
 jOX+zdPEU5Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="336009022"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2020 05:34:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kIWT6-00H4tz-NP; Wed, 16 Sep 2020 15:23:24 +0300
Date:   Wed, 16 Sep 2020 15:23:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] serial: core: fix console port-lock regression
Message-ID: <20200916122324.GG3956970@smile.fi.intel.com>
References: <20200909143101.15389-1-johan@kernel.org>
 <20200909143101.15389-3-johan@kernel.org>
 <20200909154815.GD1891694@smile.fi.intel.com>
 <20200910073527.GC24441@localhost>
 <20200910092715.GM1891694@smile.fi.intel.com>
 <20200914080916.GI7101@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914080916.GI7101@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 14, 2020 at 11:09:16AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [200910 09:27]:
> > +Cc: Tony, let me add Tony to the discussion.
> > 
> > On Thu, Sep 10, 2020 at 09:35:27AM +0200, Johan Hovold wrote:
> > > And what about power management
> > > which was the reason for wanting this on OMAP in the first place; tty
> > > core never calls shutdown() for a console port, not even when it's been
> > > detached using the new interface.
> > 
> > That is interesting... Tony, do we have OMAP case working because of luck?
> 
> 8250_omap won't do anything unless autosuspend_timeout is configured for
> the uart(s). If configured, then the 8250_omap will idle when console is
> detached and the PM runtime usage count held by console is decremented, and
> the configured autosuspend_timeout expires.
> 
> The console is still kept open by getty, so I don't see why shutdown() would
> be called for the console port. But maybe I don't follow what you're
> concerned about, let me know if you want me to check something :)

Is it possible to test configuration when you have kernel console enabled but
no getty is run on it (perhaps something with ssh enabled access)?

Then kernel console should call ->shutdown on detaching, right?

-- 
With Best Regards,
Andy Shevchenko


