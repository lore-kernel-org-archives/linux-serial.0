Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403F6C05027
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 20:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBAUEm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBAUEk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 15:04:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0479611D0
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 12:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6969F617E2
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 20:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E13EC433EF;
        Wed,  1 Feb 2023 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675281878;
        bh=nizT89zhrZII1N6zYUh2O7TUZNc9wQfYHV7jlGUAi64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1Qq1qObrisOcQIoLXa4qWduLqh41+m2hPGjKYehCRFWuGWmHkreS83RqK7SG6KXw
         7DkBP/+a8uNW3l3vjqgnVkfNrtBK+DvckKZBt102AwW1oiR/dTFTv4CpTdr6M2WzSy
         Iu6UxHhREEiBkp74Od3RZr2HfjFd8FeZaifkHKBo=
Date:   Wed, 1 Feb 2023 21:04:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/6] hvcs: Remove sysfs group earlier
Message-ID: <Y9rF01SQ91VBjFa9@kroah.com>
References: <20230201195743.303163-1-brking@linux.vnet.ibm.com>
 <20230201195743.303163-4-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201195743.303163-4-brking@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 01, 2023 at 01:57:40PM -0600, Brian King wrote:
> Cleanup the sysfs group earlier in remove. This eliminates
> errors coming from kernfs when attempting to remove a console
> device that is in use.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/tty/hvc/hvcs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index 9131dcb2e8d8..9c5887d0c882 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -688,8 +688,6 @@ static void hvcs_destruct_port(struct tty_port *p)
>  	spin_unlock_irqrestore(&hvcsd->lock, flags);
>  	spin_unlock(&hvcs_structs_lock);
>  
> -	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
> -
>  	kfree(hvcsd);
>  }
>  
> @@ -814,6 +812,8 @@ static void hvcs_remove(struct vio_dev *dev)
>  	 */
>  	tty_port_put(&hvcsd->port);
>  
> +	sysfs_remove_group(&dev->dev.kobj, &hvcs_attr_group);
> +

Why is this needed at all?  The files should be auto-removed when the
device is removed, right?

And calling sysfs_*() functions from a driver is a huge hint that
something is wrong here.  Worst case, this should be calling
device_remove_group(), but really, the default groups pointer should be
set and then you don't have to add/remove anything, it will all happen
automatically for you by the driver core at the properly place and time.

Can you do that instead of this change?  That should fix it all up
properly.

thanks,

greg k-h
