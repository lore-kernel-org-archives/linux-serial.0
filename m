Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E97C636CC
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 05:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjBCFLJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Feb 2023 00:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjBCFLI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 00:11:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA823C3A
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 21:11:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5245EB82966
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 05:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9475BC433EF;
        Fri,  3 Feb 2023 05:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675401065;
        bh=dUOhQ6hNe3dggdDGLK7/bWxkEVbMRTxh5/gan/XL6mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVFKaflMctQb/ML/0ajJVSDSBT7PpApdYW8gG1YINZAkcXebWWWpu23h5dR4qfko3
         gB7sFiekxNcrFvo8h0s5vYAtxsApkK28xENkaK87MRHMexYfS2DPCspVRU1HN0PmN1
         NeVPWxCteb6VzBLc8Ad/ptWTAAXLyNJzuhCGUeTI=
Date:   Fri, 3 Feb 2023 06:11:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hvcs: Use driver groups to manage driver
 attributes
Message-ID: <Y9yXZpwa7TDmRd+H@kroah.com>
References: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
 <20230202222804.383229-4-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202222804.383229-4-brking@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 02, 2023 at 04:28:01PM -0600, Brian King wrote:
> Rather than manually creating attributes for the hvcs driver,
> let the driver core do this for us. This also fixes some hotplug
> remove issues and ensures that cleanup of these attributes
> is done in the right order.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/tty/hvc/hvcs.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index 7f79444b4d89..5de7ad555540 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -473,6 +473,20 @@ static ssize_t rescan_store(struct device_driver *ddp, const char * buf,
>  
>  static DRIVER_ATTR_RW(rescan);
>  
> +static struct attribute *hvcs_attrs[] = {
> +	&driver_attr_rescan.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group hvcs_attr_group = {
> +	.attrs = hvcs_attrs,
> +};
> +
> +const static struct attribute_group *hvcs_attr_groups[] = {
> +	&hvcs_attr_group,
> +	NULL,
> +};

Again, ATTRIBUTE_GROUPS()?

thanks,

greg k-h
