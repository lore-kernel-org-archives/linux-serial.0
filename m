Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66020C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3606F20757
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCRPPH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:15:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:36495 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgCRPPH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 11:15:07 -0400
IronPort-SDR: HTeISfOC4CGs7Jlyob+Qgsx/jrCjaPt9SRTjj1CrKkeee533VgGHgXm7/JdR7GuUm21Auce8IT
 aQg0qHJ02rbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 08:15:06 -0700
IronPort-SDR: FO9JYybt6/tWOkD0i8MwbkuhJu09rhOiIDlGB9PXcO5Snk06sS/bBcmbsc6uuW2SYMWaQ9Tz4M
 mseSYVmPezEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="291343056"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2020 08:15:04 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jEaPN-00AnMz-9v; Wed, 18 Mar 2020 17:15:01 +0200
Date:   Wed, 18 Mar 2020 17:15:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH 6/7] serial: 8250_dw: add em485 support
Message-ID: <20200318151501.GO1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de>
 <20200318142640.982763-7-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318142640.982763-7-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 03:26:39PM +0100, Heiko Stuebner wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Need to use rs485 transceiver so let's use existing em485 485 emulation
> layer on top of 8250.
> 
> Add rs485_config callback to port.

Synopsys DesignWare UART is being supported in three modules right now:
8250_dw (platform driver), 8250_dwlib (some library functions for this driver)
and 8250_lpss (PCI driver).

Can we do in a way that both platform and PCI drivers will get advantage by the change?

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

-- 
With Best Regards,
Andy Shevchenko


