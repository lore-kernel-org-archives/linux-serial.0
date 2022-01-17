Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0B4C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Jan 2022 13:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiAQNDY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Jan 2022 08:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiAQNDX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Jan 2022 08:03:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E455C061574
        for <linux-serial@vger.kernel.org>; Mon, 17 Jan 2022 05:03:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D7DF611E7
        for <linux-serial@vger.kernel.org>; Mon, 17 Jan 2022 13:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC09FC36AEC;
        Mon, 17 Jan 2022 13:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642424601;
        bh=b87IL0RWFA4DIWS0A6PpOtt1UraoyRpdHI+H4i99+po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1HHUEzHW2Ec3AQP9/uINSLYO2XjVTMGe5dtH96BoZ3G52Bwa5yrQ83M+g1E5CB84
         E6RLr8z/wXoek8Zqmn0tceq3Tsuq8z1G33/VKoYMvP+OeAo4oxRNGTJPwhqpHyRmmd
         mLQuGHqywM6u3ExrBgZ+ryG5G1zG1v+W55x9KD/M=
Date:   Mon, 17 Jan 2022 14:03:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        linux-serial@vger.kernel.org,
        Rostislav =?iso-8859-1?Q?Lisov=FD?= <lisovy@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: TTY layer discussion about generic FIFO depth and Rx iddle
 timeout control
Message-ID: <YeVpFozoVQo1vbKS@kroah.com>
References: <202201170006.31440.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201170006.31440.pisa@cmp.felk.cvut.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 17, 2022 at 12:06:31AM +0100, Pavel Pisa wrote:
> Dear Wander and Greg,
> 
> [resend on base of email-bot of Greg Kroah-Hartman's inbox]
> 
> I have noticed that you have sent enhancements
> to the TTY layer.
> 
> I have worked on architecture of automotive LIN-bus
> support for Linux UARTs. The SocketCAN API was idea
> of Oliver Hartkopp and we have designed internals
> to implement actual protocol. Rostislav Lisovy
> was main author at our university in 2011. The code
> has been used and is used by more people and I have
> helped its integration to local Volkswagen subsidiary
> projects. I have helped to maintain it for years
> even that I have actually no use for it or contract.
> But is seems usable...
> 
> I am not sure if it can reach quality standards
> for mainline but I have tried to consolidate
> many forks and copies from our original GIT
> server which can be found on GitHub and united
> project under
> 
>   https://github.com/lin-bus
> 
> Kernel part - slLIN TTY discipline - can be found there
> 
>   https://github.com/lin-bus/linux-lin/tree/master/sllin

So it's just a 2000 line kernel module?  That should be easy to turn
into a patch and submit for review, right?

Odds are it can be made much smaller based on an initial glance at it.
Review comments can help show what to do.

> Documentation
> 
>   https://github.com/lin-bus/linux-lin/wiki/
> 
> The main obstacle to have version which can be used
> with different UARTs seamlessly is missing internal low
> level kernel API which would allow to control Rx trig
> level.
> 
> I have not checked your changes yet but I would be happy
> if some API is available for this control. Please see
> issue 
> 
>   https://github.com/lin-bus/linux-lin/issues/13
> 
> Please suggest where to discuss the proposal/solutions
> or if you plan to implement something like that.

Discuss it here by submitting patches please.  Links to random github
repos do not do much as we can do nothing with them, sorry.

thanks,

greg k-h
