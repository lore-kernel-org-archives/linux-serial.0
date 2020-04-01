Return-Path: <SRS0=XHY+=5R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7930C43331
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 08:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA3E2078B
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585731355;
	bh=2lkU7aDUNcZPy67HrpmmAS88AU2gOLJri4GVeA1yePc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dy2EN59sKic76lIaNlavuyRi6F3MthIszKYba82KCAX45tjN8jgkXyliIu8ppd8cy
	 8Ga0aeEs3reVP+O4gmAbEFQZRxi5BEY0zDw70wDhGOeKRvNM5zpLHvRO5ymRvUmdcW
	 RQrmrE76z8xXEtKC/2ZbN/1ULRywz85pAYpBppmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgDAIzv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgDAIzv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Apr 2020 04:55:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EEC20784;
        Wed,  1 Apr 2020 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585731350;
        bh=2lkU7aDUNcZPy67HrpmmAS88AU2gOLJri4GVeA1yePc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bth9ooTGpGk47WkFhb8ZQYTHCLL4rF2ytX6k7MDqKodh7FaLEhpwBDK9nsj5akxoq
         sJQKhJJYAEUN4P5GvCTRkwN8NCD/SyPzdzhJKHcZCAJmsT0wlGanc15oucvzFFbrqk
         z70oKRvJNBQHcZbfxpespBB/JAkbiJKjw3rf1bYg=
Date:   Wed, 1 Apr 2020 10:55:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     hyunki00.koo@gmail.com, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: samsung_tty: 32-bit access for TX/RX hold registers
Message-ID: <20200401085548.GC2026666@kroah.com>
References: <CGME20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2@epcas2p2.samsung.com>
 <20200401082721.19431-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401082721.19431-1-hyunki00.koo@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 01, 2020 at 05:27:20PM +0900, Hyunki Koo wrote:
> -	if (np)
> +	if (np) {
>  		of_property_read_u32(np,
>  			"samsung,uart-fifosize", &ourport->port.fifosize);
>  
> +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> +			switch (prop) {
> +			case 1:
> +				ourport->port.iotype = UPIO_MEM;
> +				break;
> +			case 4:
> +				ourport->port.iotype = UPIO_MEM32;
> +				break;
> +			default:
> +				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> +						prop);
> +				ret = -EINVAL;
> +				break;
> +			}
> +		}
> +	}
> +

Does this mean that reg-io-width is now a required property for all
samsung uarts?  Does this break older dts files?  Or should you
fall-back to the previous operation if the attribute is not there?

And please fix your email client, the headers were all messed up,
causing my initial response to be only sent to you :(

thanks,

greg k-h

