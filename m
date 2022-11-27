Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD04C46467
	for <linux-serial@archiver.kernel.org>; Sun, 27 Nov 2022 17:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiK0RhA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Nov 2022 12:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiK0Rg7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Nov 2022 12:36:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A3BEE28;
        Sun, 27 Nov 2022 09:36:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A47EB60E2C;
        Sun, 27 Nov 2022 17:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81876C433C1;
        Sun, 27 Nov 2022 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669570618;
        bh=5hMfqLN2vlKfjD92hPO3MtkG8W9uvJa+Nmuer26I3s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adeVPacnVCFAnGjw23mZi2tztUCyjK3CEJWIt/fAP9vhJkvU2ikTpSTrNqzqgcYjN
         DcRXHYTr6vzBQLExSta+ycdwE/9KqbKTqRVIaUxmio9ohoY/uQlML+S5Jid25eo7TS
         iu0TLNYy9+RKUv4HJ7ceDBmT+mPYiwueTe02T87gM8rS0Akf94RBAFLTY/Eu6f+lEp
         Ve2FD/HHgxqipOCpUlxQemEkSETmK5yz4ck/kedAta6bc3F4rp5JDI5G8j5uJtUoUW
         kKnGwFGb4FPMyZQgswRel0p+zqyKoFt7KW0jP70p11cjvr3Xg9dhITfhXBegNYT15g
         2H7yjIIPgx8vQ==
Date:   Sun, 27 Nov 2022 17:36:53 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 8/9] MAINTAINERS: riscv: add entry for Bouffalolab SoC
Message-ID: <Y4OgNW6uOe60Pi09@spud>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-9-jszhang@kernel.org>
 <Y4Of7s6UGpD0/Iga@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Of7s6UGpD0/Iga@spud>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 27, 2022 at 05:35:48PM +0000, Conor Dooley wrote:
> Hey Jisheng,
> 
> On Sun, Nov 27, 2022 at 09:24:47PM +0800, Jisheng Zhang wrote:
> > Add Jisheng Zhang as Bouffalolab SoC maintainer.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 00ff4a2949b8..a6b04249853c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17729,6 +17729,15 @@ F:	arch/riscv/
> >  N:	riscv
> >  K:	riscv
> >  
> > +RISC-V BOUFFALOLAB SOC SUPPORT
> > +M:	Jisheng Zhang <jszhang@kernel.org>
> > +L:	linux-riscv@lists.infradead.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > +F:	Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> > +F:	arch/riscv/boot/dts/bouffalolab/
> > +F:	drivers/tty/serial/bflb_uart.c
> 
> I think I asked last time but I didn't see an answer on lore or my
> mailbox - if you intend sending Arnd PRs for this stuff, please add a
> git tree here. Otherwise, LMK and I'll bundle it with the other "misc
> riscv devicetree" stuff.

I forgot:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> >  RISC-V MICROCHIP FPGA SUPPORT
> >  M:	Conor Dooley <conor.dooley@microchip.com>
> >  M:	Daire McNamara <daire.mcnamara@microchip.com>
> > -- 
> > 2.38.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
