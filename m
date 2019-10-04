Return-Path: <SRS0=XuIp=X5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE72AC4360C
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A7A21D81
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570195379;
	bh=GUO8YLDcJR4bDOt6M074BNIfH90tNNLww2gp3RMRKNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G/Bx7FwXfBWAozG0doi0tmxLXlv83tgEZWtAU8CouQ41q9W9eIIOFMLISCfOwuIqI
	 c5BNkJXQqYjklqdSZxO7o+7W1Lja9HavW4QIl6JJNypSohe3c9fpBkQtdSoAKDQOUP
	 ES86xhvIJcilcRdyDkC++OLlAyURbS7TH2gE6KX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbfJDNW7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387952AbfJDNW7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Oct 2019 09:22:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497CB207FF;
        Fri,  4 Oct 2019 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570195378;
        bh=GUO8YLDcJR4bDOt6M074BNIfH90tNNLww2gp3RMRKNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RW78D+m/Ei6YDlqAwjiRtymmGXRKkmpfzqzGcCVeUTDAVYppp8QbVFsngb1PNF5tq
         CKMWOelI4Vzvs4nq7gd03I9rUWzlBnl2rDkaehiYc8OZZbZje0jEvUZZciNeJoGSqV
         lyWT1xNNIxEX+0JLHySoFnB5eYomddxScRYts4H0=
Date:   Fri, 4 Oct 2019 15:22:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pascal Terjan <pterjan@google.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] Remove every trace of SERIAL_MAGIC
Message-ID: <20191004132256.GA715053@kroah.com>
References: <20191004124505.GA556034@kroah.com>
 <20191004132001.99027-1-pterjan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004132001.99027-1-pterjan@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 04, 2019 at 02:20:01PM +0100, Pascal Terjan wrote:
> The only code mentioning it doesn't build (and hasn't at least since git)
> and doesn't include the header defining it.
> 
> This means removing support for checking magic in amiserial.c
> (SERIAL_PARANOIA_CHECK option), which was checking a magic field which
> doesn't currently exist in the struct.
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
>  Documentation/process/magic-number.rst        |  1 -
>  .../it_IT/process/magic-number.rst            |  1 -
>  .../zh_CN/process/magic-number.rst            |  1 -
>  drivers/net/wan/z85230.h                      |  2 -
>  drivers/tty/amiserial.c                       | 81 +------------------
>  5 files changed, 1 insertion(+), 85 deletions(-)

What changed from the first version?

Always version your patches and properly put what changed below the ---
line.  Like the documentation says to do :)

v3 please?

thanks,

greg k-h
