Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7768EE7D0A4
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 18:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjIUSik (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjIUSiM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 14:38:12 -0400
X-Greylist: delayed 1804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 11:27:03 PDT
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FF1D62F0;
        Thu, 21 Sep 2023 11:27:01 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Thu, 21 Sep 2023 12:29:13 +0200
MIME-Version: 1.0
Date:   Thu, 21 Sep 2023 12:29:13 +0200
From:   m.brock@vanmierlo.com
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: sc16is7xx: add vendor prefix to
 irda-mode-ports property
In-Reply-To: <20230920152015.1376838-4-hugo@hugovil.com>
References: <20230920152015.1376838-1-hugo@hugovil.com>
 <20230920152015.1376838-4-hugo@hugovil.com>
Message-ID: <35710516d0c7f41eebceb16ee51d9d4d@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hugo Villeneuve wrote on 2023-09-20 17:20:
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -21,8 +21,8 @@ Optional properties:
>    the second cell is used to specify the GPIO polarity:
>      0 = active high,
>      1 = active low.
> -- irda-mode-ports: An array that lists the indices of the port that
> -		   should operate in IrDA mode.
> +- nxp,irda-mode-ports: An array that lists the indices of the port 
> that
> +		       should operate in IrDA mode.
>  - nxp,modem-control-line-ports: An array that lists the indices of
> the port that

Are you sure you want this line removed?

>  				should have shared GPIO lines configured as
>  				modem control lines.
> @@ -80,8 +80,8 @@ Optional properties:
>    the second cell is used to specify the GPIO polarity:
>      0 = active high,
>      1 = active low.
> -- irda-mode-ports: An array that lists the indices of the port that
> -		   should operate in IrDA mode.
> +- nxp,irda-mode-ports: An array that lists the indices of the port 
> that
> +		       should operate in IrDA mode.
>  - nxp,modem-control-line-ports: An array that lists the indices of
> the port that

Same here.

>  				should have shared GPIO lines configured as
>  				modem control lines.

Greets,
Maarten

