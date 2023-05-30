Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB6C77B73
	for <linux-serial@archiver.kernel.org>; Tue, 30 May 2023 10:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjE3KNi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 May 2023 06:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjE3KNf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 May 2023 06:13:35 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B8AB;
        Tue, 30 May 2023 03:13:30 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 785E91F842;
        Tue, 30 May 2023 12:13:25 +0200 (CEST)
Date:   Tue, 30 May 2023 12:13:20 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: DT checker RS485 unevaluated property, 8250 OMAP UART
Message-ID: <ZHXMMHQ9VevVtqHz@francesco-nb.int.toradex.com>
References: <ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com>
 <0cb182f8-eb53-45d8-3c8b-fb7d16f88d46@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb182f8-eb53-45d8-3c8b-fb7d16f88d46@ti.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, May 27, 2023 at 11:49:17AM +0530, Vignesh Raghavendra wrote:
> On 19/05/23 9:39 pm, Francesco Dolcini wrote:
> > Hello,
> > while writing a new DT file I stumbled across this warning
> > 
> > .../arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dev.dtb: serial@2810000: Unevaluated properties are not allowed ('rs485-rts-active-high' was unexpected)
> > 	From schema: .../Documentation/devicetree/bindings/serial/8250_omap.yaml
> > 
> > The property is currently used in the OMAP serial driver
> > 
> > drivers/tty/serial/omap-serial.c
> > 1511:	if (of_property_read_bool(np, "rs485-rts-active-high")) {
> > 
> 
> Would be it possible to update driver to imply rs485-rts-active-high"
> this by lack of rs485-rts-active-low property in DT instead?

What about backward compatibility? This is what is done in all drivers
apart omap-serial if I'm not wrong.

> > I would be inclined to send the following patch, do you agree?
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > index eb3488d8f9ee..e634e98aa994 100644
> > --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > @@ -70,6 +70,7 @@ properties:
> >    dsr-gpios: true
> >    rng-gpios: true
> >    dcd-gpios: true
> > +  rs485-rts-active-low: true
> 
> I believe you mean rs485-rts-active-high here
whoops, yes of course.

> 
> >    rts-gpio: true
> >    power-domains: true
> >    clock-frequency: true
> > 
> > [1] https://lore.kernel.org/all/ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com/
> > 
> 
> Also, I hope you are using 8250_ompa.c and not omap-serial.c for newer
> designs. omap-serial.c is mostly there to support legacy SoCs and not to
> be used with K3 SoCs.

Thanks for this head-up. This confused myself, while the issue I
reported here is real, it does affect only omap-serial.c. In my case I
am using 8250_omap.c and I can just omit the property from the DTS as
generally expected!

Francesco


