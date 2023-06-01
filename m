Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E02C77B7A
	for <linux-serial@archiver.kernel.org>; Thu,  1 Jun 2023 10:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjFAKtT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Jun 2023 06:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjFAKtS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Jun 2023 06:49:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5239D
        for <linux-serial@vger.kernel.org>; Thu,  1 Jun 2023 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685616557; x=1717152557;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=DL9ypoDkttWXdKLLcV4ybgvvIzVME171NsuIpjt/lm0=;
  b=nCOSnZSUBiXfun1I7ZosYLAOnBEvpx67mvAgAB7D2jTgTblbyhRL5Rsv
   CbpT9nFA6WCrOQ5wu0Ag3Fxoih1a1CoiWIw/3xS7MTfh97Y98+7nCknxp
   2s3EfQVa8n80fwVceBM01MkqGufOiKvbyDXVBTQmWrNWocPTHzaFb1ZTH
   1D0AuF3fw/LZW+tSv4k2DpfAjz6gqoLpg3Wlmn3r8OGeO8I7HpKTUtrZK
   vbmL5rm6RQZmZ7B4KWZZL67SyiFgR9QCk8TijpgV/v+1zwBDdmQgiXbMo
   MgyfdSByX+w3VOXupCvut5go7r7CoyOIjksJR4OOu0bWfredl8o5eqzyH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="358797973"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="358797973"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 03:49:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="777119134"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="777119134"
Received: from sstrehlk-mobl1.ger.corp.intel.com ([10.252.56.20])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 03:49:14 -0700
Date:   Thu, 1 Jun 2023 13:49:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, kernel@pengutronix.de,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
In-Reply-To: <20230531175126.vqoqa2flhtbboy2t@pengutronix.de>
Message-ID: <73474ddb-5183-69c8-3943-bc2c62aa13e9@linux.intel.com>
References: <20230531083230.2702181-1-u.kleine-koenig@pengutronix.de> <1bdec338-6954-7b2f-e8e3-f19f211c4ce3@linux.intel.com> <20230531100443.jeg4q73fz4yx4pi6@pengutronix.de> <9eab900-9387-4db2-3f24-29d4d1dcb411@linux.intel.com> <20230531104010.k2rgnicltwy6wive@pengutronix.de>
 <20230531175126.vqoqa2flhtbboy2t@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-829601047-1685616108=:2050"
Content-ID: <76d629c9-ce30-3c15-7e17-671802f3ac4@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-829601047-1685616108=:2050
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <eb662695-79f-cfdb-bde6-e3b0c8b6cc3e@linux.intel.com>

On Wed, 31 May 2023, Uwe Kleine-König wrote:

> Hello Ilpo,
> 
> On Wed, May 31, 2023 at 12:40:10PM +0200, Uwe Kleine-König wrote:
> > On Wed, May 31, 2023 at 01:09:01PM +0300, Ilpo Järvinen wrote:
> > > On Wed, 31 May 2023, Uwe Kleine-König wrote:
> > > 
> > > > On Wed, May 31, 2023 at 12:47:54PM +0300, Ilpo Järvinen wrote:
> > > > > On Wed, 31 May 2023, Uwe Kleine-König wrote:
> > > > > 
> > > > > > The need to handle the FSL variant of 8250 in a special way is also
> > > > > > present without console support. So soften the dependency for
> > > > > > SERIAL_8250_FSL accordingly.
> > > > > > 
> > > > > > This issue was identified by Dominik Andreas Schorpp.
> > > > > > 
> > > > > > To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
> > > > > > must be put in the same compilation unit as 8250_port.o because the
> > > > > > latter defines some functions needed in the former and so 8250_fsl.o
> > > > > > must not be built-in if 8250_port.o is available in a module.
> > > > > > 
> > > > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > > > ---
> > > > > > Hello,
> > > > > > 
> > > > > > (implicit) v1 was already applied by Greg (a0807ca158e0 in tty-testing)
> > > > > > but that didn't handle CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y
> > > > > > correctly which was pointed out by the 0-day bot. (Thanks!)
> > > > > 
> > > > > That would warrant Reported-by (0-day's reports give you the tag).
> > > > 
> > > > I'd add this tag if I created a commit that fixes the broken commit.
> > > > However I understood that if a v2 patch fixes a v1 that was broken, the
> > > > tag is not to be added?! I don't feel strong here however, so if people
> > > > agree that the tag should be there, I can add it.
> > > > 
> > > > > > That wasn't a problem before because SERIAL_8250_CONSOLE depends on
> > > > > > SERIAL_8250=y.
> > > > > > 
> > > > > > Having said that I wonder if there are a few more .o files that should
> > > > > > better be used with 8250_base-$(CONFIG_SERIAL_8250_XXX) instead of
> > > > > > obj-$(CONFIG_SERIAL_8250_XXX).
> > > > > > 
> > > > > > Best regards
> > > > > > Uwe
> > > > > > 
> > > > > >  drivers/tty/serial/8250/Kconfig  | 2 +-
> > > > > >  drivers/tty/serial/8250/Makefile | 2 +-
> > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > > > > > index 5313aa31930f..10c09b19c871 100644
> > > > > > --- a/drivers/tty/serial/8250/Kconfig
> > > > > > +++ b/drivers/tty/serial/8250/Kconfig
> > > > > > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > > > > >  
> > > > > >  config SERIAL_8250_FSL
> > > > > >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> > > > > > -	depends on SERIAL_8250_CONSOLE
> > > > > > +	depends on SERIAL_8250
> > > > > 
> > > > > Why this cannot simply be:
> > > > > 	depends on SERIAL_8250=y
> > > > 
> > > > This doesn't work, because then the FSL-workarounds are missing if the
> > > > 8250 driver is compiled as a module.
> > > 
> > > How can 8250 driver be a module and fsl still get enabled?
> > 
> > It works. With my patch applied:
> > 
> > 	$ make allmodconfig
> > 	$ grep -E 'CONFIG_SERIAL_8250(_FSL)?\>' .config
> > 	CONFIG_SERIAL_8250=m
> > 	CONFIG_SERIAL_8250_FSL=y
> > 
> > > What I think (not a Kconfig expert for sure) would happen is that 8250_fsl 
> > > won't be enabled at all if CONFIG_SERIAL_8250=m because it depends on 
> > > SERIAL_8250=y.
> > 
> > That's not how it seems to be ...
> 
> If this convinces you that the patch is fine, an ack would be nice as
> gregkh signaled that there is some pending discussion he is waiting to
> end before applying this patch.

Ah, so you want to have SERIAL_8250_FSL=y always when SERIAL_8250 is 
there. I can't see another way around it besides the moving you made.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-829601047-1685616108=:2050--
