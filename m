Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDAFC43334
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jun 2022 23:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiFWXWQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiFWXWQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jun 2022 19:22:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31C4EDF3
        for <linux-serial@vger.kernel.org>; Thu, 23 Jun 2022 16:22:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so1281355ejb.4
        for <linux-serial@vger.kernel.org>; Thu, 23 Jun 2022 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxjBbBcjmslNhdIXm64iYG30RpR38jzIQFM2VG0pyWk=;
        b=YGgiTjZpMTXUZqP/ciKsDE+Nmhq73xz+i3S8ybLgFBPzWsJTJNJrEE4ZwQZsP/aoJs
         lz0RdSGJdozkmKD4lrCiY22HOqJQHcpuV9zNJXbXdlJ0pyOfCTWv6Dv7V/aGR3ieEqMu
         MZERWHOn8g4UYI2l3JMY9Fzgc1qyanI9Y0nFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxjBbBcjmslNhdIXm64iYG30RpR38jzIQFM2VG0pyWk=;
        b=mnlohd9d3WbevoqWjQfXMotz+h89WzQa9nIeeE983DhUMgLzYxujxI9n1dm2TKkeAV
         iZtXD/tWKSlvc7ozGv/IQvcez8rBPd4YpfJjeSHYOUY92h5ITJkRvfdrwXT+PXe3EJPQ
         GTlKO3/jSnpOtdyfW3JG10O+/gxm47Qj2gVngvvYyJhbVyalQm6TGn+VgtaUfd4GmJyy
         +QD9O7Dlvty+KGcobUpn9nV7/MJ0imxcTI2lxdpgDuWNFAfmjp7dnb7wx8HjhGxtHXb8
         TLOvierOusBTIrrXkqtmC2Rty4PLG18Opn+vY3gcy6JbWc4KLeYPPuCTshoSYs3lPJvt
         ek4g==
X-Gm-Message-State: AJIora+/XAEUznr/B/pgYeuX6hKAd4/8niCHKojdYZ/xRhA0dbnnFwxT
        4aJhYY1DwmtfgIx5Vn6gSkOIq+FgrFtQGIcZ
X-Google-Smtp-Source: AGRyM1tEINpSUTYGlH/tbCpsMiKfYVheOobHLEftOxn62p+hZ7X01ZkLUoljJ6qCtxA4uw5IqWoC7A==
X-Received: by 2002:a17:906:6a26:b0:718:e1a9:b86b with SMTP id qw38-20020a1709066a2600b00718e1a9b86bmr10428968ejc.271.1656026533124;
        Thu, 23 Jun 2022 16:22:13 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id el3-20020a056402360300b0043585bb803fsm603288edb.25.2022.06.23.16.22.11
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 16:22:12 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so542382wmb.5
        for <linux-serial@vger.kernel.org>; Thu, 23 Jun 2022 16:22:11 -0700 (PDT)
X-Received: by 2002:a05:600c:34d0:b0:3a0:2c07:73ac with SMTP id
 d16-20020a05600c34d000b003a02c0773acmr387823wmq.85.1656026531346; Thu, 23 Jun
 2022 16:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Jun 2022 16:21:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9wDk2e7sVDUZg6wamX6mjBu6Wp4bUcDNAyxTNeDsiWg@mail.gmail.com>
Message-ID: <CAD=FV=X9wDk2e7sVDUZg6wamX6mjBu6Wp4bUcDNAyxTNeDsiWg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Fix get_clk_div_rate()
 which otherwise could return a sub-optimal clock rate.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Jun 21, 2022 at 10:57 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> In the logic around call to clk_round_rate, for some corner conditions,
> get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> exact clock rate was not found lowest clock was being returned.
>
> Search for suitable clock rate in 2 steps
> a) exact match or within 2% tolerance
> b) within 5% tolerance
> This also takes care of corner conditions.
>
> Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 134 ++++++++++++++++++++++++++--------
>  1 file changed, 102 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 2e23b65..8d247c1 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -943,52 +943,123 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>         return 0;
>  }
>
> -static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> -                       unsigned int sampling_rate, unsigned int *clk_div)
> +static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
> +                       unsigned int *clk_div, unsigned int percent_tol, bool *exact_match)
>  {
> +       unsigned long freq;
> +       unsigned long div, maxdiv, new_div;
> +       unsigned long long mult;
>         unsigned long ser_clk;
> -       unsigned long desired_clk;
> -       unsigned long freq, prev;
> -       unsigned long div, maxdiv;
> -       int64_t mult;
> -
> -       desired_clk = baud * sampling_rate;
> -       if (!desired_clk) {
> -               pr_err("%s: Invalid frequency\n", __func__);
> -               return 0;
> -       }
> +       unsigned long test_freq, offset, new_freq;
>
> +       ser_clk = 0;
>         maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
> -       prev = 0;
> +       div = 1;
>
> -       for (div = 1; div <= maxdiv; div++) {
> -               mult = div * desired_clk;
> -               if (mult > ULONG_MAX)
> +       while (div <= maxdiv) {
> +               mult = (unsigned long long)div * desired_clk;
> +               if (mult != (unsigned long)mult)
>                         break;
>
> -               freq = clk_round_rate(clk, (unsigned long)mult);
> -               if (!(freq % desired_clk)) {
> -                       ser_clk = freq;
> -                       break;
> +               /*
> +                * Loop requesting a freq within tolerance and possibly exact freq.
> +                *
> +                * We'll keep track of the lowest freq inexact match we found
> +                * but always try to find a perfect match. NOTE: this algorithm
> +                * could miss a slightly better freq if there's more than one
> +                * freq between (freq - offset) and (freq) but (freq) can't be made
> +                * exactly, but that's OK.
> +                *
> +                * This absolutely relies on the fact that the Qualcomm clock
> +                * driver always rounds up.
> +                * We make use of exact_match as an I/O param.
> +                */
> +
> +               /* look only for exact match if within tolerance is already found */
> +               if (ser_clk)
> +                       offset = 0;
> +               else
> +                       offset = (mult * percent_tol) / 100;
> +
> +               test_freq = mult - offset;
> +               freq = clk_round_rate(clk, test_freq);
> +
> +               /*
> +                * A dead-on freq is an insta-win, look for it only in 1st run
> +                */
> +               if (*exact_match) {
> +                       if (!(freq % desired_clk)) {
> +                               ser_clk = freq;
> +                               *clk_div = freq / desired_clk;
> +                               return ser_clk;
> +                       }
> +               }

The "*exact_match" if test isn't needed here. It's not saving you any
significant amount of time. You're still doing an "if" test, right?
...so you're basically saving a mod operation by adding a pointer
dereference and complexity? I don't think that's the right tradeoff.


> +               if (!ser_clk) {
> +                       new_div = DIV_ROUND_CLOSEST(freq, desired_clk);
> +                       new_freq = new_div * desired_clk;
> +                       offset = (new_freq * percent_tol) / 100;
> +
> +                       if (new_freq - offset <= freq && freq <= new_freq + offset) {
> +                               /* Save the first (lowest freq) within tolerance */
> +                               ser_clk = freq;
> +                               *clk_div = new_div;
> +                               /* no more search for exact match required in 2nd run */
> +                               if (!(*exact_match))
> +                                       break;
> +                       }
>                 }
>
> -               if (!prev)
> -                       ser_clk = freq;
> -               else if (prev == freq)
> +               div = freq / desired_clk + 1;
> +
> +               /*
> +                * Only time clock framework doesn't round up is if
> +                * we're past the max clock rate. We're done searching
> +                * if that's the case.
> +                */
> +               if (freq < test_freq)
>                         break;
> +       }
> +
> +       *exact_match = false;
> +       return ser_clk;
> +}
> +
> +static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> +                       unsigned int sampling_rate, unsigned int *clk_div)
> +{
> +       unsigned long ser_clk;
> +       unsigned long desired_clk;
> +       unsigned long desired_tol;
> +       bool exact_match;
>
> -               prev = freq;
> +       desired_clk = baud * sampling_rate;
> +       if (!desired_clk) {
> +               pr_err("%s: Invalid frequency\n", __func__);
> +               return 0;
>         }
>
> -       if (!ser_clk) {
> -               pr_err("%s: Can't find matching DFS entry for baud %d\n",
> -                                                               __func__, baud);
> +       /* try to find exact clock rate or within 2% tolerance */
> +       ser_clk = 0;
> +       exact_match = true;
> +       desired_tol = 2;

Don't need a "desired_tol" variable. Just pass 2 into the function.


> +       ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, desired_tol, &exact_match);
> +       if (ser_clk) {
> +               if (!exact_match)
> +                       pr_warn("Cannot find exact match clk_rate, using one within 2 percent tolerance\n");

IMO get rid of this printout. Just return what you found if it's not
0. It's perfectly fine. ...that means you can fully get rid of the
"exact_match" variable.


>                 return ser_clk;
>         }
>
> -       *clk_div = ser_clk / desired_clk;
> -       if (!(*clk_div))
> -               *clk_div = 1;
> +       /* try within 5% tolerance now, no need to look for exact match */
> +       exact_match = false;
> +       desired_tol = 5;
> +
> +       ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, desired_tol, &exact_match);
> +       if (ser_clk)
> +               pr_warn("Cannot find exact match clk_rate, using one within 5 percent tolerance\n");
> +       else
> +               pr_err("Cannot find suitable clk_rate, giving up\n");

Just keep the error message but not the warning. ...and ideally use
"dev_err" and print out the clock you were trying to achieve.
