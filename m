Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF4C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 09:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjEaJsA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEaJsA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 05:48:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF7910B
        for <linux-serial@vger.kernel.org>; Wed, 31 May 2023 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685526479; x=1717062479;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=5l7eMmGtelEQj4ykwAAXf1Cs5PVcuIboZdbjdU1Epi8=;
  b=BUWUhVwDAvXzGbp8bh4dnQg5k73eQEOgcKMBLjhMz2Uj2bXieFwPCsMa
   6tHB3atYSLOdS8D8U1fT4af/cpKNvRr8vDIwYKLjT1QhvOPLauRYKOZeS
   HXoSswQ35P/wEzaAzvDy+AymsGOo2jYNMm3kP8gbFcY4OfE31LOdevJuR
   OK5GoXkjA/GGaqph/ccqeL4ZlIKmbbh0ZNbW6IBEQ2q3XXe6gy9d448+j
   WPuz/mQqhbf7068WDLuRA0vVRbWPfL9QKqWivOfk2KbJfVkfiu5h1H/5/
   AXJ/qUnpXlPP5GwpSSPW6BHL6IkZhBbNgo99xFdHwg27zcHd1nksfknCV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357580275"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357580275"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="710005540"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="710005540"
Received: from lmmelle-mobl1.ger.corp.intel.com ([10.252.47.216])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:47:56 -0700
Date:   Wed, 31 May 2023 12:47:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
In-Reply-To: <20230531083230.2702181-1-u.kleine-koenig@pengutronix.de>
Message-ID: <1bdec338-6954-7b2f-e8e3-f19f211c4ce3@linux.intel.com>
References: <20230531083230.2702181-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-420609742-1685526327=:5379"
Content-ID: <3d9d8559-eba0-37af-d8a1-353d0eb36c1@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-420609742-1685526327=:5379
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <8a58ddd6-3b4a-923f-18a8-b1aeb72797f5@linux.intel.com>

On Wed, 31 May 2023, Uwe Kleine-König wrote:

> The need to handle the FSL variant of 8250 in a special way is also
> present without console support. So soften the dependency for
> SERIAL_8250_FSL accordingly.
> 
> This issue was identified by Dominik Andreas Schorpp.
> 
> To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
> must be put in the same compilation unit as 8250_port.o because the
> latter defines some functions needed in the former and so 8250_fsl.o
> must not be built-in if 8250_port.o is available in a module.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> (implicit) v1 was already applied by Greg (a0807ca158e0 in tty-testing)
> but that didn't handle CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y
> correctly which was pointed out by the 0-day bot. (Thanks!)

That would warrant Reported-by (0-day's reports give you the tag).

> That wasn't a problem before because SERIAL_8250_CONSOLE depends on
> SERIAL_8250=y.
> 
> Having said that I wonder if there are a few more .o files that should
> better be used with 8250_base-$(CONFIG_SERIAL_8250_XXX) instead of
> obj-$(CONFIG_SERIAL_8250_XXX).
> 
> Best regards
> Uwe
> 
>  drivers/tty/serial/8250/Kconfig  | 2 +-
>  drivers/tty/serial/8250/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 5313aa31930f..10c09b19c871 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
>  
>  config SERIAL_8250_FSL
>  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> -	depends on SERIAL_8250_CONSOLE
> +	depends on SERIAL_8250

Why this cannot simply be:
	depends on SERIAL_8250=y

-- 
 i.


>  	default PPC || ARM || ARM64
>  	help
>  	  Selecting this option enables a workaround for a break-detection
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 4fc2fc1f41b6..37647ca79ec5 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
>  8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
>  8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
>  8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
> +8250_base-$(CONFIG_SERIAL_8250_FSL)	+= 8250_fsl.o
>  obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
>  obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
>  obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o
> @@ -28,7 +29,6 @@ obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>  obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
> -obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>  obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
>  obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>  obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
> 
> base-commit: ac9a78681b921877518763ba0e89202254349d1b
> 
--8323329-420609742-1685526327=:5379--
