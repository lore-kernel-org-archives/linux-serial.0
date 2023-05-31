Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E6C7EE24
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 10:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjEaKJJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbjEaKJI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 06:09:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F507113
        for <linux-serial@vger.kernel.org>; Wed, 31 May 2023 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685527747; x=1717063747;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=xHt5XZPkKN2R+zqCZofHZSP4x8tUQoqJ0fFIIHXDxx8=;
  b=S4vrW89bzHy7Fnp0tYgIfPYwbGCdlhg3ATQQ0wCNSm6S7iS/8b2ozDX+
   azpFecfL0IcTPtG0fsMW5fJoMgtaLNa2d3Vnvw6NLr34CmbyhbtE/Rgt2
   mqwJOt9vWYEQNgkC7YZeXb/YkPtWxzKZp2Z6iYAf/mo4S6lu4iFTEUQ+T
   wFND9WlFppVmSGOZsyVQZfip0WFrQJSd3tVwBDqAgvbyV0xUsSew1uQrz
   zogusz/ymW9S/6+WRn/VkFfFT/IUmpSfLPsxCQCJOYQBEt4ZzK5ulKMfa
   d3sR4rSm64+pKX75PZSAKLiFluqYezTCx6q3APB2TS/k7CYRj/ZYJ1b/W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383454007"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="383454007"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="881119982"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="881119982"
Received: from lmmelle-mobl1.ger.corp.intel.com ([10.252.47.216])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:09:04 -0700
Date:   Wed, 31 May 2023 13:09:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
In-Reply-To: <20230531100443.jeg4q73fz4yx4pi6@pengutronix.de>
Message-ID: <9eab900-9387-4db2-3f24-29d4d1dcb411@linux.intel.com>
References: <20230531083230.2702181-1-u.kleine-koenig@pengutronix.de> <1bdec338-6954-7b2f-e8e3-f19f211c4ce3@linux.intel.com> <20230531100443.jeg4q73fz4yx4pi6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-427729264-1685527652=:5379"
Content-ID: <cae9109-ff79-a7aa-9a7-3e90f4f0cf18@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-427729264-1685527652=:5379
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <1aa4e9f6-58fb-c34-f434-568d6fe6bb39@linux.intel.com>

On Wed, 31 May 2023, Uwe Kleine-König wrote:

> On Wed, May 31, 2023 at 12:47:54PM +0300, Ilpo Järvinen wrote:
> > On Wed, 31 May 2023, Uwe Kleine-König wrote:
> > 
> > > The need to handle the FSL variant of 8250 in a special way is also
> > > present without console support. So soften the dependency for
> > > SERIAL_8250_FSL accordingly.
> > > 
> > > This issue was identified by Dominik Andreas Schorpp.
> > > 
> > > To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
> > > must be put in the same compilation unit as 8250_port.o because the
> > > latter defines some functions needed in the former and so 8250_fsl.o
> > > must not be built-in if 8250_port.o is available in a module.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > (implicit) v1 was already applied by Greg (a0807ca158e0 in tty-testing)
> > > but that didn't handle CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y
> > > correctly which was pointed out by the 0-day bot. (Thanks!)
> > 
> > That would warrant Reported-by (0-day's reports give you the tag).
> 
> I'd add this tag if I created a commit that fixes the broken commit.
> However I understood that if a v2 patch fixes a v1 that was broken, the
> tag is not to be added?! I don't feel strong here however, so if people
> agree that the tag should be there, I can add it.
> 
> > > That wasn't a problem before because SERIAL_8250_CONSOLE depends on
> > > SERIAL_8250=y.
> > > 
> > > Having said that I wonder if there are a few more .o files that should
> > > better be used with 8250_base-$(CONFIG_SERIAL_8250_XXX) instead of
> > > obj-$(CONFIG_SERIAL_8250_XXX).
> > > 
> > > Best regards
> > > Uwe
> > > 
> > >  drivers/tty/serial/8250/Kconfig  | 2 +-
> > >  drivers/tty/serial/8250/Makefile | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > > index 5313aa31930f..10c09b19c871 100644
> > > --- a/drivers/tty/serial/8250/Kconfig
> > > +++ b/drivers/tty/serial/8250/Kconfig
> > > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > >  
> > >  config SERIAL_8250_FSL
> > >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> > > -	depends on SERIAL_8250_CONSOLE
> > > +	depends on SERIAL_8250
> > 
> > Why this cannot simply be:
> > 	depends on SERIAL_8250=y
> 
> This doesn't work, because then the FSL-workarounds are missing if the
> 8250 driver is compiled as a module.

How can 8250 driver be a module and fsl still get enabled?

What I think (not a Kconfig expert for sure) would happen is that 8250_fsl 
won't be enabled at all if CONFIG_SERIAL_8250=m because it depends on 
SERIAL_8250=y.

-- 
 i.
--8323329-427729264-1685527652=:5379--
