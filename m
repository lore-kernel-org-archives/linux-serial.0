Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600E3C77B7A
	for <linux-serial@archiver.kernel.org>; Tue, 30 May 2023 13:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjE3NYc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 May 2023 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjE3NYb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 May 2023 09:24:31 -0400
X-Greylist: delayed 11461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 06:24:29 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16584B0;
        Tue, 30 May 2023 06:24:29 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 25694209A7;
        Tue, 30 May 2023 15:24:27 +0200 (CEST)
Date:   Tue, 30 May 2023 15:24:22 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: DT checker RS485 unevaluated property, 8250 OMAP UART
Message-ID: <ZHX5Bm5pRUebY0Xu@francesco-nb.int.toradex.com>
References: <ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com>
 <0cb182f8-eb53-45d8-3c8b-fb7d16f88d46@ti.com>
 <ZHXMMHQ9VevVtqHz@francesco-nb.int.toradex.com>
 <cd06b0f4-fb86-cc16-5a80-b4896b5c4cd9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd06b0f4-fb86-cc16-5a80-b4896b5c4cd9@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 30, 2023 at 01:38:42PM +0200, Krzysztof Kozlowski wrote:
> On 30/05/2023 12:13, Francesco Dolcini wrote:
> > On Sat, May 27, 2023 at 11:49:17AM +0530, Vignesh Raghavendra wrote:
> >> On 19/05/23 9:39 pm, Francesco Dolcini wrote:
> >>> I would be inclined to send the following patch, do you agree?
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> >>> index eb3488d8f9ee..e634e98aa994 100644
> >>> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> >>> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> >>> @@ -70,6 +70,7 @@ properties:
> >>>    dsr-gpios: true
> >>>    rng-gpios: true
> >>>    dcd-gpios: true
> >>> +  rs485-rts-active-low: true
> >>
> >> I believe you mean rs485-rts-active-high here
> > whoops, yes of course.
> 
> Yes, with a Fixes tag.

Ack

> >>>    rts-gpio: true
> >>>    power-domains: true
> >>>    clock-frequency: true
> >>>
> >>> [1] https://lore.kernel.org/all/ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com/
> >>>
> >>
> >> Also, I hope you are using 8250_ompa.c and not omap-serial.c for newer
> >> designs. omap-serial.c is mostly there to support legacy SoCs and not to
> >> be used with K3 SoCs.
> > 
> > Thanks for this head-up. This confused myself, while the issue I
> > reported here is real, it does affect only omap-serial.c. In my case I
> > am using 8250_omap.c and I can just omit the property from the DTS as
> > generally expected!
> 
> OK. Are you going send a fix for original issue?

I'll do it, thanks!

