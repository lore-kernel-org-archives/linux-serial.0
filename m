Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4722C83F01
	for <linux-serial@archiver.kernel.org>; Sun, 27 Aug 2023 08:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjH0IIx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Aug 2023 04:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjH0IIb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Aug 2023 04:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC2DC;
        Sun, 27 Aug 2023 01:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD22B60C48;
        Sun, 27 Aug 2023 08:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB4C433C8;
        Sun, 27 Aug 2023 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693123707;
        bh=MHJjt4eg563LiNA4ksLlQeSWc1mSO+P5YUvp3Qw59eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCLZGT5atK53aCSn14SJGisOnhcx97NH6PVBwJ65LgfZC2QXmpGQJZndYTrpVfmnG
         j2gz5jtZxrgegiW2ANHkQfdSyRFZMLyNbPgbAw0MM/h8zvGj/yjEZy/+0bs3W8EwQH
         5+6UMdmKxxS7YX0bvY5+ofzGExSHcLA3YW6FJ1+M=
Date:   Sun, 27 Aug 2023 10:08:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Message-ID: <2023082710-synergy-spectrum-57aa@gregkh>
References: <20230827080113.2790-1-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827080113.2790-1-tanure@linux.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Aug 27, 2023 at 09:01:13AM +0100, Lucas Tanure wrote:
> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.
> 
> ---
>  drivers/tty/serial/meson_uart.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index c4f61d82fb727..790d910dafa5d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>  
>  OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>  		    meson_serial_early_console_setup);
> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> -		    meson_serial_early_console_setup);
>  
>  #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>  #else
> -- 
> 2.42.0
> 

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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
