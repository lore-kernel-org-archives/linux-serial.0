Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0687C2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 11:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42917223FD
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604491158;
	bh=VYBsXiXrYl7rJ+8UiwwTogyHicS+8WxebwYlJQWgCkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eqZLSBg7/u24oYDegtfSoa2pUX8lkYWcfTcudmIl2AmPMfpt6Ub9y+05QDQYO5P2A
	 3GzXnOFRALmbNG9otPp60v/yC3HmBAvTWw5JSIvWnBXjD4gfJvNdGuADGKYz5yzMEk
	 th/crB6/VpXc6MZUhtSoHqVDEwPQcmMtjn0EjxVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgKDL7R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 06:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbgKDL6O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 06:58:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793A520759;
        Wed,  4 Nov 2020 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604491093;
        bh=VYBsXiXrYl7rJ+8UiwwTogyHicS+8WxebwYlJQWgCkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWRQQ8KyznKGN8gvdFOT6PHGpzL5Sns1/zWQFF1+HcjdpRb2d7Ci6FUjZsSWntWe0
         CrkGWOCihpIWLk3tTTC846bUhCffQhzB/qV4ZqG3yHhMissmPpqZRFdeaPAFytRSh+
         XedLtgGFQBd9e2ShLjVqt/fCaYOA+RD/IxAjh5OE=
Date:   Wed, 4 Nov 2020 12:59:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bernard <bernard@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: Re: [PATCH 0/2] drivers/tty: delete break after return or goto
Message-ID: <20201104115903.GA1694605@kroah.com>
References: <20201104110253.GB1688848@kroah.com>
 <AM2AyQC0Da1dbRopcUQABart.3.1604488676603.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM2AyQC0Da1dbRopcUQABart.3.1604488676603.Hmail.bernard@vivo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 04, 2020 at 07:17:56PM +0800, Bernard wrote:
> 
> 
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: 2020-11-04 19:02:53
> To:  Bernard Zhao <bernard@vivo.com>
> Cc:  Jiri Slaby <jirislaby@kernel.org>,Shawn Guo <shawnguo@kernel.org>,Sascha Hauer <s.hauer@pengutronix.de>,Pengutronix Kernel Team <kernel@pengutronix.de>,Fabio Estevam <festevam@gmail.com>,NXP Linux Team <linux-imx@nxp.com>,linux-kernel@vger.kernel.org,linux-serial@vger.kernel.org,linux-arm-kernel@lists.infradead.org,opensource.kernel@vivo.com
> Subject: Re: [PATCH 0/2] drivers/tty: delete break after return or goto>On Wed, Nov 04, 2020 at 02:53:29AM -0800, Bernard Zhao wrote:
> >> This patch sereies optimise code like:
> >> {
> >> case XXX:
> >> 	return XXX;
> >> 	break; //The break is meanless, so just delete it.
> >> case YYY:
> >> 	goto YYY;
> >> 	break; //The break is meanless, so just delete it.
> >> ......
> >> }
> >> 
> >> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> >> 
> >> ---
> >> Bernard Zhao (2):
> >>   drivers/tty/nozomi.c: delete no use break after goto
> >>   drivers/tty/serial/imx.c: delete no use break after return
> >
> >That is not the subject of the patches you sent out, what broke?
> 
> Hi:
> 
> I am sorry that I am a little confused:
> The patch series`s subject is "drivers/tty: delete break after return or goto"
> and the blurb is:
> This patch sereies optimise code like:
> {
> case XXX:
> 	return XXX;
> 	break; //The break is meanless, so just delete it.
> case YYY:
> 	goto YYY;
> 	break; //The break is meanless, so just delete it.
> ......
> }
> last, the modified files are:
> Bernard Zhao (2):
>   drivers/tty/nozomi.c: delete no use break after goto
>   drivers/tty/serial/imx.c: delete no use break after return
> 
> Is there something wrong that I didn`t catch?

The above lines do not match up with the subject lines of the patches
you sent out, so something went wrong.

thanks,

greg k-h
