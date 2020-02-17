Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE912C3B185
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 10:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD22520702
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 10:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBQKXr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:23:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:48374 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgBQKXr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 05:23:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 02:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="235193865"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2020 02:23:44 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j3dZ3-002b5V-WE; Mon, 17 Feb 2020 12:23:46 +0200
Date:   Mon, 17 Feb 2020 12:23:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/8] serial: core: Allow detach and attach serial
 device for console
Message-ID: <20200217102345.GZ10400@smile.fi.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-5-andriy.shevchenko@linux.intel.com>
 <20200214162847.GB3987177@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214162847.GB3987177@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 08:28:47AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Feb 14, 2020 at 01:43:35PM +0200, Andy Shevchenko wrote:

...

> >  static DEVICE_ATTR(iomem_base, 0440, uart_get_attr_iomem_base, NULL);
> >  static DEVICE_ATTR(iomem_reg_shift, 0440, uart_get_attr_iomem_reg_shift, NULL);
> > +static DEVICE_ATTR(console, 0640, uart_get_attr_console, uart_set_attr_console);
> 
> Again, DEVICE_ATTR_RW() in the future?

Fixed for next version, thanks!

-- 
With Best Regards,
Andy Shevchenko


