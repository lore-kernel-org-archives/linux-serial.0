Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629FBC4361B
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 19:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E36C2388B
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 19:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393244AbgLJTDB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393240AbgLJTCt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 14:02:49 -0500
Date:   Thu, 10 Dec 2020 20:03:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607626928;
        bh=ZfdBQzaSM47I/XuHSY08+0FnE40SdZU+Gk3omAhDuhg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCQFCwqxddKs23p50yHX0I5d/oS9HKBTYXcMQkfgSjLsRUE/4gpdLHNg5HMXAJ8l5
         6mNhGt7PDZvlPCdBusW9x+6sEOZQ2xUdHV6dF5BBiAOBClStkJnfZzv+ElC2d/kdJa
         nTpddsypJaZqKWSSCmKZVtMajVrhgtsWHpJ0AzFQ=
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Serial: silabs si4455 serial driver
Message-ID: <X9Jw+srprdT8tquZ@kroah.com>
References: <20201210170443.GA17304@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210170443.GA17304@dincontrollerdev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 05:04:46PM +0000, József Horváth wrote:
> This is a serial port driver for
> Silicon Labs Si4455 Sub-GHz transciver.
> 
> Signed-off-by: József Horváth <info@ministro.hu>
> ---
>  .../bindings/serial/silabs,si4455.yaml        |   53 +
>  MAINTAINERS                                   |    7 +
>  drivers/tty/serial/Kconfig                    |    8 +
>  drivers/tty/serial/Makefile                   |    1 +
>  drivers/tty/serial/si4455.c                   | 1235 +++++++++++++++++
>  drivers/tty/serial/si4455_api.h               |   56 +

First thing, a single .c file should not need a .h file.

But then I looked at the .h file and see:

> --- /dev/null
> +++ b/drivers/tty/serial/si4455_api.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2020 József Horváth <info@ministro.hu>
> + *
> + */
> +#ifndef SI4455_API_H_
> +#define SI4455_API_H_
> +
> +struct si4455_iocbuff {
> +	uint32_t length;
> +	uint8_t	data[4096];

If you do have an ioctl, use proper data types.  These are not the
correct ones (hint, __u32 and __u8).

> +};
> +
> +#define BASE_TTYIOC_PRIVATE		0xA0
> +/* Set EZConfig.
> + * After this ioctl call, the driver restarts the si4455,
> + * then apply the new configuration and patch.
> + */
> +#define SI4455_IOC_SEZC		_IOW('T', \
> +				     BASE_TTYIOC_PRIVATE + 0x01, \
> +				     struct si4455_iocbuff)

Why does a serial driver have private ioctls?  Please no, don't do that.
Implement the basic serial driver first, and then we can talk about
"custom" configurations and the like, using the correct apis.

thanks,

greg k-h
