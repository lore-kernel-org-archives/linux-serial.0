Return-Path: <SRS0=GjS6=AX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F3AC433E0
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jul 2020 09:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD4020791
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jul 2020 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594546321;
	bh=QbBUjOO2ONnvgGnMB4P8D8RHlpRM3HwBtK8P2s+FuHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lct0cAQL8VBQXzXcL7Y2svI1Qppz2REPkgzl0mRX8HhSDKffTOVOyHOn0ak4kDc/o
	 3ACdVxCteY4tjUy+j3Zcn063jqMHGHOAbQ7RBsoJs2RrPGyIjUVkwPXPEzEiIp1tpx
	 qsPgw+UuHLmwbUFYUb990W36XpblSs9squiT8QTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGLJcB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Jul 2020 05:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgGLJcA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Jul 2020 05:32:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F7720720;
        Sun, 12 Jul 2020 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594546320;
        bh=QbBUjOO2ONnvgGnMB4P8D8RHlpRM3HwBtK8P2s+FuHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIOaCGD1+bjKJDJVKTV/O8HAFx/9ay39kyDx/3wyN+HoGE6tTP/yDj48Mz9D1nOrY
         NcF/EMHdvhav34JEa8FoC9yPWjPHQsDxtCoSjNQlNiqv7SRq9ZqLOhXXE9qhdYIrbY
         PvQ8mAXR4UcmxQWkXeaZKzzcDZQuy0ybtVVu0ClU=
Date:   Sun, 12 Jul 2020 11:31:55 +0200
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
Message-ID: <20200712093155.GA179963@kroah.com>
References: <20200707165958.16522-1-u.kleine-koenig@pengutronix.de>
 <20200707165958.16522-4-u.kleine-koenig@pengutronix.de>
 <20200712082453.GI8295@amd>
 <20200712084352.GA175558@kroah.com>
 <20200712085059.GA13495@amd>
 <20200712090217.GA177304@kroah.com>
 <20200712090731.GB13495@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712090731.GB13495@amd>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jul 12, 2020 at 11:07:31AM +0200, Pavel Machek wrote:
> On Sun 2020-07-12 11:02:17, Greg Kroah-Hartman wrote:
> > On Sun, Jul 12, 2020 at 10:50:59AM +0200, Pavel Machek wrote:
> > > On Sun 2020-07-12 10:43:52, Greg Kroah-Hartman wrote:
> > > > On Sun, Jul 12, 2020 at 10:24:53AM +0200, Pavel Machek wrote:
> > > > > > +++ b/drivers/leds/trigger/ledtrig-tty.c
> > > > > > @@ -0,0 +1,192 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > 
> > > > > 2.0+ is preffered.
> > > > 
> > > > No it is not, that's up to the developer.
> > > 
> > > For code I maintain, yes it is.
> > 
> > That's up to the developer of the code, not the maintainer, as the
> > maintainer is not the copyright holder of it.  For new files, it is up
> > to the author of that code.  No maintainer should impose a license rule
> > like this on their subsystem, that's just not ok at all.  The only
> > "rule" is that it is compatible with GPLv2, nothing else.
> 
> No, see for example device tree rules.

Note, I don't agree with that rule, and if you have noticed, it's not
really enforced.

> Plus, IIRC it was you who asked the developer to "doublecheck with
> their legal" when you seen GPL-2.0+.  You can't really prevent me from
> doing the same.

Asking to verify that a specific license is what they really want it to
be and they know the ramifications of it is NOT the same as saying "For
code in the subsystem I maintain it has to be GPLv2+".

thanks,

greg k-h
