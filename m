Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19198E8FDDD
	for <linux-serial@archiver.kernel.org>; Wed,  4 Oct 2023 09:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbjJDJJG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Oct 2023 05:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbjJDJJE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Oct 2023 05:09:04 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CABEDAD;
        Wed,  4 Oct 2023 02:09:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D833A80BD;
        Wed,  4 Oct 2023 09:09:00 +0000 (UTC)
Date:   Wed, 4 Oct 2023 12:08:59 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Check for valid console index
Message-ID: <20231004090859.GF34982@atomide.com>
References: <20231004085511.42645-1-tony@atomide.com>
 <1fc2dc1d-33f2-6d65-6bdb-d4c7421cbc57@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fc2dc1d-33f2-6d65-6bdb-d4c7421cbc57@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [231004 09:05]:
> On Wed, 4 Oct 2023, Tony Lindgren wrote:
> 
> > Let's not allow negative numbers for console index.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/tty/serial/8250/8250_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -611,7 +611,7 @@ static int univ8250_console_setup(struct console *co, char *options)
> >  	 * if so, search for the first available port that does have
> >  	 * console support.
> >  	 */
> > -	if (co->index >= UART_NR)
> > +	if (co->index < 0 || co->index >= UART_NR)
> >  		co->index = 0;
> 
> The inconsistencies how different serial drivers handle this situation 
> seem staggering. Perhaps there should be some effort to make the behavior
> uniform across them?

Hmm yeah we should just have them all check for co->index < 0.

Regards,

Tony
