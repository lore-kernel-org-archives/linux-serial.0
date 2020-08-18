Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCFAC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 09:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3D8206DA
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgHRJzn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:55:43 -0400
Received: from muru.com ([72.249.23.125]:40756 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgHRJzn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 05:55:43 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E575B810D;
        Tue, 18 Aug 2020 09:55:41 +0000 (UTC)
Date:   Tue, 18 Aug 2020 12:56:09 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] n_gsm: Fix write handling for zero bytes written
Message-ID: <20200818095609.GQ2994@atomide.com>
References: <20200817135454.28505-1-tony@atomide.com>
 <1b8538a8-d8b6-4287-36e1-aa1e0863ff2d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8538a8-d8b6-4287-36e1-aa1e0863ff2d@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

* Jiri Slaby <jirislaby@kernel.org> [200818 08:24]:
> On 17. 08. 20, 15:54, Tony Lindgren wrote:
> > If write returns zero we currently end up removing the message
> > from the queue. Instead of removing the message, we want to just
> > break out of the loop just like we already do for error codes.
> 
> When exactly does the only writer (gsmld_output) return zero for
> non-zero len parameter?

I ran into this when testing with the WIP serial core PM runtime
changes from Andy Shevchenko earlier. If there are also other
cases where we have serial drivers return 0, I don't know about
them.

Basically with the WIP serial core changes, if the open serial port
is in PM runtime suspended state with it's autosuspend_delay_ms
expired, we have write return 0 and just wake up the serial device
on TX.

I don't think there's much anything else we can currently do there
in the PM runtime suspended case as we want to get rid of the
remaining pm_runtime_irq_safe() dependencies as it takes a permanent
usage count on the parent device.

Regards,

Tony

> 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/tty/n_gsm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -691,7 +691,8 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
> >  			print_hex_dump_bytes("gsm_data_kick: ",
> >  					     DUMP_PREFIX_OFFSET,
> >  					     gsm->txframe, len);
> > -		if (gsm->output(gsm, gsm->txframe, len) < 0)
> > +
> > +		if (gsm->output(gsm, gsm->txframe, len) <= 0)
> >  			break;
> >  		/* FIXME: Can eliminate one SOF in many more cases */
> >  		gsm->tx_bytes -= msg->len;
> > 
> 
> thanks,
> -- 
> js
