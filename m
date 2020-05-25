Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB5C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA8B2071A
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 15:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404217AbgEYPeR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 11:34:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:50376 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404066AbgEYPeR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 11:34:17 -0400
IronPort-SDR: 964Qhxy5FLl+it5k6SF5CiqrI++r7pWO5aFNfAuYiCymYs62Sm2c7CgM+rW70DvwFDMW6C9SI3
 dvodTPX7/kRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 08:34:17 -0700
IronPort-SDR: xN5pG0rywuPVJT/QXvPc9RGlL4J2++hutif+ZlLsejus5nsLUbaRtwdmzK9dWAusbeY34vE10e
 05NLAYvQgz9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="468078964"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 May 2020 08:34:15 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdF7K-008oh4-Ro; Mon, 25 May 2020 18:34:18 +0300
Date:   Mon, 25 May 2020 18:34:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1] serial: imx: Initialize lock for non-registered
 console
Message-ID: <20200525153418.GE1634618@smile.fi.intel.com>
References: <20200525105952.13744-1-andriy.shevchenko@linux.intel.com>
 <c5b1caca-32fc-1482-b4f5-71787b73a814@roeck-us.net>
 <20200525140752.GA910887@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525140752.GA910887@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 25, 2020 at 04:07:52PM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 25, 2020 at 07:01:13AM -0700, Guenter Roeck wrote:
> > On 5/25/20 3:59 AM, Andy Shevchenko wrote:
> > > The commit a3cb39d258ef
> > > ("serial: core: Allow detach and attach serial device for console")
> > > changed a bit logic behind lock initialization since for most of the console
> > > driver it's supposed to have lock already initialized even if console is not
> > > enabled. However, it's not the case for Freescale IMX console.
> > > 
> > > Initialize lock explicitly in the ->probe().
> > > 
> > > Note, there is still an open question should or shouldn't not this driver
> > > register console properly.
> > > 
> > > Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I really wonder if this is the correct fix, especially since it looks like
> > there are several other drivers which don't call register_console() either
> > but implement a console device.
> > 
> > Guenter
> > 
> > > ---
> > >  drivers/tty/serial/imx.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index 986d902fb7fe..6b078e395931 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -2404,6 +2404,9 @@ static int imx_uart_probe(struct platform_device *pdev)
> > >  		}
> > >  	}
> > >  
> > > +	/* We need to initialize lock even for non-registered console */
> > > +	spin_lock_init(&sport->port.lock);
> 
> Why are we having to do this for all console drivers recently?
> Shouldn't the original patch that required this gone through and fixed
> up all drivers?
> 
> I'm with Guenter here, let's fix them all at once please.

Okay. Do you want series per driver or one for all?


-- 
With Best Regards,
Andy Shevchenko


