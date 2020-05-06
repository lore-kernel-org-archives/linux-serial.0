Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF9FC28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 10:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B8820753
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 10:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgEFKCB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 06:02:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:46782 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgEFKCB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 06:02:01 -0400
IronPort-SDR: iNNoZ2sMzZuivEV1X+eQdy/f08q3zfFG5+LPf+s5KKNA84dFt0Cvn75T9gv8qG5isd+XCN9bYg
 50+qGPkqh+jA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 03:01:59 -0700
IronPort-SDR: tTSKKRYqAjYlK2tILCjAMliZD/yQfbuPTqEh/yDDTQaskHYz2eBrvxURnkpPDSW61UTxf+gJtp
 /fnmkbKMHx2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="248861939"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2020 03:01:54 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jWGsH-004zVW-Ds; Wed, 06 May 2020 13:01:57 +0300
Date:   Wed, 6 May 2020 13:01:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] serial: 8250: Avoid error message on reprobe
Message-ID: <20200506100157.GB185537@smile.fi.intel.com>
References: <cover.1588505407.git.lukas@wunner.de>
 <b3fbbe8688d5e9d173168ae45295719ca4c9d35f.1588505407.git.lukas@wunner.de>
 <20200505160101.GV185537@smile.fi.intel.com>
 <20200506060623.sf3kh3fwhoawawsd@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506060623.sf3kh3fwhoawawsd@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 08:06:23AM +0200, Lukas Wunner wrote:
> On Tue, May 05, 2020 at 07:01:01PM +0300, Andy Shevchenko wrote:
> > On Tue, May 05, 2020 at 04:42:01PM +0200, Lukas Wunner wrote:
> > > If the call to uart_add_one_port() in serial8250_register_8250_port()
> > > fails, a half-initialized entry in the serial_8250ports[] array is left
> > > behind.
> > > 
> > > A subsequent reprobe of the same serial port causes that entry to be
> > > reused.  Because uart->port.dev is set, uart_remove_one_port() is called
> > > for the half-initialized entry and bails out with an error message:
> > > 
> > > bcm2835-aux-uart 3f215040.serial: Removing wrong port: (null) != (ptrval)
> > > 
> > > The same happens on failure of mctrl_gpio_init() since commit
> > > 4a96895f74c9 ("tty/serial/8250: use mctrl_gpio helpers").
> > > 
> > > Fix by zeroing the uart->port.dev pointer in the probe error path.
> > >  
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: stable@vger.kernel.org # v2.6.10+
> > 
> > Fixes tag?
> 
> The bug was introduced in the pre-git era, so I can't provide a Fixes tag:
> 
> https://git.kernel.org/tglx/history/c/befff6f5bf5f
> 
> This commit, which went into v2.6.10, added an unconditional
> uart_remove_one_port() in serial8250_register_port().

We have history tree, but I heard you.

> In 2012, commit 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
> made the call to uart_remove_one_port() conditional on uart->port.dev
> being non-NULL and that allows me to fix the issue by setting that
> pointer to NULL in the error path.  The commit went into v3.7, so it
> should be possible to fix the problem going back to v3.7 with my patch.
> And before that one needs to additionally make the call to
> uart_remove_one_port() conditional.

Perhaps it will be the best candidate.

Fixes, AFAIU, helps scripts to find whatever trees it might been applied
against. If somebody keeps private stable tree on unusual base it will be
helpful for them as well (but I understand that there is little care of a
such).

> However, according to www.kernel.org the oldest LTS kernel is v3.16.
> So I've given you the nitty-gritty details but it's all fairly
> irrelevant and the Cc: stable tag I've put into the commit seems the
> best I can do in this case.

-- 
With Best Regards,
Andy Shevchenko


