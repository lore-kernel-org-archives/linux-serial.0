Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB47C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Feb 2021 19:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4642664F9D
	for <linux-serial@archiver.kernel.org>; Fri,  5 Feb 2021 19:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBERwq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Feb 2021 12:52:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:14562 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233694AbhBERtQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Feb 2021 12:49:16 -0500
IronPort-SDR: RdEa4fB/9XTBb/YIh3spEiAYoOT4ptR63BgTz2ejxxsJnGHw+3DNMLO+3qAC++5klBz3jpOkwf
 RfiGxeIGCyag==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="177973444"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="177973444"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 11:29:45 -0800
IronPort-SDR: DpOSbIwA7IxUlUq1sd/9m7KtdYqPcf6QM3ZDQ27OsgD9oJrIehxyThk6iggcI+sIXA54QmILiI
 5lFQHoEObUow==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="373492960"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 11:29:43 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l86nT-002Ebh-Un; Fri, 05 Feb 2021 21:29:39 +0200
Date:   Fri, 5 Feb 2021 21:29:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3 5/5] serial: 8250_dw: add em485 support
Message-ID: <YB2co0GoAc3zOK5m@smile.fi.intel.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-6-heiko@sntech.de>
 <20200518152103.GI1634618@smile.fi.intel.com>
 <1f7881b5-f900-dbbe-3f8d-f990d2bdf5a7@micronovasrl.com>
 <YBk14xJhIyqTNH/k@smile.fi.intel.com>
 <9b2a7c4c-2ef1-5198-9aae-83f9fec00289@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b2a7c4c-2ef1-5198-9aae-83f9fec00289@micronovasrl.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 05, 2021 at 06:46:56PM +0100, Giulio Benetti wrote:
> Il 02/02/2021 12:22, Andy Shevchenko ha scritto:
> > On Tue, Feb 02, 2021 at 01:31:17AM +0100, Giulio Benetti wrote:
> > > Il 18/05/2020 17:21, Andy Shevchenko ha scritto:
> > > > On Sun, May 17, 2020 at 11:56:10PM +0200, Heiko Stuebner wrote:
> > > > > From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > > > 
> > > > > Need to use rs485 transceiver so let's use existing em485 485 emulation
> > > > > layer on top of 8250.
> > > > > 
> > > > > Add rs485_config callback to port and uses the standard em485 start and
> > > > > stop helpers.
> > > > 
> > > > Would it prevent to use native RS485 support?
> > > 
> > > 8250_dw doesn't have a native RS485 support, do you mean using hardware
> > > RTS assertion? Anyway at the moment it's not present. This would be the
> > > first rs485 support added to 8250_dw.
> > 
> > DW v4.0+ has it.
> 
> I have access to datasheet of DW v3, and I don't have access to hardware
> with DW v4.0v Uart.
> But I could add rs485emu for only UART version < 4.0 and I can find Uart
> version by reading UCV register, would it be acceptable?

I don't think we need to disable the possibility to have emulation even on v4+
IP since PCB can be designed that way. My point here, that whatever code you
add it should not prevent to use HW supported RS485, although I haven't heard
about support of it in the upstream (yet?).

And for the record, Synopsys hadn't added any bit into CPR to recognize that
feature, so only version check can be done in this case...

-- 
With Best Regards,
Andy Shevchenko


