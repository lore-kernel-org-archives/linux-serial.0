Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643BDC433E9
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 11:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F84B64E2E
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 11:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhBBLY6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:24:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:42302 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhBBLYG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Feb 2021 06:24:06 -0500
IronPort-SDR: 90cM5wyiVTkRt1gQbOKr+m+Gvo0vJ5g2wZ8iwVhye4HtVaHi0Dr5adrCFPvNfN4ylW3s29ko1z
 3ivyp59KvNqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="265669327"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="265669327"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 03:22:17 -0800
IronPort-SDR: moMPn00gvSZCt+UezBpZ7wwZYzT4zWMIrShx2RULg13yS8k8EYKpYFVSEU+ImgSugF3lwKsHQm
 KBdglL1MkTPA==
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="413557648"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 03:22:14 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6tl5-001NIM-WD; Tue, 02 Feb 2021 13:22:12 +0200
Date:   Tue, 2 Feb 2021 13:22:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3 5/5] serial: 8250_dw: add em485 support
Message-ID: <YBk14xJhIyqTNH/k@smile.fi.intel.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-6-heiko@sntech.de>
 <20200518152103.GI1634618@smile.fi.intel.com>
 <1f7881b5-f900-dbbe-3f8d-f990d2bdf5a7@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7881b5-f900-dbbe-3f8d-f990d2bdf5a7@micronovasrl.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 02, 2021 at 01:31:17AM +0100, Giulio Benetti wrote:
> Il 18/05/2020 17:21, Andy Shevchenko ha scritto:
> > On Sun, May 17, 2020 at 11:56:10PM +0200, Heiko Stuebner wrote:
> > > From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > 
> > > Need to use rs485 transceiver so let's use existing em485 485 emulation
> > > layer on top of 8250.
> > > 
> > > Add rs485_config callback to port and uses the standard em485 start and
> > > stop helpers.
> > 
> > Would it prevent to use native RS485 support?
> 
> 8250_dw doesn't have a native RS485 support, do you mean using hardware
> RTS assertion? Anyway at the moment it's not present. This would be the
> first rs485 support added to 8250_dw.

DW v4.0+ has it.

-- 
With Best Regards,
Andy Shevchenko


