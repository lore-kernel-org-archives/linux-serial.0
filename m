Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C89EC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 10:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiAEKhK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 05:37:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53090 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiAEKhK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 05:37:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71DDBB81A12
        for <linux-serial@vger.kernel.org>; Wed,  5 Jan 2022 10:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADA0C36AEB;
        Wed,  5 Jan 2022 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641379028;
        bh=sxhA9PfDIduGqU+pImlGNOaQTO5xzawZrDOjMxp2OS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2qkqQgap9NfCcD0qhjmDnfuFrFn6I1h/n7V//1AvWbCGo0djJfyMNpF/um0VvXSM
         LMq+xuhdOW07Rq8x3oc1xSP7/kfrB9Eg/vOoNLrIyEZZGR/RJqc0sG50160ggUSw0a
         1ktpUJW14alNbg/GBkfa2i26/9Cwlo99x4YKG0Fw=
Date:   Wed, 5 Jan 2022 11:37:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
Message-ID: <YdV00WYGGd49WYt9@kroah.com>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
 <YdQxmQ+OMCrabg2u@kroah.com>
 <20220104224900.u3omfbilejx2jawr@pengutronix.de>
 <4c48200b-cc2e-0766-a002-831a789d4879@camlingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c48200b-cc2e-0766-a002-831a789d4879@camlingroup.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 05, 2022 at 08:59:09AM +0100, Tomasz Moń wrote:
> On 04.01.2022 23:49, Uwe Kleine-König wrote:
> > On Tue, Jan 04, 2022 at 12:38:01PM +0100, Greg Kroah-Hartman wrote:
> >> On Tue, Jan 04, 2022 at 12:13:06PM +0100, Tomasz Moń wrote:
> >>> On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
> >>>> Why can't you do this dynamically based on the baud rate so as to always
> >>>> work properly for all speeds without increased delays for slower ones?
> >>>
> >>> Could you please advise on which baud rates to consider as slow? Does it
> >>> sound good to have the old trigger level for rates up to and including
> >>> 115200 and the new one for faster ones?
> >>
> >> You tell me, you are the one seeing this issue and are seeing delays on
> >> slower values with your change.  Do some testing to see where the curve
> >> is.
> 
> While the increased latency due to this change is undeniable, it is
> important to note that latency is not everything. There are applications
> where the latency is crucial, however using Linux for such applications
> is questionable. Linux is not a Real Time Operating System after all.

Yes, Linux can be used in real time situtations just fine, look at the
RT patchset for proof of that.

So let's not make things any worse for no good reason if at all
possible.

> Latency is simple to measure and argue based on the reception of single
> character. That is only a corner case, not fully describing real world.
> In the real world, it is important to consider the overall performance
> improvement. It is hard to determine how much does the performance of
> the system improve thanks to less time spent in interrupt handling.

If this can't be measured at all, why make this change in the first
place?

> If changing the default RXTL value does not sound right, then maybe RXTL
> could be configured via a device tree property? That way it would be up
> to the user to tune it for the application.

Device tree is not there to tune for applications :)

thanks,

greg k-h
