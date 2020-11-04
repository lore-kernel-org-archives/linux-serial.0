Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124EDC2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 11:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5EC0221F9
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604487724;
	bh=W+3QSsbuXdJVSCV51q6c6auVI0NKTOuW/rHh0EGgt0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jA3wdyuRK/c38GkuMFxWrjqgf5QYpxT+e7Hl61xYPTtU7tLafGLOtU4QKWiAQfWSM
	 RNu+S9l224qjwwUSnNG4KtCiSbgxlweqpmZ5lBQnmonQ8E7yIJglq0YgkYoujElLqx
	 F+87jxLx9IsM1FbjKj1QLg/YbeG0r/lhNgsANoMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgKDLCE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 06:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDLCE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 06:02:04 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AE720867;
        Wed,  4 Nov 2020 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604487723;
        bh=W+3QSsbuXdJVSCV51q6c6auVI0NKTOuW/rHh0EGgt0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nurarh21VMIMoEwhAIZMBHGPYSK7vnzTUaEbu4qlm6ac0+hwaMe2szcQdyW7SLwtz
         7gXOC7gb3HAsGHN6RmrbRvoMtUDT0DfiOgRl2iYTBSUHqwxowv7t7dt7MO63/Nzt6x
         CwKsFzkmJdQM04F4KthCnNwobMzSVyjaZ5Yf50t0=
Date:   Wed, 4 Nov 2020 12:02:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 0/2] drivers/tty: delete break after return or goto
Message-ID: <20201104110253.GB1688848@kroah.com>
References: <20201104105331.16654-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104105331.16654-1-bernard@vivo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 04, 2020 at 02:53:29AM -0800, Bernard Zhao wrote:
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
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> 
> ---
> Bernard Zhao (2):
>   drivers/tty/nozomi.c: delete no use break after goto
>   drivers/tty/serial/imx.c: delete no use break after return

That is not the subject of the patches you sent out, what broke?

