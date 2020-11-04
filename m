Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6AFC2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 06:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80AC2236F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 06:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604472572;
	bh=xqykfczUUz+aTboZ89/jxPO0XdXGPu6KMa6XmUqqQLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bYvzq04kVNFjweIa5cqxRLRpUctptQB1/wJ7xQG7YflXxia/VLlyHrCCACZlEfF3s
	 qsFeRpxq85U1lQ7WTCFrnKOvBl5ef9viTWzqpBvi4CC+/ceyaczjhYAx9/5Qqvxu8y
	 6qDljrN7Q93G3+5LvyAm35cc3RwGP8zk68qW5Agk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKDGtc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 01:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgKDGtc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 01:49:32 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03682222B;
        Wed,  4 Nov 2020 06:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604472571;
        bh=xqykfczUUz+aTboZ89/jxPO0XdXGPu6KMa6XmUqqQLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h27RLv8lI4J3592Ut/lzfF+34R3jv7R9WHjVn2pYzhufnkWy/BNcvQYHAfAs+75wN
         3nDF7ijyzTh9sIqbXfdX+aqkPJbPxkqTYbOvIsGK26CtEqhcvNSPGf5jS2kmMc+Wyo
         oZqxMehf35gpuE1cQsYQzkOOlnVmBSE10SCs1DaA=
Date:   Wed, 4 Nov 2020 07:49:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 0/2] drivers/tty: delete break after return
Message-ID: <20201104064927.GA681413@kroah.com>
References: <20201104063327.15572-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104063327.15572-1-bernard@vivo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 03, 2020 at 10:33:22PM -0800, Bernard Zhao wrote:
> This patch sereies delete break after return, which will never run.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> *** BLURB HERE ***

No blurb?

> 
> Bernard Zhao (2):
>   drivers/tty: delete break after return
>   drivers/tty: delete break after return

You sent different patches, doing different things, yet they have the
same subject lines?  That's not acceptable, sorry.  Please fix up and
resend a new version of this series.

Also, you sent 4 patches, not 2.

thanks,

greg k-h
