Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16474C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18BF60233
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhDZMX2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhDZMXX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 08:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B523A61176;
        Mon, 26 Apr 2021 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619439757;
        bh=DI/2ZhwMC67aq53smebwkDVY0NUjo0VkDaa5MUtRSmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+uxDdL/1t6gXfqWBO4APU6dhN85Wm4hBIHC7c6txaX1ngLn54SvBRjIGaQR/zPx7
         GsDnIRcyCS+eSwff8aWZvhBuggfQGz6M2cb/gEkt2QYEHVwDeHqxO8r4kTJerPpZdV
         n2WMbeR06/JJIrOZ2r7PuqUMsmfsK9S/5tm9ak5g=
Date:   Mon, 26 Apr 2021 14:22:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
Message-ID: <YIawisbbnU4Us1eT@kroah.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-3-sherry.sun@nxp.com>
 <YIZ1NvISshNHtX/Z@kroah.com>
 <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 11:39:03AM +0000, Sherry Sun wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: 2021年4月26日 16:09
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
> > dereference null return value
> > 
> > On Mon, Apr 26, 2021 at 03:49:35PM +0800, Sherry Sun wrote:
> > > This issue is reported by Coverity Check.
> > > In lpuart_probe, return value of function which returns null is
> > > dereferenced without checking.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index 777d54b593f8..c95e71fd2ca0
> > > 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -2589,6 +2589,9 @@ static int lpuart_probe(struct platform_device
> > *pdev)
> > >  	struct resource *res;
> > >  	int ret;
> > >
> > > +	if (!sdata)
> > > +		return -ENODEV;
> > 
> > How can sdata be NULL?
> 
> Is it possible that a case forgot to set sdata? Then the value will be NULL, such as { .compatible = "fsl,imx8qxp-lpuart",  }.

If a case forgets to set that somehow, then the driver will never work
with that kernel change, so someone better not submit that update :)

No need to check for something that is impossible to hit.

thanks,

greg k-h
