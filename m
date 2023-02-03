Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C031CC61DA4
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 05:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBCFKS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Feb 2023 00:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBCFKS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 00:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199333C3A
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 21:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A499A61D68
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 05:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B83CC433EF;
        Fri,  3 Feb 2023 05:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675401016;
        bh=eNaATQXgc7RaCupB3Sjv+2VvnJq3Q8Mm/89hEvFZUUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrEhHWlwXC6AGDNFBU4K1ubmFkysWR19vUE/RGoiN9luU3NLi/wqBGGEpRTf+B1RM
         75nJYODy24ADKXfCJg46QhYWPB9srB1w5GhzJs5SN0HHW0uHCVGyLfOalTEAIehZ4m
         IFS7LLuNv3NWYClWvrHaPeCYFWoOI8iMoJ3KATGw=
Date:   Fri, 3 Feb 2023 06:10:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/6] hvcs: Use dev_groups to manage hvcs device
 attributes
Message-ID: <Y9yXNP+PzAdYPKb0@kroah.com>
References: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
 <20230202222804.383229-3-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202222804.383229-3-brking@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 02, 2023 at 04:28:00PM -0600, Brian King wrote:
> Use the dev_groups functionality to manage the attribute groups
> for hvcs devices. This simplifies the code and also eliminates
> errors coming from kernfs when attempting to remove a console
> device that is in use.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/tty/hvc/hvcs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index faf5ccfc561e..7f79444b4d89 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -432,7 +432,7 @@ static ssize_t hvcs_index_show(struct device *dev, struct device_attribute *attr
>  
>  static DEVICE_ATTR(index, S_IRUGO, hvcs_index_show, NULL);
>  
> -static struct attribute *hvcs_attrs[] = {
> +static struct attribute *hvcs_dev_attrs[] = {
>  	&dev_attr_partner_vtys.attr,
>  	&dev_attr_partner_clcs.attr,
>  	&dev_attr_current_vty.attr,
> @@ -441,8 +441,13 @@ static struct attribute *hvcs_attrs[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group hvcs_attr_group = {
> -	.attrs = hvcs_attrs,
> +static struct attribute_group hvcs_attr_dev_group = {
> +	.attrs = hvcs_dev_attrs,
> +};
> +
> +const static struct attribute_group *hvcs_attr_dev_groups[] = {
> +	&hvcs_attr_dev_group,
> +	NULL,
>  };

Why not just use the ATTRIBUTE_GROUPS() macro here?

thanks,

greg k-h
