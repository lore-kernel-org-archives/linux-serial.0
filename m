Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2923C001E0
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jul 2023 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjGaPut (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjGaPup (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jul 2023 11:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287C10D;
        Mon, 31 Jul 2023 08:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C52DA60F8F;
        Mon, 31 Jul 2023 15:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC684C433C8;
        Mon, 31 Jul 2023 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690818643;
        bh=aQ84qJHrAZ40UiW1q1IWOTdlB3S2mI1+Mg4IcIqIPn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIjITbopI018cFasOjcLib5EFNMvVylRFULj4q1yUsec4DfYN+WTQbThB1z5kCPpR
         lgrNKgcEBNhhbq6w4r0E1ZdnHKuTtIeQUD5W/Csj7WyOIX+us0g0PQsk0XnFHVzd/N
         5vvZX+Rs63E3+btJtbe4FGT+na9OueanAifZDyuc=
Date:   Mon, 31 Jul 2023 17:50:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v9 02/10] serial: sc16is7xx: mark IOCONTROL register as
 volatile
Message-ID: <2023073108-footboard-chooser-d20e@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-3-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725142343.1724130-3-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 25, 2023 at 10:23:34AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Bit SRESET (3) is cleared when a reset operation is completed. Having
> the IOCONTROL register as non-volatile will always read SRESET as 1,
> which is incorrect.
> 
> Also, if IOCONTROL register is not a volatile register, the upcoming
> patch "serial: sc16is7xx: fix regression with GPIO configuration"
> doesn't work when setting some shared GPIO lines as modem control
> lines.
> 
> Therefore mark IOCONTROL register as a volatile register.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x

Why 6.1.y?  What commit does this fix?

> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 8ae2afc76a9b..306ae512b38a 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -488,6 +488,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
>  	case SC16IS7XX_TXLVL_REG:
>  	case SC16IS7XX_RXLVL_REG:
>  	case SC16IS7XX_IOSTATE_REG:
> +	case SC16IS7XX_IOCONTROL_REG:
>  		return true;
>  	default:
>  		break;

Is this the same as this change:
	https://lore.kernel.org/all/20230724034727.17335-1-hui.wang@canonical.com/

confused,

greg k-h
