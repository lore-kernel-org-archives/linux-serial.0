Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9752CEB64DD
	for <linux-serial@archiver.kernel.org>; Wed,  9 Aug 2023 05:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjHIFd5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Aug 2023 01:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHIFdz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Aug 2023 01:33:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADEF19BC;
        Tue,  8 Aug 2023 22:33:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3795XFGS012495;
        Wed, 9 Aug 2023 00:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691559195;
        bh=Y/oQmnTPtdE4S4g/XeGVIXfJpEWD680xqI1AbmwKmaA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LWQQj8fKFeeTC/IoO6Krx6ATI4L+5phZ2JjvuQ4/A4TH2FzWxJEvcBzqyelUOsU/Z
         ppq4sTgI+KRj/0OWpEq72TTicjfMFlh4J4GHs05tXodbX+3tH+r1/Nh8fNttlyRumC
         6naPFKmC3Sou/8bY+bMv2CXeQtM3/5gPXFU8dYv0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3795XFTa053429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 00:33:15 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 00:33:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 00:33:15 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3795XEYl059916;
        Wed, 9 Aug 2023 00:33:15 -0500
Date:   Wed, 9 Aug 2023 11:03:14 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] serial: core: Revert port_id use
Message-ID: <20230809053314.dwksdbl63dnuiar3@dhruva>
References: <20230806062052.47737-1-tony@atomide.com>
 <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
 <20230809052650.GT14799@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809052650.GT14799@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Aug 09, 2023 at 08:26:50 +0300, Tony Lindgren wrote:
> Hi,
> 
> * Guenter Roeck <linux@roeck-us.net> [230806 13:19]:
> > On Sun, Aug 06, 2023 at 09:20:50AM +0300, Tony Lindgren wrote:
> > > Guenter reports boot issues with duplicate sysfs entries for multiport
> > > drivers. Let's go back to using port->line for now to fix the regression.
> > > 
> > > With this change, the serial core port device names are not correct for the
> > > hardware specific 8250 single port drivers, but that's a cosmetic issue for
> > > now.
> > > 
> > > Fixes: d962de6ae51f ("serial: core: Fix serial core port id to not use port->line")
> > > Reported-by: Guenter Roeck <groeck7@gmail.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks for testing.
> 
> Guenter, care to also test the patch below on top of this fix and
> see if things still behave for you?
> 
> I'll send a proper patch assuming things test fine.
> 
> Regagrds,
> 
> Tony
> 
> 8< --------------------
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> --- a/drivers/tty/serial/serial_base.h
> +++ b/drivers/tty/serial/serial_base.h
> @@ -16,6 +16,7 @@ struct device;
>  
>  struct serial_ctrl_device {
>  	struct device dev;
> +	struct ida ida;

When you send the proper patch, might want to change variable name to
something other than ida?

[...]
>  
> -- 
> 2.41.0

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
