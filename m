Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38748C49EA7
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B63761941
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFYPZE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:25:04 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:33382 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFYPZD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 11:25:03 -0400
Received: by mail-ua1-f51.google.com with SMTP id x22so3706629uap.0;
        Fri, 25 Jun 2021 08:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dckc1Y5oArfmqGf9uhmcW+nVHTA44z1zSQ9JQ8A7cx0=;
        b=OdFz68Ss39x1a3x9wewTT1eEq+Owq4P92wZJSjxYbRsN75VneRc0R979vQnEjDAQ3R
         htxICHBUvvcrZFGud10IQS4rrn8vYVa4wFpP3DIl13JpwVUQGPUCyFwsFJUhki7Wgo3m
         7YixqNtyUdyxLHfsmCb+4gDlAq6Ypa79BCavSC/trjPtPh/PRfUJlqFli/H9uPN7U3vO
         BIOmCwpaWHNm9oIZJBm2RuLy1rXDNMT9p9Zdyz0tzAz9wcj7dqdPHPoPCnU4Ggk5KZS3
         4bZ+z/9uyhU/NuoA7FrmfDNDJs94lBn4zPEc9X9Xzpkz75ITXKKUqH/bPoOJPdOqXug+
         x6eQ==
X-Gm-Message-State: AOAM532Ra1lXQYquyWN0TEMxj6/hNrCks/8V24AZjnBn+G54EKPX7JFL
        aT3P2UCKMGzOidvWfkaGtj7lYawUqooo9M6jTlc=
X-Google-Smtp-Source: ABdhPJxwYqp45mNSYBwJKHtWJ8GFH7IJzuCBQqhfVtE1/NiRa0Ja4ZkGaTYr8Tie+8VSPZCAVrVmqKI1uLm5wnTFnqw=
X-Received: by 2002:ab0:647:: with SMTP id f65mr11970038uaf.4.1624634562204;
 Fri, 25 Jun 2021 08:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210624224909.6350-1-pali@kernel.org> <20210625143617.12826-1-pali@kernel.org>
 <20210625143617.12826-8-pali@kernel.org>
In-Reply-To: <20210625143617.12826-8-pali@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Jun 2021 17:22:31 +0200
Message-ID: <CAMuHMdUCEHtqNk-nGJhPK_=NrgSoRhmC99J9pdGqQxcWpoFqGg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] math64: New DIV_U64_ROUND_CLOSEST helper
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Pali,

On Fri, Jun 25, 2021 at 4:37 PM Pali Rohár <pali@kernel.org> wrote:
> Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
> division rounded to the closest integer using unsigned 64bit
> dividend and unsigned 32bit divisor.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>

Thanks for your patch!

> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -281,6 +281,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
>  #define DIV64_U64_ROUND_CLOSEST(dividend, divisor)     \
>         ({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
>
> +/*
> + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
> + * @dividend: unsigned 64bit dividend
> + * @divisor: unsigned 32bit divisor
> + *
> + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> + * and round to closest integer.
> + *
> + * Return: dividend / divisor rounded to nearest integer
> + */
> +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \
> +       ({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })

Given "dividend" should already be an unsigned 64-bit value, I don't
think the cast to "u64" is needed. Similar macros in this file also
don't have the cast.

> +
>  /*
>   * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
>   * @dividend: signed 64bit dividend

With the above nit fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
