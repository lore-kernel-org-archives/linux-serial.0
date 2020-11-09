Return-Path: <SRS0=KjKo=EP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1223C4741F
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 09:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9284220789
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604915073;
	bh=dkQUreQkm6GVXf3wbW77146mTQTUWGCf4AZoWBluopk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jNfwsm+5XO82ShyzYeiXawxBkyfKbqsWFfCmSzZC7VikLooml2ifk7f5q1gnOYrvT
	 3aF9jAdjXJuh98pzREy/z9hEktYNVhZ1JUjeR2jtErDJvvy/EsNveiTelm+LxjkxdA
	 9gM9rwSEntq9IKpd6+7G/8C78IP8UJKopqGZFVk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgKIJoc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Nov 2020 04:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgKIJob (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Nov 2020 04:44:31 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E2A206ED;
        Mon,  9 Nov 2020 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604915069;
        bh=dkQUreQkm6GVXf3wbW77146mTQTUWGCf4AZoWBluopk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGPDsYkU9amPsMDGQWS+t1ct1mMz47zcrP257HyLnTmPll/Ei3CD4DqSSRDQleF1h
         a5n2sHvQqLaBX28Sdv8X7iAr1FZkHFRJxK+Dh+3D66B9bVemyNnFAz5s0SEsWmzssE
         y6PJ5rZz5Np4wf4LExBCoGsolUlKJZ9zpwV33BAc=
Date:   Mon, 9 Nov 2020 10:45:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 2/2] drivers/tty: delete break after goto/return
Message-ID: <20201109094529.GA832649@kroah.com>
References: <20201107032924.25044-1-bernard@vivo.com>
 <20201107032924.25044-3-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107032924.25044-3-bernard@vivo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 06, 2020 at 07:29:24PM -0800, Bernard Zhao wrote:
> Delete break after goto/return, which will never run.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/tty/nozomi.c | 4 ----
>  1 file changed, 4 deletions(-)

If you look at the commits for this file:

	$ git log --oneline drivers/tty/nozomi.c | head -n 5
	1a460c36078e tty: nozomi: remove unneeded break
	caa47cc63947 tty: nozomi: Use scnprintf() for avoiding potential buffer overflow
	e2c2e7987106 tty: nozomi: fix spelling mistake "reserverd" -> "reserved"
	18b1345e60ae tty: nozomi: Use dev_get_drvdata
	c392ed464205 tty/nozomi: use pci_iomap instead of ioremap_nocache

You will notice that you should probably put the driver name in the
subject line.  Otherwise this patch really looks like you are doing this
action on all of drivers/tty/ right?

Same for patch 1/2 as was pointed out by others.

thanks,

greg k-h
