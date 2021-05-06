Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CE4C433B4
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 17:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A0A61041
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 17:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhEFRkq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 13:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236203AbhEFRkq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 13:40:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 599BC6121F;
        Thu,  6 May 2021 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620322788;
        bh=QycqlI+d8RRkuDdjJ3vGaLrHEpyC+iQma3qmO3F8d5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhk3LTffcKEiQC9NXxThC6FaxedGy1+QSdFy+I2xIiOzz9yBmGJFzulELakAk3Cvg
         FBUs9SUW0VUlP35BJEpPPGVlxh2LlBpPmFTbwknuOu6ggdQkQoCj2W9Gm0UtPkgCTu
         sBxatYI5cEUxavzOM+C/MbznR6Ggd4sZKnyeQX84=
Date:   Thu, 6 May 2021 19:39:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Bakula <wamreu@gmail.com>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TTY: serdev: Replace depricated macros
Message-ID: <YJQp4W2X/tuvLfVA@kroah.com>
References: <20210506183228.33981-1-wamreu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506183228.33981-1-wamreu@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 06, 2021 at 08:32:28PM +0200, Ivan Bakula wrote:
> Replace depricated macros ida_simple_get and ida_simple_remove with
> appropriate function calls to ida_alloc and ida_free.
> 
> Signed-off-by: Ivan Bakula <wamreu@gmail.com>
> ---
>  drivers/tty/serdev/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index aead0c0c9..5f873960b 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -75,7 +75,7 @@ static bool is_serdev_device(const struct device *dev)
>  static void serdev_ctrl_release(struct device *dev)
>  {
>  	struct serdev_controller *ctrl = to_serdev_controller(dev);
> -	ida_simple_remove(&ctrl_ida, ctrl->nr);
> +	ida_free(&ctrl_ida, ctrl->nr);
>  	kfree(ctrl);
>  }
>  
> @@ -488,7 +488,7 @@ struct serdev_controller *serdev_controller_alloc(struct device *parent,
>  	if (!ctrl)
>  		return NULL;
>  
> -	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		dev_err(parent,
>  			"unable to allocate serdev controller identifier.\n");
> -- 
> 2.31.1
> 

If these really are "deprecated", why not just do a search/replace
across the whole tree and change them?  Or if not, what is wrong with
the existing ones?

Why shouldn't we be using the old calls?  What is wrong with them?

thanks,

greg k-h
