Return-Path: <SRS0=XuIp=X5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0324CC47404
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 12:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBE1222C0
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570193690;
	bh=MM7IOqWgkdbOitP7bMDfuncCK3Gie1OWlQpqXI5OzJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kd5eFg7kyLYQALxrfBKLPbhtS3q5UdiJiM3nVqjxGI919KFA2nWMaQ1KvuQj3tbcD
	 lpHlrX3/YcXkO/1x1vQSG6u+RzC5u0GZJQAJwUZyi+IBXV00bT6kVD4fTwxB7HmcYw
	 QbDy4lzgU+bDqMFBJqy0QsO0HIRpTWuiWzxhXM3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfJDMyu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbfJDMyu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Oct 2019 08:54:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082E62070B;
        Fri,  4 Oct 2019 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570193689;
        bh=MM7IOqWgkdbOitP7bMDfuncCK3Gie1OWlQpqXI5OzJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYJmfHCf10oqPx/Yw73jVx8CFUmuFBqH8G3U6b9tqOWUlohBXRtLSzuawBbVXcnUR
         yHg1pzIclSZ4OXMIzDAywNzH3p/kBYl+bOcxF0ImRpUhiq7McbxSYEvtnpelwuzqtW
         5ZtdhuFw1C/BtBtGp7MtJhDA0tdT8EOZzcmfTYmA=
Date:   Fri, 4 Oct 2019 14:54:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: move Non-standard serial drivers menu to the
 Serial drivers menu
Message-ID: <20191004125446.GB583048@kroah.com>
References: <8e583967-4453-368b-6be5-a24df9b2b5dc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <8e583967-4453-368b-6be5-a24df9b2b5dc@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Message-ID: <20191004125446.v53imeJSW7ff-BdXL5PUcCIZJFbr2YNWFaFlgKqyu20@z>

On Wed, Sep 25, 2019 at 06:16:28PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Since Non-standard serial port drivers are also Serial drivers,
> move the "Non-standard serial port support" menu to be under/in
> the "Serial drivers" menu. With this move, the "Serial drivers"
> menu contains (a) 8250/16550 support, (b) non-8250 support, and
> (c) non-standard serial port support.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/tty/Kconfig        |  119 -----------------------------------
>  drivers/tty/serial/Kconfig |  119 +++++++++++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+), 119 deletions(-)
> 
> --- lnx-53.orig/drivers/tty/Kconfig
> +++ lnx-53/drivers/tty/Kconfig
> @@ -151,125 +151,6 @@ config LEGACY_PTY_COUNT
>  	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
>  	  architectures and 24 bytes on 64-bit architectures.
>  
> -config SERIAL_NONSTANDARD
> -	bool "Non-standard serial port support"
> -	depends on HAS_IOMEM
> -	---help---
> -	  Say Y here if you have any non-standard serial boards -- boards
> -	  which aren't supported using the standard "dumb" serial driver.
> -	  This includes intelligent serial boards such as Cyclades,
> -	  Digiboards, etc. These are usually used for systems that need many
> -	  serial ports because they serve many terminals or dial-in
> -	  connections.
> -
> -	  Note that the answer to this question won't directly affect the
> -	  kernel: saying N will just cause the configurator to skip all
> -	  the questions about non-standard serial boards.
> -
> -	  Most people can say N here.
> -
> -config ROCKETPORT
> -	tristate "Comtrol RocketPort support"
> -	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)

I would agree with the move, but the files are not in
drivers/tty/serial/ for the drivers you are asking to configure in that
directory.

So unless we want to move these drivers (and it's not really worth it,
unless we want to create drivers/tty/serial/obsolete/ or something like
that), I would just leave this alone.

thanks,

greg k-h
