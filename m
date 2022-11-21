Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0547EC4332F
	for <linux-serial@archiver.kernel.org>; Mon, 21 Nov 2022 11:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKULcd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKULba (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Nov 2022 06:31:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D30BF80C
        for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2022 03:26:01 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DAD423F0A2
        for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2022 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669029959;
        bh=FiGkcGbzyfgd+faqNuzsk0J93877S/Msc6ZRoL9HQP0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qTWcb+mcPupDV2MGKFxLHVNzBflDIkphnwn2YttuS/sVDJ1gpq5fHQUGatfZTz3/O
         7mVmq0qp2eKhhk1x2CsQY08WWII/XrvuaJmUQHXauPyv74VzQDcAbR+M8xdwY7cB9T
         l9XwZAanOEpVI5Fo2Rg1ZkGspA4w3XiKfKJQPe3w/P2TpSFCESDgb0TiWx7Rq5adrJ
         1YPAD/1dqapWGQkz0UpsE/X0GdFVVD4CJ/bsqk9Gw8DX8R5uMdsuaeqahKaVFoHREc
         rWZVhAfLKk0GfrBtah4M8E8xLN4s0DqmJ9IVyb7S3+GCNlca+i/TyG0U185xo5z/My
         JZ2c1sACprPDw==
Received: by mail-yb1-f198.google.com with SMTP id w127-20020a25df85000000b006e990dfd5b8so6068109ybg.1
        for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2022 03:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiGkcGbzyfgd+faqNuzsk0J93877S/Msc6ZRoL9HQP0=;
        b=Ao3jJ9pjHVnue7NHEoT6/qazT8YppXFTu3JcgX3TbvG574CBNpS3mkEEEHp5eBzzvx
         MgS830ry1GdI+sG83hNTowhKq4MpbRibYHH2X8ZDZ1IhGWC7CjKjISgwL5wqPMzY3uD4
         KrO9YmOYiEJqbTrFm/M6YMkWZG/eFIZsp1yqldbhqs+G/QsehflQq4/ZDv7TgQ873ym2
         V5QsNE2DLQyLpxxqjDX7Aez8DdPxZEVkw7iMV2efmTg5LEdfueiuXWcBeGm+tMHoxYPk
         HEntLi+DNu6tvBLCSEe0Fhk8EeZJwJMO/tR/90RpE6ekKk+KnramEVlylToyuKh2mpdb
         cUSg==
X-Gm-Message-State: ANoB5plSBXjXxq1RUqOGerXdWsO2GzVkEloFuarCaTtJR8dJe8rGXxhF
        EYa/uQkC8/mYUch2x0qp4VIsMDdDKWa3LNfkX5h0bCorWQ7ObV34SiS8pgorRJmw/7xxKXEeULx
        D1Bms6CMN3Epx3CJSA7lTTf9d3Y8QISUQLdSZDUBnfWipXxXxoYtBbTEA9Q==
X-Received: by 2002:a25:abe4:0:b0:6e7:cbc4:1ac3 with SMTP id v91-20020a25abe4000000b006e7cbc41ac3mr15644377ybi.559.1669029958929;
        Mon, 21 Nov 2022 03:25:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Xq9tjSs4Qr1D2ghrSTz4SnS2vs/YppSYp35p6mK+zW9yruVxeUf3o6O+n1peXM/7BVePjaiCc53Vd+/yylUE=
X-Received: by 2002:a25:abe4:0:b0:6e7:cbc4:1ac3 with SMTP id
 v91-20020a25abe4000000b006e7cbc41ac3mr15644356ybi.559.1669029958721; Mon, 21
 Nov 2022 03:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20221120082114.3030-1-jszhang@kernel.org> <20221120082114.3030-6-jszhang@kernel.org>
 <CAJM55Z_f=zp3Z=wno_yr7csAUMQ472RiZXD19CrDTTxmGAmU4w@mail.gmail.com> <540beefcad5f9921068d54d056f168a4c45ffeaf.camel@icenowy.me>
In-Reply-To: <540beefcad5f9921068d54d056f168a4c45ffeaf.camel@icenowy.me>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 21 Nov 2022 12:25:42 +0100
Message-ID: <CAJM55Z9D1=T-mZkScP2LJbRfi=gB8bmpKDMndHhXGomFGN9OOA@mail.gmail.com>
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 21 Nov 2022 at 04:37, Icenowy Zheng <uwu@icenowy.me> wrote:
>
> =E5=9C=A8 2022-11-20=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 15:57 +0100=EF=
=BC=8CEmil Renner Berthing=E5=86=99=E9=81=93=EF=BC=9A
> > On Sun, 20 Nov 2022 at 09:32, Jisheng Zhang <jszhang@kernel.org>
> > wrote:
> > >
> > > Add a baisc dtsi for the bouffalolab bl808 SoC.
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/boot/dts/Makefile               |  1 +
> > >  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74
> > > ++++++++++++++++++++++
> > >  2 files changed, 75 insertions(+)
> > >  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> > >
> > > diff --git a/arch/riscv/boot/dts/Makefile
> > > b/arch/riscv/boot/dts/Makefile
> > > index ff174996cdfd..b525467152b2 100644
> > > --- a/arch/riscv/boot/dts/Makefile
> > > +++ b/arch/riscv/boot/dts/Makefile
> > > @@ -1,4 +1,5 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > > +subdir-y +=3D bouffalolab
> > >  subdir-y +=3D sifive
> > >  subdir-y +=3D starfive
> > >  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) +=3D canaan
> > > diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> > > b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> > > new file mode 100644
> > > index 000000000000..c98ebb14ee10
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> > > @@ -0,0 +1,74 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > +/*
> > > + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> > > + */
> > > +
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +/ {
> > > +       compatible =3D "bouffalolab,bl808";
> > > +       #address-cells =3D <1>;
> > > +       #size-cells =3D <1>;
> > > +
> > > +       cpus {
> > > +               timebase-frequency =3D <1000000>;
> > > +               #address-cells =3D <1>;
> > > +               #size-cells =3D <0>;
> > > +
> > > +               cpu0: cpu@0 {
> > > +                       compatible =3D "thead,c906", "riscv";
> > > +                       device_type =3D "cpu";
> > > +                       reg =3D <0>;
> > > +                       d-cache-block-size =3D <64>;
> > > +                       d-cache-sets =3D <256>;
> > > +                       d-cache-size =3D <32768>;
> > > +                       i-cache-block-size =3D <64>;
> > > +                       i-cache-sets =3D <128>;
> > > +                       i-cache-size =3D <32768>;
> > > +                       mmu-type =3D "riscv,sv39";
> > > +                       riscv,isa =3D "rv64imafdc";
> > > +
> > > +                       cpu0_intc: interrupt-controller {
> > > +                               compatible =3D "riscv,cpu-intc";
> > > +                               interrupt-controller;
> > > +                               #address-cells =3D <0>;
> > > +                               #interrupt-cells =3D <1>;
> > > +                       };
> > > +               };
> > > +       };
> > > +
> > > +       xtal: xtal-clk {
> > > +               compatible =3D "fixed-clock";
> > > +               clock-frequency =3D <40000000>;
> >
> > This was discussed many times before, but I think the conclusion was
> > that the frequency is a property of the crystal on the board, so this
> > should be 0 in the SoC dtsi, and then overwritten in the board device
> > tree.
>
> But many chips just specify an accepted frequency in their datasheet,
> and using a frequency other than this is undefined behavior.

Yes, this was the argument in previous discussions, but the conclusion
was still that it should go in the board dts. To be clear I'm just
summing up the conclusion from previous discussions about this, and
have no strong opinion other than we should do the same everywhere.

> >
> > > +               clock-output-names =3D "xtal";
> > > +               #clock-cells =3D <0>;
> > > +       };
> > > +
> > > +       soc {
> > > +               compatible =3D "simple-bus";
> > > +               ranges;
> > > +               interrupt-parent =3D <&plic>;
> > > +               dma-noncoherent;
> > > +               #address-cells =3D <1>;
> > > +               #size-cells =3D <1>;
> > > +
> > > +               uart0: serial@30002000 {
> > > +                       compatible =3D "bouffalolab,uart";
> > > +                       reg =3D <0x30002000 0x1000>;
> > > +                       interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clocks =3D <&xtal>;
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > > +               plic: interrupt-controller@e0000000 {
> > > +                       compatible =3D "thead,c900-plic";
> > > +                       reg =3D <0xe0000000 0x4000000>;
> > > +                       interrupts-extended =3D <&cpu0_intc
> > > 0xffffffff>,
> > > +                                             <&cpu0_intc 9>;
> > > +                       interrupt-controller;
> > > +                       #address-cells =3D <0>;
> > > +                       #interrupt-cells =3D <2>;
> > > +                       riscv,ndev =3D <64>;
> > > +               };
> > > +       };
> > > +};
> > > --
> > > 2.37.2
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
