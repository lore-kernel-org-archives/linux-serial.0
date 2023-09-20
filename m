Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE54CE79CE
	for <linux-serial@archiver.kernel.org>; Wed, 20 Sep 2023 13:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjITNTC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjITNTB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 09:19:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00165F1;
        Wed, 20 Sep 2023 06:18:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9BBC433C8;
        Wed, 20 Sep 2023 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695215933;
        bh=nnli8MSSDfrHelQBb1r0L2vDbqp6oxZF8KrvopPllR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rT39YSNSJy9ytpnr+AgC5ujreaHYT2PClmB4Pgp4Sf0W5RLeVqpM7KXRJZgOeLhHd
         mn4nJmrl4//blN3GDaQaP7gXVo9vZlAPFU4bvbFXUHq8ZDuyqbCGHE1krFxZ/Zxauy
         0UEj3vJ+7CsEO/6WGGTzrr+NjsnSO69o+puz2yso=
Date:   Wed, 20 Sep 2023 15:18:51 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <JoseJavier.Rodriguez@duagon.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: Re: [PATCH v3 2/2] mcb: use short version for function pointer for
 mcb_free_bus
Message-ID: <2023092000-overprice-guileless-e1a3@gregkh>
References: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
 <20230906114901.63174-3-JoseJavier.Rodriguez@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230906114901.63174-3-JoseJavier.Rodriguez@duagon.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 06, 2023 at 11:49:28AM +0000, Rodríguez Barbarin, José Javier wrote:
> From: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> 
> Just a style change so that the device release callbacks are defined
> in the same way for devices in mcb_bus and mcb_device.
> 
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> Co-developed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.com>
> Signed-off-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.com>
> ---
>  drivers/mcb/mcb-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
> index 0cac5bead84f..5c6157b0db75 100644
> --- a/drivers/mcb/mcb-core.c
> +++ b/drivers/mcb/mcb-core.c
> @@ -288,7 +288,7 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
>  	bus->dev.parent = carrier;
>  	bus->dev.bus = &mcb_bus_type;
>  	bus->dev.type = &mcb_carrier_device_type;
> -	bus->dev.release = &mcb_free_bus;
> +	bus->dev.release = mcb_free_bus;

But you aren't fixing the root cause here of an incorrect pointer being
passed to this function, right?

Yes, removing the single variable is nicer, so the crash doesn't happen,
but you are still passing the wrong pointer around, so why not fix that?

thanks,

greg k-h
