Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9617CD4F3B
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 09:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjIVJcJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjIVJbu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 05:31:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAF01FDA
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695375057; x=1726911057;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vP70tJL0y53yHDYrBXev7BykI+BDY01P7lV3zOkf31Y=;
  b=IDncVsw90viWlG2gb5KOKHQzfTIazge2u04AOWPfQ7UrkMHnexdo/pc2
   PeuSCo2lvzshKfTRRcesY/HEnNMvEVsldlSqFKCGByhDhArJDZ5MjKNyG
   KcoIRGyD03GKWewNab8fy4O5mFkhJTo+Pc3yKmoaV/7EfhRzuLb8jsNdL
   fdDAjrW7H7HVi9KGFDQ0Zg8EbuNFyfELZtSgkAASFCRXTsHYgX3LpGqz5
   QAK+7bZu6YIL71UAJ4FbUjIwIbLqYcAR5VsIMtju/WplCONMIY4QPJFya
   JgTsk+RGWuNXYeokFVqB/NdcHpIyIov7Q3YR7Pr7fM0fZ2VfDiPVK/CnW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="365841819"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="365841819"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:30:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862879822"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="862879822"
Received: from rblanarx-mobl.ger.corp.intel.com ([10.252.52.48])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:30:55 -0700
Date:   Fri, 22 Sep 2023 12:30:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH tty-linus] serial: Reduce spinlocked portion of
 uart_rs485_config()
In-Reply-To: <20230922040433.GB9800@wunner.de>
Message-ID: <fd131a69-2cfb-7ff1-a3a5-44f591ca766@linux.intel.com>
References: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de> <9888a15-d626-d262-203f-b5f49fa4494@linux.intel.com> <20230922040228.GA9800@wunner.de> <20230922040433.GB9800@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-204499538-1695375056=:1840"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-204499538-1695375056=:1840
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2023, Lukas Wunner wrote:

> On Fri, Sep 22, 2023 at 06:02:28AM +0200, Lukas Wunner wrote:
> > On Thu, Sep 21, 2023 at 06:01:41PM +0300, Ilpo Järvinen wrote:
> > > On Thu, 21 Sep 2023, Lukas Wunner wrote:
> > > > --- a/drivers/tty/serial/serial_core.c
> > > > +++ b/drivers/tty/serial/serial_core.c
> > > > @@ -1404,12 +1404,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
> > > >  static int uart_rs485_config(struct uart_port *port)
> > > >  {
> > > >  	struct serial_rs485 *rs485 = &port->rs485;
> > > > +	unsigned long flags;
> > > >  	int ret;
> > > >  
> > > > +	if (!(rs485->flags & SER_RS485_ENABLED))
> > > > +		return 0;
> > > > +
> > > >  	uart_sanitize_serial_rs485(port, rs485);
> > > 
> > > There's a subtle change in behavior here, uart_sanitize_serial_rs485() 
> > > memset()s rs485 if RS485 is not enabled but the early return above does 
> > > not.
> > 
> > The two callers of uart_rs485_config() only call it if
> > (!(uport->rs485.flags & SER_RS485_ENABLED)).
> 
> I meant to say "if (uport->rs485.flags & SER_RS485_ENABLED)"
> (i.e. without negation).
> 
> Otherwise my point still stands. :)

Okay yeah, it's fine. I did not take the behavior under the old code into 
account well enough.

-- 
 i.

--8323329-204499538-1695375056=:1840--
