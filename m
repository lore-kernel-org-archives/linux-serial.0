Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDF4C38147
	for <linux-serial@archiver.kernel.org>; Wed, 18 Jan 2023 19:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjART37 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Jan 2023 14:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjART35 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Jan 2023 14:29:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35105411B
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2023 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674070196; x=1705606196;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DrnMg03t3soav3HbVULAS8+Totr2e7x7i8qqI6CYPBg=;
  b=XunB2KqSsSeFPtNqCAwE/nmpDqMm68ensaQT3SO+Mxk0F8hwKnKY45zT
   Sh2sJzkETrf8atz+P9mxpOBqzzXEJTbOJP0Xi2jugnzUUdIfao+tuJ0HI
   rV+C2Max8Vs6X4zSUW/DhYZHkVy8xtQklDrXjvgnqsx61FOSF5YZ6TWaA
   SXurRf4Ula/tHLsjt6taJ4P4nL5zeTaQkOrYylpCUjEb46YDSCjQEK2Ji
   kWk1168BnEaj57B9D7X4rT5XS3JX49yD/dio+o+TJW0pqhZtybUKnBUJN
   umUsfLkgQ4puJmTQn8Tv1W0UuUMKKsPKxEREHOZvDjDiqkLwfE0rDwF3z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="325130486"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="325130486"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 11:29:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988711977"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="988711977"
Received: from tszopax-mobl2.ger.corp.intel.com ([10.252.41.243])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 11:29:52 -0800
Date:   Wed, 18 Jan 2023 21:29:49 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergey Organov <sorganov@gmail.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?ISO-8859-2?Q?Tomasz_Mo=F1?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading
 loop
In-Reply-To: <87edrrzw3n.fsf@osv.gnss.ru>
Message-ID: <bc348d2-234e-3a30-272b-b17d27da7327@linux.intel.com>
References: <87bko4e65y.fsf@osv.gnss.ru> <20230113184334.287130-1-sorganov@gmail.com> <20230113184334.287130-8-sorganov@gmail.com> <48ba84e3-7f52-9cfb-426a-a432587c1c9@linux.intel.com> <87lem12h0k.fsf@osv.gnss.ru> <be325aca-843-f7a7-cd8e-447cf4f7bf7@linux.intel.com>
 <87edrrzw3n.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1951260190-1674070196=:1750"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1951260190-1674070196=:1750
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 18 Jan 2023, Sergey Organov wrote:

> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:
> 
> > On Tue, 17 Jan 2023, Sergey Organov wrote:
> >
> >> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:
> >> 
> >> > On Fri, 13 Jan 2023, Sergey Organov wrote:
> >> >
> >> >> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
> >> >> we read registers that must not be cached.
> >> >> 
> >> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> >> ---
> >> >>  drivers/tty/serial/imx.c | 5 +++--
> >> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >> >> 
> >> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >> >> index be00362b8b67..f4236e8995fa 100644
> >> >> --- a/drivers/tty/serial/imx.c
> >> >> +++ b/drivers/tty/serial/imx.c
> >> >> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
> >> >>  	struct imx_port *sport = dev_id;
> >> >>  	unsigned int rx, flg;
> >> >>  	struct tty_port *port = &sport->port.state->port;
> >> >> +	typeof(sport->port.membase) membase = sport->port.membase;
> >> >>  	u32 usr2;
> >> >>  
> >> >>  	/* If we received something, check for 0xff flood */
> >> >> -	usr2 = imx_uart_readl(sport, USR2);
> >> >> +	usr2 = readl(membase + USR2);
> >> >>  	if (usr2 & USR2_RDR)
> >> >>  		imx_uart_check_flood(sport, usr2);
> >> >>  
> >> >> -	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
> >> >> +	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
> >> >>  		flg = TTY_NORMAL;
> >> >>  		sport->port.icount.rx++;
> >> >
> >> > I'd just make a uport local variable and use uport->membase + xx. There 
> >> > are plenty of sport->port constructs to replace with uport in that 
> >> > function anyway.
> >> 
> >> OK, thanks, will do it this way. Probably with global rename over this
> >> function in a separate patch?
> >
> > Yes, it is better to have it in own patch.
> 
> Well, it now seems that I'll drop this patch altogether, by agreement
> with Uwe. Do you think introducing of 'uport' still worth it in this
> one function? I figure it's probably not, provided the reset of the code
> in the driver still doesn't use the idiom.

I've no strong opinion either way. So feel free to leave them as they are 
now.

-- 
 i.

--8323329-1951260190-1674070196=:1750--
