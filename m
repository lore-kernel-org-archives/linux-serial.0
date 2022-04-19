Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E3C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 10:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiDSKJH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiDSKJG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 06:09:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B35024581;
        Tue, 19 Apr 2022 03:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28262B81100;
        Tue, 19 Apr 2022 10:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AABC385A5;
        Tue, 19 Apr 2022 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650362781;
        bh=Xjd8xF6lDlknu1VxRG+stmss65nhtH4KHhx1LEffttI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAZOVz8jTW3kGOUMy8Riy51iT0npPo1ZOrX0UteWXpiGJrUczBxY7vQTQH6n0Bhr7
         7hlzSedRjb7Qbl6HU5QNiFJ2rBUZQNkE/n6bfoVKx9cKe7GBsISscl3eJT3xcpssKc
         VpW5G6E6ob/4ugmQKxXXeBiFvtFPDE72zsHaIYLM=
Date:   Tue, 19 Apr 2022 12:06:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/20] tty: n_gsm: clean up dead code in gsm_queue()
Message-ID: <Yl6Jmk/j7go9s+0i@kroah.com>
References: <YlkRO6fAPCuWyT1Y@kroah.com>
 <20220419081713.5813-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419081713.5813-1-daniel.starke@siemens.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 19, 2022 at 01:17:13AM -0700, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Remove commented out code as it is never used and if anyone accidentally
> turned it on, it would be broken.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 07d03447cdfd..1b4077006744 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1894,10 +1894,6 @@ static void gsm_queue(struct gsm_mux *gsm)
>  	case UI|PF:
>  	case UIH:
>  	case UIH|PF:
> -#if 0
> -		if (cr)
> -			goto invalid;
> -#endif
>  		if (dlci == NULL || dlci->state != DLCI_OPEN) {
>  			gsm_command(gsm, address, DM|PF);
>  			return;
> -- 
> 2.25.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
