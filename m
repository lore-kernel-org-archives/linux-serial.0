Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE75C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 10:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbiDSKKB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346687AbiDSKKA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 06:10:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B19024581;
        Tue, 19 Apr 2022 03:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C87B81627;
        Tue, 19 Apr 2022 10:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4927AC385A5;
        Tue, 19 Apr 2022 10:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650362835;
        bh=/r4gORQWm8YoLyA3aywioxPUg0TMYbMkmXFkAGe5QpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSCcIgiDRSMAUFo471bG8mMbx/KcRcgrTW1UvecuPr1J8/0e/6PScjKSvgmVbN8xz
         HMlPLoSKAuYGWHs2Gn2MLwAmfvUu9nr6ZTyDLpdOvAmF/9q0y95Nd4Y9SEDFbiLFId
         uyP81EXNXBrbSaavck72JUgE6NcbfpBJxqNnLH7c=
Date:   Tue, 19 Apr 2022 12:07:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/20] tty: n_gsm: clean up dead code in gsm_queue()
Message-ID: <Yl6J0IJwbbv5SbVc@kroah.com>
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

As I have already taken the majority of this series, just send a new
series with the remaining changes, and properly document what is
different here from the original version, as the documentation asks you
to.

thanks,

greg k-h
