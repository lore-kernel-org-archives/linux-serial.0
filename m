Return-Path: <SRS0=UUkf=D3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C6EC41604
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFD422251
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603215426;
	bh=QOpjHS7bCAquiOFhX0yeTVHhmICVnAJeN2C/qruwuD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uNj61f4ULhwPkAcUJLY1upl9dBViibV9F79laMSOrPK92/LXGfqO04AJ6J2hNFMqR
	 9FT/rKlx42ztMvy6zWVbKzzKCfHzbwJYs6RvRsVtYUOaoSQfYMDdFDcAVel5cQgbv6
	 LAyVYaWSEu5EVltibMcWFTAOaBwQ1M8IULahgD5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391392AbgJTRhE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Oct 2020 13:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgJTRhE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 13:37:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ABEB2222D;
        Tue, 20 Oct 2020 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603215423;
        bh=QOpjHS7bCAquiOFhX0yeTVHhmICVnAJeN2C/qruwuD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSqgB+w4+Cib8lOLhmp8nMe7UKWWIM/KzlYbUUgYDze4rXIs+97J3t2Wrj6mLWvnv
         2M8Rr9+5OlDsSEgojkYUHWWvap9tV4mftQXjruDKm5w7qUx/2EuxSP60e+Wa6H3CJD
         U3HeidKvfY6IWIpQiMp7QGMCKpR35fYYIi+7T6QY=
Date:   Tue, 20 Oct 2020 19:37:45 +0200
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
Message-ID: <20201020173745.GA882703@kroah.com>
References: <20201020162303.1730562-1-laurent@vivier.eu>
 <20201020162844.GA865546@kroah.com>
 <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 20, 2020 at 06:37:41PM +0200, Laurent Vivier wrote:
> Le 20/10/2020 à 18:28, Greg KH a écrit :
> > On Tue, Oct 20, 2020 at 06:23:03PM +0200, Laurent Vivier wrote:
> >> We can avoid to probe for the Zilog device (and generate ugly kernel warning)
> >> if kernel is built for Mac but not on a Mac.
> >>
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >> ---
> >>  drivers/tty/serial/pmac_zilog.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> >> index 063484b22523..d1d2e55983c3 100644
> >> --- a/drivers/tty/serial/pmac_zilog.c
> >> +++ b/drivers/tty/serial/pmac_zilog.c
> >> @@ -1867,6 +1867,12 @@ static struct platform_driver pmz_driver = {
> >>  static int __init init_pmz(void)
> >>  {
> >>  	int rc, i;
> >> +
> >> +#ifdef CONFIG_MAC
> >> +	if (!MACH_IS_MAC)
> >> +		return -ENODEV;
> >> +#endif
> > 
> > Why is the #ifdef needed?
> > 
> > We don't like putting #ifdef in .c files for good reasons.  Can you make
> > the api check for this work with and without that #ifdef needed?
> 
> The #ifdef is needed because this file can be compiled for PowerMac and
> m68k Mac. For PowerMac, the MACH_IS_MAC is not defined, so we need the
> #ifdef.
> 
> We need the MAC_IS_MAC because the same kernel can be used with several
> m68k machines, so the init_pmz can be called on a m68k machine without
> the zilog device (it's a multi-targets kernel).
> 
> You can check it's the good way to do by looking inside:
> 
>     drivers/video/fbdev/valkyriefb.c +317
>     drivers/macintosh/adb.c +316
> 
> That are two files used by both, mac and pmac.

Why not fix it to work properly like other arch checks are done?

Put it in a .h file and do the #ifdef there.  Why is this "special"?

thanks,

greg k-h
