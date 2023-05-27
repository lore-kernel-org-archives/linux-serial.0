Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D12C77B7C
	for <linux-serial@archiver.kernel.org>; Sat, 27 May 2023 06:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjE0GTp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 May 2023 02:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjE0GTo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 May 2023 02:19:44 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A394EC;
        Fri, 26 May 2023 23:19:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34R6JMs7084584;
        Sat, 27 May 2023 01:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685168362;
        bh=OfcnNqxm7dVewCiFRbleuAUQnrABJWTD05qLwJkdS2g=;
        h=Date:To:CC:References:From:Subject:In-Reply-To;
        b=PMwUwFfX5hE3COivb6iVLsjZ5LpFinkIIFUizm36JBVRdRh5LfWRWpv40e6EiDrPi
         Kxq4p2izccYg7h/B3wVAYJE8kfJj2ezCi3GWzizsLQJJuKxvy7sv5InwDRhdcjSkAD
         tPFhEgbiSWF5isfCITTuwOI6H/fnrXq55pEPXjWs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34R6JMMF018463
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 27 May 2023 01:19:22 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 27
 May 2023 01:19:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 27 May 2023 01:19:21 -0500
Received: from [10.249.138.166] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34R6JHGA077281;
        Sat, 27 May 2023 01:19:19 -0500
Message-ID: <0cb182f8-eb53-45d8-3c8b-fb7d16f88d46@ti.com>
Date:   Sat, 27 May 2023 11:49:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>
References: <ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: DT checker RS485 unevaluated property, 8250 OMAP UART
In-Reply-To: <ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 19/05/23 9:39 pm, Francesco Dolcini wrote:
> Hello,
> while writing a new DT file I stumbled across this warning
> 
> .../arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dev.dtb: serial@2810000: Unevaluated properties are not allowed ('rs485-rts-active-high' was unexpected)
> 	From schema: .../Documentation/devicetree/bindings/serial/8250_omap.yaml
> 
> The property is currently used in the OMAP serial driver
> 
> drivers/tty/serial/omap-serial.c
> 1511:	if (of_property_read_bool(np, "rs485-rts-active-high")) {
> 

Would be it possible to update driver to imply rs485-rts-active-high"
this by lack of rs485-rts-active-low property in DT instead?

> and a few DT files.
> 
> I do require it, despite being wrong, because of some legacy reasons [1].
> 
> Before commit 767d3467eb60 ("dt-bindings: serial: 8250_omap: drop rs485
> properties") this property was allowed.
> 
> What should I do?
>  - ignore the warning
>  - send a patch to reintroduce `rs485-rts-active-high: true` in 8250_omap.yaml
>  - something else?
> 
> I would be inclined to send the following patch, do you agree?
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> index eb3488d8f9ee..e634e98aa994 100644
> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> @@ -70,6 +70,7 @@ properties:
>    dsr-gpios: true
>    rng-gpios: true
>    dcd-gpios: true
> +  rs485-rts-active-low: true

I believe you mean rs485-rts-active-high here

>    rts-gpio: true
>    power-domains: true
>    clock-frequency: true
> 
> [1] https://lore.kernel.org/all/ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com/
> 

Also, I hope you are using 8250_ompa.c and not omap-serial.c for newer
designs. omap-serial.c is mostly there to support legacy SoCs and not to
be used with K3 SoCs.

Regards
Vignesh
