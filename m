Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F2C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 09:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AD861C14
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 09:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKOJhg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237137AbhKOJhW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 04:37:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B290D61A89;
        Mon, 15 Nov 2021 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636968852;
        bh=8sILmX26vLwhR5P/0vSCQzaOaXD0EJH8phQFBpukM+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfyI9m+pLFwNNhniWwezUPuY7MgHXDweijzQ3j+Wo/H2vmbMUjqL4rxUt5yrie04l
         xXQdghzhfYL5BZxu8ngPOFHgDcjHwdxeQ8R3uWKregZPkZtfC3RMhYvkrjTDge6UIS
         H/LwPGniscce77MuaQdYmIlZyLOSsBSAsNbf1mAA=
Date:   Mon, 15 Nov 2021 10:34:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilia Sergachev <silia@ethz.ch>
Cc:     linux-serial@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: liteuart: fix missing drvdata
Message-ID: <YZIpkiYHm3GR34zo@kroah.com>
References: <20211115031808.7ab632ef@dtkw>
 <YZIF48DPkfgBf5H9@kroah.com>
 <20211115102148.6c30dbf6@dtkw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115102148.6c30dbf6@dtkw>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Nov 15, 2021 at 10:21:48AM +0100, Ilia Sergachev wrote:
> I'd say 1da81e5562fac8286567422cc56a7fbd0dc646d4 - where 
> liteuart_probe() and liteuart_remove() were initially implemented.

Can you resend this with that information in the changelog as a "Fixes:"
tag please?

thanks,

greg k-h
