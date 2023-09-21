Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB761E7D0A2
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 20:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjIUU02 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjIUU0H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C619F90F24
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318447; x=1726854447;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HtXkTH1ttm/bIWgCVw3aQAyWB3DLiDKds5D9EpzYJcM=;
  b=N26eQCWjKF87Js4XeDLJkc8k10jqceUYQUTHZBsWh4/07R3zIjA22n30
   A0hee8vrsSqJA4dD2XntWIAmi/GtAA13ZQE5LCdpkx/BF6iqfq5FYkRmA
   342fOhBuPAZmlSEsZIb/p6ebvpGX+O28+pPzez2YInvAkudKmRrgKDzyE
   Yb7IpxbIlRBTwAyJ9maa2ekPnGo9a1P3A5ibhly0syUacHmqLcO7SBCRD
   Dl57DeeRB+i7D18fiZBQ/SCnMP9j4lTfR5g/RugN27QuUR4pP9UbXcNa5
   iAtNZibOOibbx+lBXBX2sxbsSwowCRCLS6lzxJ4s42mHoXMHMhwrj8efT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="377847040"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="377847040"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 08:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="1077928991"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="1077928991"
Received: from rladysz-mobl2.ger.corp.intel.com ([10.252.52.175])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 08:23:58 -0700
Date:   Thu, 21 Sep 2023 18:23:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH tty-linus] serial: Reduce spinlocked portion of
 uart_rs485_config()
In-Reply-To: <87zg1fees3.fsf@jogness.linutronix.de>
Message-ID: <c0ead126-baf1-5b4-fbf5-34f8672f390@linux.intel.com>
References: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de> <87zg1fees3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 21 Sep 2023, John Ogness wrote:

> On 2023-09-21, Lukas Wunner <lukas@wunner.de> wrote:
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 7bdc21d5e13b..ca26a8aef2cb 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1404,12 +1404,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
> >  static int uart_rs485_config(struct uart_port *port)
> >  {
> >  	struct serial_rs485 *rs485 = &port->rs485;
> > +	unsigned long flags;
> >  	int ret;
> >  
> > +	if (!(rs485->flags & SER_RS485_ENABLED))
> > +		return 0;
> > +
> >  	uart_sanitize_serial_rs485(port, rs485);
> >  	uart_set_rs485_termination(port, rs485);
> >  
> > +	spin_lock_irqsave(&port->lock, flags);
> >  	ret = port->rs485_config(port, NULL, rs485);
> > +	spin_unlock_irqrestore(&port->lock, flags);
> >  	if (ret)
> >  		memset(rs485, 0, sizeof(*rs485));
> 
> Is there some kind of guarantee that 2 CPUs cannot go into
> uart_rs485_config() simultaneously? Otherwise it seems dangerous to be
> using and clearing @port->rs485 outside of the spin_lock.

Both callers seem to be inside tty port's mutex.

-- 
 i.

