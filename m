Return-Path: <SRS0=5qHh=DE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF21C4346E
	for <linux-serial@archiver.kernel.org>; Sun, 27 Sep 2020 12:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3372A23976
	for <linux-serial@archiver.kernel.org>; Sun, 27 Sep 2020 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601208786;
	bh=cwM2MQgUW0czb3fR0yjHJGDDSXpDnNHhOU8ZfZwwJ0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yi5qd4Dd9D1nRBcbK5/36RiRXH1bBCtRY0aDleMyiFjqe5EmLIwMWgrBU4D6h4CQb
	 63hAkzY6wDAjHWiTYgNnAibgXsxo/2iZPF9hxTPBo/L94Zz8krsjZnRXItRvAg+n/3
	 ARMaVl/eFE/NXy7hrBjKdKYR3PoHVHE2buhJN2t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgI0MNF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Sep 2020 08:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgI0MNF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Sep 2020 08:13:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 848BD23718;
        Sun, 27 Sep 2020 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601208785;
        bh=cwM2MQgUW0czb3fR0yjHJGDDSXpDnNHhOU8ZfZwwJ0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBPA+YlVAkBjcsDQPbok4wsg8dGHaPw8F5X3jpvi3kDY+RRRhZupH3ntET5AYvWb/
         xl9klFyxioPJGWlWbU7KTu39H+2LhEheETfetB2xuyuu5JvUbjgrQCVTGoqRjmO8Ax
         jdmn0p1vGfKKCRtGBM3/4dS0Zrzq5IQl/uZA8NKc=
Date:   Sun, 27 Sep 2020 14:13:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: serial: renesas,scif: Document r8a774e1
 bindings
Message-ID: <20200927121315.GB164938@kroah.com>
References: <1594230511-24790-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594230511-24790-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8tTSo4bp8bdQnf1KA9z7d+AjxfC5Abk0iuV4L_r20PwPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8tTSo4bp8bdQnf1KA9z7d+AjxfC5Abk0iuV4L_r20PwPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Sep 19, 2020 at 11:35:39AM +0100, Lad, Prabhakar wrote:
> Hi Greg,
> 
> On Wed, Jul 8, 2020 at 6:48 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > RZ/G2H (R8A774E1) SoC also has the R-Car gen3 compatible SCIF ports,
> > so document the SoC specific bindings.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> Could you please pick this patch.

Sorry for the delay, I missed that Rob acked it.  Both now queued up.

greg k-h
