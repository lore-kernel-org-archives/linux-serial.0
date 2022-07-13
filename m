Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC45C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 13 Jul 2022 10:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiGMKTl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Jul 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiGMKTl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Jul 2022 06:19:41 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE6E0251;
        Wed, 13 Jul 2022 03:19:40 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c86fe1dddso107723397b3.1;
        Wed, 13 Jul 2022 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7K9RIsTB7qhaxVyNzqwwrUpbCvrSnTsy4cv/fUmIs4=;
        b=Y/0nPTRgiekpHs3vqhMQjlZgVGd/asaU6Il9ZzErijaqBx9WUk+ztSFtsEEd1fNq24
         AA5nRZBeFv1iFSHAQDbQdi5BSyxVcn3lh+kAPIJN02uCmNMmb5/AXb+doaHQ6BfCp50L
         YXtySiaZpEDiHYmg7eVbXusE4nFjqAJ380bqEUCSyPRR6nDz5jXIQED2tUE5KASivuN0
         IqVZSYbj5NEN8D95h5Y3FWQTlYvl8hjAg02J++JSSNW/lNVaHhulRO7yy8SR+A6t5GM3
         zHhr6okuiw5f5OInU7dkA2rQdsKNAZrtEJGuN54vUB6OkldnkU+lhtgGhoFGj0Rp+QYX
         Dk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7K9RIsTB7qhaxVyNzqwwrUpbCvrSnTsy4cv/fUmIs4=;
        b=dzfnqvVqwKF+LE9abWy4qdXTngOwcnFD1bDOfriGxxZBe9TdZPRWxS6C1wvUHDCfhT
         gcCFDJ7Y97sbt9mY+Ft69YrNjoAstXs5tmGzsMGYSVxMCRCCrVt1UFzAjEe6PV3UmxgC
         mUWxZwAOuJuK/pupI4Nqk9tJUhlzy0bspmr15bS3JVEUJTd13WHgDwe8LmarYRPv+dky
         ok9sMNWtgWX01FKT/U+vvqNGfk9BN63iKu9jvbC3PjAqtdd9yu9DVBqjsGoXIwysRpAF
         bJ3X6a+vRVarR9fnXEmfqCF8rhi44R/mguepZMatdscxSbt5QV3bZbMDAABxpOqn8xGE
         aYlw==
X-Gm-Message-State: AJIora/uRO7tJIq794AlMxO3oR5gjCcmamHzcPckngsN/FzJiH/d4tQe
        mwvxebhvlITIg7j0rsofdyc8Czs5chdeVsDvA24SeELm9/VEVg==
X-Google-Smtp-Source: AGRyM1uwaHf3qYYg6VKkIaiqRo1dXuxB06b+DzNgeG9a2XCfGxbs/vPoG2fMw5wXZkoizyNIPRY6kch9+bA1ZEZtx3Y=
X-Received: by 2002:a81:72c4:0:b0:31c:b309:c4e8 with SMTP id
 n187-20020a8172c4000000b0031cb309c4e8mr3318340ywc.520.1657707579858; Wed, 13
 Jul 2022 03:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220712131523.1874428-1-vamshigajjela@google.com>
 <CAHp75VecnJSv9P4ZXf5g4Yi7rYySRN=73KwZ_OBFUyFtaSq00w@mail.gmail.com> <CAMTSyjrhSSYVEBq=bdu9wBCcuPdrkmxS4jszOgOQBBvSKyaa_g@mail.gmail.com>
In-Reply-To: <CAMTSyjrhSSYVEBq=bdu9wBCcuPdrkmxS4jszOgOQBBvSKyaa_g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 12:19:03 +0200
Message-ID: <CAHp75VffbgrMq1ozyvci9MMed=MP2OadujCzXz8PTUCwnmY1Jw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Avoid pslverr on reading empty receiver fifo
To:     VAMSHI GAJJELA <vamshigajjela@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manu Gautam <manugautam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 13, 2022 at 10:13 AM VAMSHI GAJJELA
<vamshigajjela@google.com> wrote:
> On Tue, Jul 12, 2022 at 6:56 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jul 12, 2022 at 3:16 PM Vamshi Gajjela <vamshigajjela@google.com> wrote:

...

> > > +       lsr = p->serial_in(p, UART_LSR);
> >
> > The only caller of this function already has the lsr value, why you
> > can't (re)use it?
> lsr is not read before, caller function (dw8250_check_lcr) reads lcr.

I see, thanks for elaboration.

-- 
With Best Regards,
Andy Shevchenko
