Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F68C05027
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 20:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBAUFO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBAUFO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 15:05:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D71611D0
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 12:05:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0540B822A4
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 20:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D236C433EF;
        Wed,  1 Feb 2023 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675281910;
        bh=rmPoFPon1DaemO65oh00WGh8tw8UK0ApbZvGK/v+wJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wyRlvvRrwA5mKZiAK0NQOFAMvGpIr3PXJY0/MJcpO5Rbgmq+imjVp8xJKDhBr8JWv
         Y2tOsLIKmmBuewP60qUTBa50H3a6kHm99rlyoURiTy6NBZOptQkvw6Q9D0vFVRK4yi
         uXpv6ZpUycUqTeqURkgIjnJkt2V4LMPkFMoqDhCA=
Date:   Wed, 1 Feb 2023 21:05:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/6] hvcs: Remove sysfs file prior to vio unregister
Message-ID: <Y9rF81tIiFioCvpE@kroah.com>
References: <20230201195743.303163-1-brking@linux.vnet.ibm.com>
 <20230201195743.303163-3-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201195743.303163-3-brking@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 01, 2023 at 01:57:39PM -0600, Brian King wrote:
> This moves the removal of the rescan sysfs attribute to occur
> before the call to unregister the vio to ensure the removal
> does not fail due to the vio driver already being freed.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/tty/hvc/hvcs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index faf5ccfc561e..9131dcb2e8d8 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -1519,6 +1519,8 @@ static int __init hvcs_module_init(void)
>  
>  static void __exit hvcs_module_exit(void)
>  {
> +	driver_remove_file(&hvcs_vio_driver.driver, &driver_attr_rescan);

Again, set the default group for the driver and then you don't have to
do any of this at all please.

thanks,

greg k-h
