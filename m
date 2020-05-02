Return-Path: <SRS0=4P1W=6Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEDBC3A5A9
	for <linux-serial@archiver.kernel.org>; Sat,  2 May 2020 13:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C63F216FD
	for <linux-serial@archiver.kernel.org>; Sat,  2 May 2020 13:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgEBNwA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 May 2020 09:52:00 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:49021 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgEBNwA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 May 2020 09:52:00 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8205630000889;
        Sat,  2 May 2020 15:51:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5396F26497D; Sat,  2 May 2020 15:51:58 +0200 (CEST)
Date:   Sat, 2 May 2020 15:51:58 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 5/7] dt-bindings: serial: Add binding for rs485
 receiver enable GPIO
Message-ID: <20200502135158.zphroi533ocualot@wunner.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-6-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231422.1502366-6-heiko@sntech.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 12:14:20AM +0100, Heiko Stuebner wrote:
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -44,6 +44,10 @@ properties:
>     description: enables the receiving of data even while sending data.
>     $ref: /schemas/types.yaml#/definitions/flag
>  
> +  rs485-rx-enable-gpios:
> +   description: GPIO to handle a separate RS485 receive enable signal
> +   $ref: /schemas/types.yaml#/definitions/flag
> +

This isn't a flag, so you need the "maxItems: 1" line instead,
as you correctly did below:

>    rs485-term-gpios:
>      description: GPIO pin to enable RS485 bus termination.
>      maxItems: 1
