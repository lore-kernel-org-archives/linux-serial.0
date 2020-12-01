Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B4BC64E7A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 18:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A371920870
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 18:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zn7XHnuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgLASIs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:08:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbgLASIr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 13:08:47 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFD0206D5;
        Tue,  1 Dec 2020 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606846086;
        bh=WtXcDUsmsSYRP67EJ5y5Y8owlNXI7rcGZK1pMfr+T6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zn7XHnuHvG69LInOIfeNZtKFY/XTVa/ejpj6C6GgR1M8IvYLQyyXKE0kYh0NcrdeP
         GlyCOQt1iGWT+Efge+4sxEKhxxfUBlb1aywgwCGcrGzwnDYuKPZyAtHhiNmBqrryE+
         diwLpnegTl3CQJRIMSEtym3XKnwh361gAfzb58SQ=
Date:   Tue, 1 Dec 2020 19:09:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Clement Smith <rclemsmith@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: jsm : jsm_tty.c : fixed file by adding
 spacing and removing assignment in if statement
Message-ID: <X8aGzm00l8LM4XPp@kroah.com>
References: <20201201105602.465899-1-rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201105602.465899-1-rclemsmith@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 04:26:02PM +0530, Clement Smith wrote:
> Fixed a coding style issue
> 
> Signed-off-by: Clement Smith <rclemsmith@gmail.com>
> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
