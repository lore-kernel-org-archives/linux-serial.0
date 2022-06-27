Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC379CCA473
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 12:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiF0MIX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiF0MHp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 08:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAFACE14;
        Mon, 27 Jun 2022 05:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09BE614FA;
        Mon, 27 Jun 2022 12:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D259FC3411D;
        Mon, 27 Jun 2022 12:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656331590;
        bh=FRa7EhIZdH14xBmvGsuv9S2UuKN37r7iywmSP/vdMaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4hcTuyj1ifMWkRDNmE/plM51pKxWaVXjUEEKuoXONAGp5cMJJXK6/eRYcCAC36go
         18OZhmx6On3Hv5juJfqJUL7PdTEcmkOVr8p9JWIOpPm6GvFTByoaNROVE8+re8S05q
         jFbfEIzYfRWyi6N1L00mZxkhCFBCjZZOQ2mwD7Ss=
Date:   Mon, 27 Jun 2022 13:52:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: samsung_tty: support more than 4 uart ports
Message-ID: <YrmZ8ikVsnAGrBXF@kroah.com>
References: <CGME20220627071726epcas2p476cfa45f74a73bfd0fcfe03eacc2df60@epcas2p4.samsung.com>
 <20220627071512.18180-1-chanho61.park@samsung.com>
 <2efd725f-3d99-c1df-23ce-9ee60bbe4600@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2efd725f-3d99-c1df-23ce-9ee60bbe4600@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 27, 2022 at 12:33:51PM +0200, Krzysztof Kozlowski wrote:
> On 27/06/2022 09:15, Chanho Park wrote:
> > Regarding Exynos Auto v9 SoC, it supports uarts up to 12. However, the
> > maximum number of the ports has been derived from
> > CONFIG_SERIAL_SAMSUNG_UARTS and tightly coupled with the config for
> > previous Samsung SoCs such as s3c24xx and s3c64xx. To overcome this
> > limitation, this changes the usage of the definition to UART_NR which is
> > widely used from other serial drivers. This also defines the value to 12
> > only for ARM64 SoCs to not affect the change to previous arm32 SoCs.
> > Instead of enumerating all the ports as predefined arrays, this
> > introduces s3c24xx_serial_init_port_default that is initializing the
> > structure as default value. 
> > Regarding the ports which are greater than 4
> > will be initialized as default value and the fifo size will be retrieved
> > from the DT property.
> 
> You need to explain why you are doing this.
> 
> It's confusing to initialize some statically and some dynamically.

I agree, why not just make them all dynamic?

thanks,

greg k-h
