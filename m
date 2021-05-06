Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59875C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 09:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149E2610E7
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 09:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhEFJem (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 05:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhEFJee (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 05:34:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AF0C061574;
        Thu,  6 May 2021 02:33:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so3143056pjd.4;
        Thu, 06 May 2021 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROLdxjd3XuA6fGofDzufrhCwdbFtJZ4RIzvGcEESwTc=;
        b=d+y/bWDylajtxxHjGpGUGeUTlw/fwuYZ259lm1c4FJvBs13b5JwCJxCJLSU7O51m0Y
         vZw/qfMJwSIXYdDy9h+LgI8Z7cNjgoyLz4sMpNKo+VJ/iaIGGDUpBjRw0zdjGaacRlJn
         gcdsLnNhVJ2ql7MwR4NpE5XwCrVM30DO0kR5nTmrtJBtLzuGXG6e0jrHcpwlyXtf77Bh
         i8ldEWoO+eKAUMLS4Rw3ICcKeuHpDSEOk0ESKvLJgTrl2RvSyG2vG5DySpN4mT3s1AUK
         fUSnivYU7tan3nbJWxMA5ev4ZPgF+ESFv7WF2i5ev6cHGaaIYLRjBKaONjWwUWjtZlBk
         RTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROLdxjd3XuA6fGofDzufrhCwdbFtJZ4RIzvGcEESwTc=;
        b=L5E8vOMQo0eLfEQl0QrOjX/LmNJ6mBAQ9Uig+0CDnJExEdYsCvX0aKVqIUh1yU8kgF
         GWY87kpfPci0KCxRtCoycDv/J13zFq34ooFM9fxnIMQ2krhBhPJ6+cxCdJX/t9CulSJf
         YKFoCDyW2zQ2DgcR+ju2ncO9gzGszH9JaZhHidNwL4y+p2bTanrsqj51afKA/xTWQgpp
         aDjpcDaY45kAwAOJAsawK0oa+MUdX8+bQlOkcoMpHDUTgw66HmJ4Gbv/3OPToyFR9s9o
         zfIeqRNqFM4UH9KofY2Z3suOx1Bn6Bs8ZC5/G9rOP7UPw+Awi4fvady1/VAJif9vUgx5
         g/lQ==
X-Gm-Message-State: AOAM5328IevXEps8VEIH8HuiVWiHgpbfwGtyAZvK7g5vofqgT6FR0nAV
        E98ed0ycpz4PTpprDlHKqr+I1SnrrL5NFtKXU99zEXQshyk=
X-Google-Smtp-Source: ABdhPJwZ0wDAY1qHvV5+DB4JQaOAgYfX3x70qE2Oe4zHDZAdqmHIT0fTycuqx1nb6l/YdZ7tn8U7r3Rvp/oDWkPwr28=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr17129149pjv.129.1620293596449;
 Thu, 06 May 2021 02:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210505091928.22010-1-jslaby@suse.cz> <20210505091928.22010-35-jslaby@suse.cz>
 <ef1bd57095e941560530be43806791966a6735ad.camel@perches.com>
 <CAHp75Vfq6ABW7ukwaKmZOF2DszmuHD28S=wcLcFowvRdXTnWmg@mail.gmail.com> <7830c076-0d42-662c-5baa-2baecf1ad3b0@kernel.org>
In-Reply-To: <7830c076-0d42-662c-5baa-2baecf1ad3b0@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 12:33:00 +0300
Message-ID: <CAHp75VexEtUkRFQMUnMG4C0qR6pzJQufxJcF5AS0_a571AHRTg@mail.gmail.com>
Subject: Re: [PATCH 34/35] tty: make tty_get_byte_size available
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 6, 2021 at 11:31 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 06. 05. 21, 10:24, Andy Shevchenko wrote:
> > if (!account_flags)
> >    return bits;
> >
> > ?
>
> So I have:


Good to me, feel free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
to this variant.

> unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
> {
>          unsigned char bits;
>
>          switch (cflag & CSIZE) {
>          case CS5:
>                  bits = 5;
>                  break;
>          case CS6:
>                  bits = 6;
>                  break;
>          case CS7:
>                  bits = 7;
>                  break;
>          case CS8:
>          default:
>                  bits = 8;
>                  break;
>          }
>
>          if (!account_flags)
>                  return bits;
>
>          if (cflag & CSTOPB)
>                  bits++;
>          if (cflag & PARENB)
>                  bits++;
>
>          return bits + 2;
> }
>
> thanks,
> --
> js
> suse labs



-- 
With Best Regards,
Andy Shevchenko
