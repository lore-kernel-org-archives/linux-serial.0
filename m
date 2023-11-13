Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80186C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 14:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjKMObN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 09:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMObM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 09:31:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C1D59
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 06:31:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F554C433C7;
        Mon, 13 Nov 2023 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699885868;
        bh=EFRRufbeFQ+IM6jr2E8iXNUpk4Tyw5xoM0LYuJZwr8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPDiCWXSIqFqXZ9MOcD99iR88SRKkLJSmnwlm8qL6KDxCfToWHGm6CcOqGS1gASdr
         /iJKFCZcJeiJhzAti/ScTSRQ1etmlJdz1geaJa/4TYngvaPNFQyDBywqYk4QQRyOrs
         0vnlmNE10/B5JXu0n+NRzGFs4gr19pkFXSACiE9I=
Date:   Mon, 13 Nov 2023 09:31:04 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michal Simek <michal.simek@amd.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>, linux-serial@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Julien Malik <julien.malik@unseenlabs.fr>,
        kernel@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 52/52] serial: xilinx_uartps: Convert to platform remove
 callback returning void
Message-ID: <2023111330-tigress-suffering-e329@gregkh>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-53-u.kleine-koenig@pengutronix.de>
 <15784357-6557-4431-a1dd-128152b48160@amd.com>
 <20231113100342.sih3te7a7z5jeh4j@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113100342.sih3te7a7z5jeh4j@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 13, 2023 at 11:03:42AM +0100, Uwe Kleine-König wrote:
> On Mon, Nov 13, 2023 at 10:41:17AM +0100, Michal Simek wrote:
> > 
> > 
> > On 11/10/23 16:30, Uwe Kleine-König wrote:
> > > The .remove() callback for a platform driver returns an int which makes
> > > many driver authors wrongly assume it's possible to do error handling by
> > > returning an error code. However the value returned is ignored (apart
> > > from emitting a warning) and this typically results in resource leaks.
> > > 
> > > To improve here there is a quest to make the remove callback return
> > > void. In the first step of this quest all drivers are converted to
> > > .remove_new(), which already returns void. Eventually after all drivers
> > > are converted, .remove_new() will be renamed to .remove().
> > > 
> > > Trivially convert this driver from always returning zero in the remove
> > > callback to the void returning variant.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >   drivers/tty/serial/xilinx_uartps.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> > > index 66a45a634158..6decf2b13340 100644
> > > --- a/drivers/tty/serial/xilinx_uartps.c
> > > +++ b/drivers/tty/serial/xilinx_uartps.c
> > > @@ -1666,7 +1666,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
> > >    *
> > >    * Return: 0 on success, negative errno otherwise
> > 
> > this line should be also removed.
> 
> Good catch.
> 
> @gregkh: What is the preferred way to address that? I can follow up with
> a patch on top of this one (and you squash it or not), I can send a
> patch that gets that does the conversion and drops the comment (and you
> skip this incomplete patch when applying this series) or I can resend
> the whole series in a week or so.

Follow-on patch is fine, I'll take this whole series in a week when I
catch up from the merge-window-backlog as I'm at the Plumbers conference
this week...

thanks,

greg k-h
