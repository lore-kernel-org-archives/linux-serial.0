Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1337C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 13:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F67613AD
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 13:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhKQN2B (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 08:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhKQN2B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 08:28:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31FEC061570
        for <linux-serial@vger.kernel.org>; Wed, 17 Nov 2021 05:25:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so11380035edd.0
        for <linux-serial@vger.kernel.org>; Wed, 17 Nov 2021 05:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXPqLSaR0/rcKoQ1WgCJ/lEbcwZdO6r31ST9S6scpXE=;
        b=XsPL6T4gNfN+T+79DN3IwIlsSm2TZqNBKJdkgD9qa/sGxG4d2FrxPszXlzRuADj46R
         0w95xCgdLx7ktjq6w2e20FoNXUYfKPgu0rK8Rkrd8p1LJD7caMsjtr4PL2YcpvCY2c0W
         Lg+Tn1934qOlxQ9j89Qr5WqJQACwXLVr5tAG9dX4jysJEJYDgpQGaGAYpudc5V7/pV1Z
         PNJHAMzAcxjfy6dwxDxjfvZPQHgmR/Plba5V4jm0Ox1SjvTqhe3kxpOeHNOM+xHLUSYF
         lilo7Hi9XvKIF9MwefxjY3dJEqkHhfJ7iB1E5OR9rk7svg9YtmQJlfUUM+PNJg5ilROJ
         YO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXPqLSaR0/rcKoQ1WgCJ/lEbcwZdO6r31ST9S6scpXE=;
        b=mqt796Jk4sBVghWR/v4NgfREoq+4dYpmy9fhMeO5E0yMxFsbCEdgWxtROJwz+S1jaW
         iBCzaOyyLnYtB3bgfPnISpWwbWxT3fSeYfOSnc34HoOnTqynyP5D3r/06P5WmA9kSeaI
         KaOB2+N+1w8K7zj2KxrQqIWt98sbsBZ89mSY7wSQkHNJcNxUYLjvsAB+QDQ2a+AbQBQD
         mKrhKNQ87ieriY0p7J5vMTDZ50zcXWbWSOZDLLLErrurcv1/Yb8NVJUryw5uV6BEF+tj
         CsZE5cgdZIMBQDYvtMcik/BJ8WnylIXuRhcs6XRmmYOrPJi57BBDtBm56Lxjh71RSlKM
         o+AQ==
X-Gm-Message-State: AOAM531Wkw5Pj/13obKZwwFsmeyU4zNAHoO3vFXdZxVWy5PGjjfTyfjY
        EAmAwgSjD3g9Rgr8A4wd+691va4oE6IdPhO/UT6He4fjPgOr/w==
X-Google-Smtp-Source: ABdhPJxtrrvawT1NELxcB+sOg5bQVNkYn9Cjl89whI96dXorDQcAPwuHXm4YIyQ2nQoK+R3Laq7ovLtw8/SLgBx55Lc=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr21009463ejb.128.1637155501216;
 Wed, 17 Nov 2021 05:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20211114183908.444923-1-jay.dolan@accesio.com>
 <CAHp75VcLr8MDwQUMgeOWKLP5QwwxGzbso61xJOK7-S=UHfn11w@mail.gmail.com> <401a1861-2716-04ec-ddd2-00010cc9c030@accesio.com>
In-Reply-To: <401a1861-2716-04ec-ddd2-00010cc9c030@accesio.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Nov 2021 15:24:20 +0200
Message-ID: <CAHp75Vd_V_bjfV2gPWNUkF5czNXVjJkVizRJ+fXWWWr9Jnppog@mail.gmail.com>
Subject: Re: [PATCH 0/3] serial: 8250_pci patches to address issues with pericom_do_set_divisor()
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 17, 2021 at 5:52 AM Jay Dolan <jay.dolan@accesio.com> wrote:
> On 11/16/21 7:34 AM, Andy Shevchenko wrote:
> > On Sun, Nov 14, 2021 at 8:40 PM Jay Dolan <jay.dolan@accesio.com> wrote:
> >>
> >> A series patches to address three issues one customer managed to hit all at once.
> >>
> >> 1) Rewrite pericom_do_set_divisor() to always calc divisor and to use the
> >> uartclk instead of a hard coded value. Always calculate divisor without passing
> >> control to serial8250_do_set_divisor()
> >> Tested with 14.7456 and 24 MHz crystals
> >>
> >> 2) Re-enable higher baud rates on Pericom chips.
> >> serial8250_get_baud_rate() added range checking, but Pericom chips have a wider
> >> range than what is being enforced. Make use of UPF_MAGIC_MULTIPLIER.
> >> Tested with 14.7456 and 24 MHz crystals
> >>
> >> 3) Fourth port not being setup correctly on some Pericom chips.
> >> Fix entries in pci_serial_quirks array
> >
> > Can we start from splitting Pericom to its own file, please?
> >
> > See my initial work here [1]. And I believe you may do a better job
> > than me since you have access to many variants of the hardware.
> >
> > [1]: https://gitlab.com/andy-shev/next/-/commit/71fdb8b5d857691031f566daebb1e850b106f46a
> That would be great. Breaking it out has been on my wish list for a
> while, but I doubt I was ever going to have time. I'm not familiar with
> GitLab. Is there a way for me to fetch this branch or should I just
> apply the diff I downloaded?

I will prepare a patch series where I take your patches and
incorporate mine in between. Stay tuned!

> > (As a side note:
> > https://gitlab.com/andy-shev/next/-/commit/ac0dc993fa35b5e2fe67e967b6a687b2e47d0edd)


-- 
With Best Regards,
Andy Shevchenko
