Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC1FC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97892073B
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 13:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390752AbgEYNk3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 09:40:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:32840 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388794AbgEYNk2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 09:40:28 -0400
IronPort-SDR: 97YWSA+OHdIUc+yjrho8MGmUxHkCuEivFLNCaH//GJM2q1CHoXDeOESY/HrJ/p+uZkzdn81gVa
 gJNMcY+6azzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 06:40:27 -0700
IronPort-SDR: NNxlW114Pgv6T09M/uQc3/OErRaRyawJdQ2EvjhndITWCYbTuEhp8nu1cA0/hl+r5Od1Vi9gGS
 SI6MRzYZlYCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="255110394"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 25 May 2020 06:40:25 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdDLA-008nLx-58; Mon, 25 May 2020 16:40:28 +0300
Date:   Mon, 25 May 2020 16:40:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jslaby@suse.com, lukas@wunner.de, heikki.krogerus@linux.intel.com,
        vigneshr@ti.com, linux-kernel@vger.kernel.org, fido_max@inbox.ru,
        radu-andrei.bulie@nxp.com
Subject: Re: [PATCH] serial: 8250: probe all 16550A variants by default
Message-ID: <20200525134028.GA1634618@smile.fi.intel.com>
References: <20200525130238.3614179-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525130238.3614179-1-olteanv@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 25, 2020 at 04:02:38PM +0300, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> On NXP T1040, the UART is typically detected as 16550A_FSL64. After said
> patch, it gets detected as plain 16550A and the Linux console is
> completely garbled and missing characters.
> 
> So clearly, introducing the SERIAL_8250_16550A_VARIANTS config option
> has broken many existing users because it has changed the default
> behavior. Restore that by adding a 'default y' to this option. Users who
> care about 20 ms shorter boot time can always disable it, but stop
> wasting many debugging hours for people who don't care all that much.

While this sounds like a good enough fix of the regression, the proper one
seems to have a separate quirk driver which avoids auto probe and uses
compatible strings or whatever that board can supply. 8250_port historically
has a burden of old and buggy hardware, that's why the above mentioned patch
exposed that.

That said, I have no objections, but had to note about possible approaches.

> Fixes: dc56ecb81a0a ("serial: 8250: Support disabling mdelay-filled probes of 16550A variants")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/tty/serial/8250/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index af0688156dd0..89c7ecb55619 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -63,6 +63,7 @@ config SERIAL_8250_PNP
>  config SERIAL_8250_16550A_VARIANTS
>  	bool "Support for variants of the 16550A serial port"
>  	depends on SERIAL_8250
> +	default y
>  	help
>  	  The 8250 driver can probe for many variants of the venerable 16550A
>  	  serial port. Doing so takes additional time at boot.
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


