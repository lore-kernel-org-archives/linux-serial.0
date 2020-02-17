Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF9C35254
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C70208C4
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgBQKFX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:05:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:56271 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgBQKFX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 05:05:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 02:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="314738042"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2020 02:05:21 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j3dHH-002ajQ-8S; Mon, 17 Feb 2020 12:05:23 +0200
Date:   Mon, 17 Feb 2020 12:05:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 0/8] serial: Disable DMA and PM on kernel console
Message-ID: <20200217100523.GY10400@smile.fi.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214163325.GA3992427@kroah.com>
 <20200214214128.GW16391@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214214128.GW16391@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 01:41:28PM -0800, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [200214 20:03]:
> > On Fri, Feb 14, 2020 at 01:43:31PM +0200, Andy Shevchenko wrote:
> > > This is second attempt [1] to get rid of problematic DMA and PM calls
> > > in the serial kernel console code.
> > > 
> > > Kernel console is sensitive to any kind of complex work needed to print
> > > out anything on it. One such case is emergency print during Oops.
> > > 
> > > Patches 1-3 are preparatory ones.
> > 
> > I've applied these first 3, as they are "obvious" :)
> > 
> > I'll let others weigh in on the other patches here, as I'd like to see
> > if Tony and others feel it solves their issues or not.
> 
> Yes with the pm_runtime_get_sync/pm_runtime_put_sync change for
> patch 5/8 things work nicely for me. But as it looks like there will
> be another revision of the patches so I'll wait for that before
> acking.

I will send a new version soon. Thanks for testing!

I hope to see Tested-by tags as well ;)

-- 
With Best Regards,
Andy Shevchenko


