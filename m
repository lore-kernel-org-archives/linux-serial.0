Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A7BC6FD20
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 12:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCXMfY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 08:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXMfX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 08:35:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09912BD3
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679661322; x=1711197322;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4UEUlRUAxbgrJwTxN1Lz8b/gdCkUHib8jgkLGCAHT54=;
  b=Vu696hjtBz+bvKMfxYfVyM5voJXY7LIqY7SVG/yVZoVL2JUGh18qY0LG
   +Yh3gCDwBe6s2UNm6Vv/zgLYWsyXLg+Ym9SyzTa85UfOlbuvxk1Oh57qR
   5mIWgxsnFUJ41+4NFP5Z6sXlbSA/KgG6qXCs1DKHunM8K1J1Kt8dHtRiK
   /R73JCBtkcQAsdYQ28+JmToygQVUYm/OIZuESwjkKVT4TN7jYY40Q9Pgj
   a0ZZo7DoZe7DW9wXM8au2+OG5Q2MDQ/j6AHts85yv5JWDw6HUn457Wg9o
   pOU5CLXpQu0uMuoqBTA88jgUF+JuuaIT24J//LGhAzPYtqQzAHQ63u7xc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="339793065"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="339793065"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="747148216"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="747148216"
Received: from dmendyk-mobl2.ger.corp.intel.com ([10.252.38.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:35:18 -0700
Date:   Fri, 24 Mar 2023 14:35:15 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Francesco Dolcini <francesco@dolcini.it>
cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        =?ISO-8859-2?Q?Tomasz_Mo=F1?= <tomasz.mon@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
In-Reply-To: <ZB2W4bKfuO7tvAaU@francesco-nb.int.toradex.com>
Message-ID: <989d6a6f-fd4d-3e53-d417-ddf71ccf7af@linux.intel.com>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com> <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com> <ZB2W4bKfuO7tvAaU@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-121619625-1679661321=:2165"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-121619625-1679661321=:2165
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 24 Mar 2023, Francesco Dolcini wrote:

> Hello
> 
> On Fri, Mar 24, 2023 at 01:47:59PM +0200, Ilpo Järvinen wrote:
> > On Fri, 24 Mar 2023, Stefan Wahren wrote:
> > > after switching to Linux 6.1.21 on our Tarragon board (i.MX6ULL SoC), we
> > > experience the following issues with the debug UART (115200 baud, 8N1, no
> > > hardware flow control):
> > > 
> > > - overrun errors if we paste in multiple text lines while system is idle
> > > - no reaction to single key strokes while system is on higher load
> > > 
> > > After reverting 7a637784d517 ("serial: imx: reduce RX interrupt frequency")
> > > the issue disappear.
> > > 
> > > Maybe it's worth to mention that the Tarragon board uses two additional
> > > application UARTs with similiar baud rates (9600 - 115200 baud, no hardware
> > > flow control) for RS485 communication, but there are no overrun errors (with
> > > and without the mention change).
> > 
> > This has come up earlier, see e.g.:
> > 
> > https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
> 
> yep, it looks exactly the same issue.
> 
> We did not verify if this was affecting other UARTs. However, isn't RS485 
> half-duplex?

While half-duplex is more likely by far due simplicity, RS485 could also 
be full-duplex. It seems imx driver supports for both modes.

-- 
 i.

> This is very likely a difference compared to the RS232
> console port.
> 
> I am also not really convinced this is a proper regression, while 7a637784d517
> clearly is making the situation _worst_, we had some issues even before -
> unfortunately I have no much more details available.


--8323329-121619625-1679661321=:2165--
