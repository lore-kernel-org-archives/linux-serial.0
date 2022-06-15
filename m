Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A3CCA473
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 20:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbiFOUbA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346105AbiFOUbA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 16:31:00 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48154BDA
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 13:30:59 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso18014186fac.4
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGPPd7PZu9HxKtdoxwqOJ2SMNchnSdrXD0y0lHK5RM0=;
        b=k7lq/649HWyaLEl+V4GP0HGGDcXAP+RhRvBEADeIv7GUFO0qUVrNhFontAKLV3JBvt
         UbDBedGWxkU3gwCqht3eXCQYJ8J23LpA18DaW+kcUUhGDVplOTg4+PKlS7HQFiXKkj5W
         inHbFs70gJ0tCHEGajDCVSbWE2lDopKrg7nBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGPPd7PZu9HxKtdoxwqOJ2SMNchnSdrXD0y0lHK5RM0=;
        b=3BHZiA7dGrvZXBEbtMOasuQ4bFmsd2e7p3H7s8/EerZT9qE+ZqS9fyA9NojaujuMll
         P1DnE/vJyHjBhw6HPOXnhySRPXbBQL0MnYmOTlfpV62ItEvpz0KFw5R/E6AUxIl4Oq2K
         4J7GaTpxqELRRmF9KEU3GVphNnf03cpQh4J4qK3Bx8VejczEsFMDQSBFUnQygofxs/EW
         fbTMtatupvoSKuG49b87rWhNUPtOHlnKD41qyfMZ16L3h5PNuBBzPLjypOsBmAvPhOFf
         EJ9Z2Vcb24bA0HBVhCGSSCw03EQ8hIEn7xK+9Edj1XGSVU5B3zXIk18cD8+NR5lOGXKc
         4glQ==
X-Gm-Message-State: AJIora+LSK4Xo/cPmqrwNhO0a8FZMsJaVZZhCm7QKS4Ya4T3HgWfUFvf
        HQlWSp5uzHFxLdF7U2IOuL9gBl3X8HJjNdZw+aZe1w==
X-Google-Smtp-Source: AGRyM1uQi1TMDIgq4wQD38w0gj+e0oSvQLAqdIgjR30ifcAeVJd+TJKWOQNN+zZeiC0VAkmK67zEb03FcFdj9exTByA=
X-Received: by 2002:a05:6870:3053:b0:f3:2997:659a with SMTP id
 u19-20020a056870305300b000f32997659amr876535oau.7.1655325058338; Wed, 15 Jun
 2022 13:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220615104833.3963552-1-windhl@126.com> <Yqm6LvDGqaRMaUHa@kroah.com>
 <CAPM=9twCiqyakgPLz0v=7-abUhzLb8ZZH7-U65PV8qtQOP7Xww@mail.gmail.com>
In-Reply-To: <CAPM=9twCiqyakgPLz0v=7-abUhzLb8ZZH7-U65PV8qtQOP7Xww@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 15 Jun 2022 22:30:47 +0200
Message-ID: <CAKMK7uG+TeATXctJaXBgSRxpinDdtOhGa+o2CMPaPtO1QyHtJA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] drivers: tty: serial: Add missing
 of_node_put() in serial-tegra.c
To:     Dave Airlie <airlied@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-tegra@vger.kernel.org,
        heliang <windhl@126.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-serial@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 15 Jun 2022 at 22:23, Dave Airlie <airlied@gmail.com> wrote:
>
> On Wed, 15 Jun 2022 at 20:53, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 15, 2022 at 06:48:33PM +0800, heliang wrote:
> > > In tegra_uart_init(), of_find_matching_node() will return a node
> > > pointer with refcount incremented. We should use of_node_put()
> > > when it is not used anymore.
> > >
> > > Signed-off-by: heliang <windhl@126.com>
> >
> > We need a real name please, one you sign documents with.
>
> How do we enforce that? What if Wong, Adele or Beyonce submit a patch?
>
> What happens if that patch gets reposted, with S-o-b: He Liang
> <windhl@126.com> or Hel Iang, Heli Ang? Do you know any of those are
> real names? What happens if they post a real name in
> Mandarin/Thai/Cyrillic, can you validate it?
>
> Really we require you have an identity attached to an email. If there
> is a problem in the future, we'd prefer the email continues to work so
> that you are contactable. If you are submitting a small amount of
> changes it's probably never going to matter. If you are submitting
> larger bodies of work of course it would be good to have a company or
> larger org attached to track things down legally later, but again that
> isn't always possible.
>
> I don't think alienating the numerous developers who no longer use
> their legal names are identified by one name, but haven't changed
> their legal one yet people who get married and change their legal name
> but don't change their contribution name and I could run this sentence
> on forever.

Yeah like absolute best case trying to "enforce" this just results in
encouraging people to come up with entirely fake but English looking
names for themselves. Which ... just no.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
