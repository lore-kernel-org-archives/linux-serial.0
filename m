Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBABC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 11 Mar 2022 14:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349943AbiCKOpr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Mar 2022 09:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349853AbiCKOpl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Mar 2022 09:45:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82CF1CF091;
        Fri, 11 Mar 2022 06:44:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7849E60B63;
        Fri, 11 Mar 2022 14:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D383EC340EE;
        Fri, 11 Mar 2022 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647009857;
        bh=52lx2+To0HO3wzqy/qJndQmJuAiCIe0dCfR4lN7Rj3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOJaTJy2DAV0Ylb+iZMir8TUJxH3XFUQUJ10rClnBAENfVDvM9MwEAkeyK3mNKv7v
         aPXZi94sP1VTBZFZ2ERSneex/auW4YJMrd6tmDYlZMnYJh8ueK7UP84bcbCleHpjGl
         PzM5uBahoIEE0X3p0XxkqVASpS75nqWHIG6dL+KhkDdR8Gi1uMEH3ksHIsHxefzR5u
         W0vvbzbzmQpU8W8uf7q9zHcbkDbGUGwG7ZfsxRAfVc6g5B4I4aqeHwyKrH9ginvG+Y
         j5ZlYwOibdATk4zbeoOqexB7mNLNZjwetvtRC+dJ3qJFGCIMLjfrR8Cjdy5PC+fmr9
         MVuo37BaH6Keg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nSgV2-0006Pe-BQ; Fri, 11 Mar 2022 15:44:13 +0100
Date:   Fri, 11 Mar 2022 15:44:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dawid Buchwald <buchwald.dawid@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: Add support for PL2303GS
Message-ID: <YitgPFuSYj9sTaui@hovoldconsulting.com>
References: <20220311135531.12832-1-buchwald.dawid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311135531.12832-1-buchwald.dawid@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 11, 2022 at 02:55:31PM +0100, Dawid Buchwald wrote:
> This is the issue I have with recently acquired PL2303 adapter:
> 
> [   70.502848] usb 1-2: new full-speed USB device number 5 using xhci_hcd
> [   70.652523] usb 1-2: New USB device found, idVendor=067b,
> idProduct=23f3, bcdDevice= 6.05
> [   70.652533] usb 1-2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [   70.652538] usb 1-2: Product: USB-Serial Controller
> [   70.652540] usb 1-2: Manufacturer: Prolific Technology Inc.
> [   70.652543] usb 1-2: SerialNumber: CJAKj19B616
> [   70.674558] usbcore: registered new interface driver usbserial_generic
> [   70.674578] usbserial: USB Serial support registered for generic
> [   70.677490] usbcore: registered new interface driver pl2303
> [   70.677498] usbserial: USB Serial support registered for pl2303
> [   70.677510] pl2303 1-2:1.0: pl2303 converter detected
> [   70.677513] pl2303 1-2:1.0: unknown device type, please report to
> linux-usb@vger.kernel.org

> Signed-off-by: Dawid Buchwald <buchwald.dawid@gmail.com>
> 
> ---
>  drivers/usb/serial/pl2303.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index a70fd86f735c..1072f8eb6ab9 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -435,6 +435,7 @@ static int pl2303_detect_type(struct usb_serial *serial)
>  		case 0x105:
>  		case 0x305:
>  		case 0x405:
> +		case 0x605:
>  			/*
>  			 * Assume it's an HXN-type if the device doesn't
>  			 * support the old read request value.

Thanks for the update. The corrupt whitespace issue appears to be fixed
now.

Someone else reported this on Sunday and I totally forgot that you had
reported the same issue a week earlier and was preparing a v2.

I'm really sorry about that. 

This has now been fixed with commit:

	5b6ab28d0678 ("USB: serial: pl2303: fix GS type detection")

which will show up in mainline soon and be backported to stable.

Johan
