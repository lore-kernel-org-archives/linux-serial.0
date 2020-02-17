Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FA6C761A0
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1415020725
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 09:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgBQJST (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:18:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:13664 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbgBQJST (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 04:18:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 01:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,451,1574150400"; 
   d="scan'208";a="229139699"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2020 01:18:17 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j3cXj-002ZtW-8R; Mon, 17 Feb 2020 11:18:19 +0200
Date:   Mon, 17 Feb 2020 11:18:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 6/8] serial: 8250_port: Disable DMA operations for
 kernel console
Message-ID: <20200217091819.GX10400@smile.fi.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-7-andriy.shevchenko@linux.intel.com>
 <20200214163058.GC3987177@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214163058.GC3987177@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 08:30:58AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Feb 14, 2020 at 01:43:37PM +0200, Andy Shevchenko wrote:

> > +		if (msg) {
> > +			pr_warn_ratelimited("%s - %s\n", port->name, msg);
> 
> dev_warn_ratelimited()?  You have a port, you should use it.

I will change this in next version, thanks!

-- 
With Best Regards,
Andy Shevchenko


