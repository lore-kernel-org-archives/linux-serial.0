Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CDFC388F7
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 20:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C741920729
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604606933;
	bh=qOJvHocxdRNHZRp8pdlENMHgLxIxREjnG3QeG0yu/WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uvc8e59RHeON/EjrcfDd1o2m8jtesuE5MGeeEDEaM7ErYyvhwIXOTxF7L09ykaBCa
	 OXaygszynwI3hL+PGQvGDH0TEtGhupxqYeRpD1u2HFhWUjcP/leBB84tVS8DjwWWRr
	 CfvF03InOB2o8LxkX7Zyt9PkADtGsTWleLWlJb/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKEUIv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:08:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEUIv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 15:08:51 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E78052074B;
        Thu,  5 Nov 2020 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604606930;
        bh=qOJvHocxdRNHZRp8pdlENMHgLxIxREjnG3QeG0yu/WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmgyWi14DvmO+kXpfF83Lm0DNxIOghirKLXPsKMUW+xUA5YsC0MdSQ3x1ZKPqXrFx
         CIWw15EK+UzMzqcGfsPEESN5eY53bc/0Q3HmyfvrHqL4u2w2ykjWRG171zL0j7WQ1r
         AuLE8MPlExBjWXfoP2vkV7DkPKToS7IvCqvNhH98=
Date:   Thu, 5 Nov 2020 21:09:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-serial@vger.kernel.org, patchwork-lst@pengutronix.de,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] tty: serial: imx: enable earlycon by default if
 IMX_SERIAL_CONSOLE is enabled
Message-ID: <20201105200938.GD1333458@kroah.com>
References: <20201105170506.1794306-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105170506.1794306-1-l.stach@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 05, 2020 at 06:05:06PM +0100, Lucas Stach wrote:
> Since 699cc4dfd140 (tty: serial: imx: add imx earlycon driver), the earlycon
> part of imx serial is a separate driver and isn't necessarily enabled anymore
> when the console is enabled. This causes users to loose the earlycon
> functionality when upgrading their kenrel configuration via oldconfig.
> 
> Enable earlycon by default when IMX_SERIAL_CONSOLE is enabled.
> 
> Fixes: 699cc4dfd140 (tty: serial: imx: add imx earlycon driver)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

What changed from v1?  Always put that below the --- line so we know.

Please fix up and resend a v3.

thanks,

greg k-h
