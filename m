Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B79FC433C1
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095F96191D
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 15:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCSPFa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhCSPFI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 11:05:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5FCF6191A;
        Fri, 19 Mar 2021 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616166307;
        bh=Jpyg1aRj2xrunboT1i35yraE5HMpPPlzSno+6EE70Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqdONhO25lJw7lATZ7aW9sLvHqX7cjABakXKej3SxsUYqxOlUnC+xW/oFbCI98da5
         bbYvkLwykwSb188+8+wkvUuNXkSuMKdtSO0DT0lO8FsQV5iCqNIMeH8HT/xv1J/iWD
         6f4vOw87EwjhwdQBYDt1AmU3grJUcy8kWJANkUJ6qYsIEBb2rSxrtODn2le1pOBe7/
         yRUIq5VikeKrn5DkZKDf16vnTeTwOIErz7me/lK9UXm8SAHUz6wPozoo8udQcfFh36
         2EyMktDT3CobPoajsknVOG9EypTc7HyUyl/BOYST6FcnhO2lhSt6ufO1IaXb44SYR4
         resbEsRbRk4gw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lNGgq-0005df-Fi; Fri, 19 Mar 2021 16:05:28 +0100
Date:   Fri, 19 Mar 2021 16:05:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?utf-8?B?RGXDoWss?= Imre <imre.deak@gmail.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
Message-ID: <YFS9uBe1v28DL18r@hovoldconsulting.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
 <YFB0OcBg3Vj555eA@hovoldconsulting.com>
 <CAHp75VfcbC63t_eZeBOA0NY28BtGBD0YyLR6nSNuKAnKhXTSzA@mail.gmail.com>
 <4771468d968a44789518bc547acf5f93@hisilicon.com>
 <YFRcYCMQrPXUG6ZU@hovoldconsulting.com>
 <CAHp75VfAEj1X9-aOUxFYW52F2FeTxetPHA0KenAjCB49KXbx3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfAEj1X9-aOUxFYW52F2FeTxetPHA0KenAjCB49KXbx3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 19, 2021 at 12:09:34PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 19, 2021 at 10:09 AM Johan Hovold <johan@kernel.org> wrote:

> > > I think it is almost always wrong to call spin_lock_irqsave in
> > > hardirq.
> >
> > Again, no. It's even been a requirement due to "threadirqs" in some
> > cases (e.g. hrtimers) up until now (or rather until the above patch is
> > in mainline).
> 
> By the way, a good question Imre (Cc'ed) and I have discussed is the
> in-kernel documentation, i.e.
> https://www.kernel.org/doc/html/latest/kernel-hacking/locking.html.
> Should it be adjusted to reality?

Once forced threading disables interrupts (as it should have all along)
we don't need to worry about this anymore. But yeah, otherwise it should
be documented.

Johan
