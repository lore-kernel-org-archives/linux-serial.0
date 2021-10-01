Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFAEC433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 11:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4145361A82
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 11:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354059AbhJALmx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:42:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:47523 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354023AbhJALmw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 07:42:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="222208085"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="222208085"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:41:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="480403830"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:40:59 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWGuJ-007Qed-UQ;
        Fri, 01 Oct 2021 14:40:51 +0300
Date:   Fri, 1 Oct 2021 14:40:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
Subject: Re: [PATCH v2 0/3] Handle UART without interrupt on TEMT using em485
Message-ID: <YVbzw3TP7zQXmSuv@smile.fi.intel.com>
References: <20210204161158.643-1-etremblay@distech-controls.com>
 <YB1UEHEPVQCAjsMO@smile.fi.intel.com>
 <20210929200747.vpymjmq6ssvltmh4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210929200747.vpymjmq6ssvltmh4@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 29, 2021 at 10:07:47PM +0200, Uwe Kleine-König wrote:
> On Fri, Feb 05, 2021 at 04:20:00PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 04, 2021 at 11:11:55AM -0500, Eric Tremblay wrote:
> > > Thanks everyone for the comments. I apply most of the comments on version 1
> > > but there is still a pending point with the Jiri comment about the safety of:
> > > struct tty_struct *tty = p->port.state->port.tty;
> > > I thought about adding a check with tty_port_initialized() before accessing
> > > the pointer, but I saw some other places where that same pointer is accessed
> > > without further protection, at least from what I see.
> > 
> > Thanks for the update. Unfortunately I'm a bit busy with other prioritized
> > stuff, but I will review this next week.
> 
> I assume this fell through the cracks as "next week" is already over ...?

Indeed. Anyways, there is a kbuildbot message against patch 1 as I see and
needs to be addressed. I'm going to look into the code right now.

-- 
With Best Regards,
Andy Shevchenko


