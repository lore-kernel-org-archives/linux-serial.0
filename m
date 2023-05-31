Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDAC77B7A
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 08:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjEaIGQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjEaIF6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 04:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB99125;
        Wed, 31 May 2023 01:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C374637D8;
        Wed, 31 May 2023 08:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF41BC4339C;
        Wed, 31 May 2023 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685520356;
        bh=K+KjKWAoGR9PcfqQVAwZ38Xz3lxK1J+DQ3Dth4s0hX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFLvv2D84CoINR4EOCzhFJsZUGK5vjc5+G4eied+ZYh/0xf6etM5Tg5ldSehmsDg3
         CqdNYTjtN8X5ifZC4J+5jKfUoiop9ITh0l/a9ri9HZncPyoBK8DGwJ3Eu+2iERuD99
         ew63Yzt5P3d+c0GV4bsG7dtlFR0LwHSNLcggY6IQ=
Date:   Wed, 31 May 2023 09:05:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org, rdunlap@infradead.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com
Subject: Re: [RESEND RFC PATCH v3 -next] tty: serial: add panic serial helper
Message-ID: <2023053113-surviving-ride-2dd6@gregkh>
References: <20230531071802.414383-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531071802.414383-1-xiehongyu1@kylinos.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 31, 2023 at 03:18:02PM +0800, Hongyu Xie wrote:
> It was inspired by kgdboc.
> 
> This is a debug module that allows you to get all kernel logs
> after panic.
> 
> Normally you need to attach a USB-to-UART tool or enable kdump
> before panic happens to get log from kernel after panic. If you
> didn't do that and kdump is not working, you can't get any log to
> know what happened before panic. If you have a USB-to-UART tool
> and the uart port on your computer is working. This module helps
> you to get all kernel log after panic() is called.
> 
> To use this, see Documentation/dev-tools/panic_serial_helper.rst.
> 
> Tested on arm64 device.
> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
> 
> v3:
>  1. modify the document about this module.
>  2. provide case-ignored filter matching.

Why is this a RESEND?

It's a RFC, I can't apply it, as obviously you do not feel like it is
completed.  What needs to be done to make you feel comfortable with it?

thanks,

greg k-h
