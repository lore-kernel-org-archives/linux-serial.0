Return-Path: <SRS0=GjS6=AX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F1C433E1
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jul 2020 08:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC9C2072D
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jul 2020 08:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594543437;
	bh=22sV2MagMmijC5jLGB+iBOFAm/AVasieEZPd64yd1fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C2TVU5nG3zmWj3jeW/HcBbk/EZnjf0AbOoVL+8+Ze679FlCqkOgrZ3Ew5yWKuDseA
	 AC0IcsjkeomB+fHccvCuSQUB/DVhi3QtZKvBvH7zPaV+vKWJ/ZIHwsGKcLvr/oOvh3
	 1a2tKiMGBBe1kW+t+2cik/IN2DlrPzJ0mkLevQwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgGLIn4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Jul 2020 04:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:32820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgGLIn4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Jul 2020 04:43:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBEC206F4;
        Sun, 12 Jul 2020 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594543435;
        bh=22sV2MagMmijC5jLGB+iBOFAm/AVasieEZPd64yd1fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRgGTQSSupucv9ZBmwj4sElmGyb4FjlfugP19PVIFD1FFuq1pgwDfzVOflaRp8vJD
         jHMKXKq5T5jkc0r5FH5PPj2nshal6aI69KN+femZ0MXChU7hIBFPeaVwW6buCVx3dx
         1OqlctSANgEK0KMa4otrP9XS6HxyXkVO/bcz2OhM=
Date:   Sun, 12 Jul 2020 10:43:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Jiri Slaby <jslaby@suse.com>,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v7 3/3] leds: trigger: implement a tty trigger
Message-ID: <20200712084352.GA175558@kroah.com>
References: <20200707165958.16522-1-u.kleine-koenig@pengutronix.de>
 <20200707165958.16522-4-u.kleine-koenig@pengutronix.de>
 <20200712082453.GI8295@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712082453.GI8295@amd>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jul 12, 2020 at 10:24:53AM +0200, Pavel Machek wrote:
> > +++ b/drivers/leds/trigger/ledtrig-tty.c
> > @@ -0,0 +1,192 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> 2.0+ is preffered.

No it is not, that's up to the developer.

thanks,

greg k-h
