Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5FCC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 12 Oct 2022 06:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJLGtl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Oct 2022 02:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJLGtk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Oct 2022 02:49:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4B7C27;
        Tue, 11 Oct 2022 23:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92829B8197E;
        Wed, 12 Oct 2022 06:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E813FC433D6;
        Wed, 12 Oct 2022 06:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665557375;
        bh=akU7D6EcK/LvpJ9YHAVo+RDeORIVNOj5M3jR41b1ypA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzzwJ3T3QPyUdhDhiSaAdji5opHMUcCjVCP6kgGVA+fHc6Bs65LjNz1ANzEZZ3Nsa
         C6xKvxG1CnSqI+hhPGioomAGxEpbqfIGtuwbyv+f6KiTNwSdI9wCnH3IHnod7slezs
         jw1FwmUhvC7oqpqGrFjfOvpJFg1/vJwqmSfbDshY=
Date:   Wed, 12 Oct 2022 08:50:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: n_gsm: make n_gsm line number configurable
Message-ID: <Y0Zjqxl/MAivtf02@kroah.com>
References: <20221012061715.4823-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012061715.4823-1-daniel.starke@siemens.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 12, 2022 at 08:17:15AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Currently, the n_gsm line number and its derived virtual ttys are assigned
> in the order of allocations with no means to change this.

Which is fine, why do you need this to be changed?  What relies on
specific line numbers in userspace that can not handle things correctly
with the normal userspace tools we have for this type of thing?

> Introduce additional ioctl parameters numValid and num to configure the
> line number to allow predictable virtual tty allocation and numbering.
> Especially when using multiple n_gsm instances at the same time.

Ick, please no.  That should never be needed, the kernel number and name
can be anything random (and people have suggested that we do make them
random at times).  Don't hard-code numbers in your userspace tools, that
is just wrong.

> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -19,7 +19,9 @@ struct gsm_config
>  	unsigned int mtu;
>  	unsigned int k;
>  	unsigned int i;
> -	unsigned int unused[8];		/* Padding for expansion without
> +	unsigned short numValid;
> +	unsigned short num;

This would never work anyway (hint "short" is not a valid uapi data
type...)

thanks,

greg k-h
