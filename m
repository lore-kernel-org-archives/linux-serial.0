Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A382BCDB465
	for <linux-serial@archiver.kernel.org>; Thu, 19 Oct 2023 15:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjJSPNW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Oct 2023 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjJSPNV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Oct 2023 11:13:21 -0400
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 08:13:19 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B0111D
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 08:13:19 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id E3F7120D5A;
        Thu, 19 Oct 2023 17:05:30 +0200 (CEST)
Date:   Thu, 19 Oct 2023 17:05:26 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: 8250_omap: add
 rs485-rts-active-high
Message-ID: <ZTFFp8Yr7lq6HIab@francesco-nb.int.toradex.com>
References: <20230531111038.6302-1-francesco@dolcini.it>
 <CAMuHMdUkPiA=o_QLyuwsTYW7y1ksCjHAqyNSHFx2QZ-dP-HGsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUkPiA=o_QLyuwsTYW7y1ksCjHAqyNSHFx2QZ-dP-HGsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Geert,

On Thu, Oct 19, 2023 at 12:09:06PM +0200, Geert Uytterhoeven wrote:
> On Wed, May 31, 2023 at 1:14 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >
> > Add rs485-rts-active-high property, this was removed by mistake.
> > In general we just use rs485-rts-active-low property, however the OMAP
> > UART for legacy reason uses the -high one.
> >
> > Fixes: 767d3467eb60 ("dt-bindings: serial: 8250_omap: drop rs485 properties")
> > Closes: https://lore.kernel.org/all/ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com/
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > v2: removed reported-by
> 
> Thanks for your patch, which is now commit 403e97d6ab2cb6fd
> ("dt-bindings: serial: 8250_omap: add rs485-rts-active-high")
> in v6.4-rc5.
> 
> > --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > @@ -70,6 +70,7 @@ properties:
> >    dsr-gpios: true
> >    rng-gpios: true
> >    dcd-gpios: true
> > +  rs485-rts-active-high: true
> 
> make dt_binding_check complains:
> 
>     Documentation/devicetree/bindings/serial/8250_omap.yaml:
> rs485-rts-active-high: missing type definition

For some reasons it works for me (and worked when I did send the patch)

$ make dt_binding_check DT_SCHEMA_FILES=8250_omap.yaml
...
  HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
  HOSTCC  scripts/dtc/fdtoverlay.o
  HOSTLD  scripts/dtc/fdtoverlay
  LINT    Documentation/devicetree/bindings
invalid config: unknown option "required" for rule "quoted-strings"
xargs: /usr/bin/yamllint: exited with status 255; aborting
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/francesco/Toradex/sources/linux/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml: ignoring, error in schema: properties: qcom,ls-fs-output-impedance-bp
/home/francesco/Toradex/sources/linux/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml: ignoring, error in schema: properties: gpio-controller
/home/francesco/Toradex/sources/linux/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-nanoamp
/home/francesco/Toradex/sources/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: ignoring, error in schema: patternProperties: ^channel@([0-9a-f])$: properties: adi,burnout-current-nanoamp
/home/francesco/Toradex/sources/linux/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml: ignoring, error in schema: properties: adi,ext2-burnout-current-nanoamp
  DTEX    Documentation/devicetree/bindings/serial/8250_omap.example.dts
  DTC_CHK Documentation/devicetree/bindings/serial/8250_omap.example.dtb


any idea on what could be different between us?

> This property should have been added to
> Documentation/devicetree/bindings/serial/serial.yaml first.

Francesco


