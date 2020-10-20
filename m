Return-Path: <SRS0=UUkf=D3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3970C4363A
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737B622247
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603211283;
	bh=Q3yKsQuTMrcCf0pwDqkIgVljF9mzA/TS1grr6L4FtrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZXB7H1hW/N3deCymJPij9Tvf9gvmZhUwASD+D6zhz4vsN0PqXF1fjFb5N7+7/Sa0U
	 9b3w4XsWuSgK0qdIWzD2nx235j8dkQ0+B3oU2WFnNjo59AOLySt6mYSxiyFpckW3dc
	 xKa1VbxlPUFBqNic+rYE7l6gU3tnXD9koUwCjS5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394597AbgJTQ2D (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Oct 2020 12:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgJTQ2D (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 12:28:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06E122242;
        Tue, 20 Oct 2020 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603211282;
        bh=Q3yKsQuTMrcCf0pwDqkIgVljF9mzA/TS1grr6L4FtrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+iOUOOr2Xrs9zjFAHwZ8brvdqar2y0zqIlt8H+D3GRTfTAjnUfC7mA5Z7eJ5BCiK
         bLWvQfZZtncflquf6cgbIS33mqTyw3vEc8Wkwkm9PS1Uw/llJ6sZzwc+KsBuB7SWQ2
         aCra1cHp0/IoYh0qA2M1Y8Hm7eE/g8SsUNkZsaA8=
Date:   Tue, 20 Oct 2020 18:28:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, Joshua Thompson <funaho@jurai.org>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not available
Message-ID: <20201020162844.GA865546@kroah.com>
References: <20201020162303.1730562-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020162303.1730562-1-laurent@vivier.eu>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 20, 2020 at 06:23:03PM +0200, Laurent Vivier wrote:
> We can avoid to probe for the Zilog device (and generate ugly kernel warning)
> if kernel is built for Mac but not on a Mac.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  drivers/tty/serial/pmac_zilog.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index 063484b22523..d1d2e55983c3 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -1867,6 +1867,12 @@ static struct platform_driver pmz_driver = {
>  static int __init init_pmz(void)
>  {
>  	int rc, i;
> +
> +#ifdef CONFIG_MAC
> +	if (!MACH_IS_MAC)
> +		return -ENODEV;
> +#endif

Why is the #ifdef needed?

We don't like putting #ifdef in .c files for good reasons.  Can you make
the api check for this work with and without that #ifdef needed?

thanks,

greg k-h
