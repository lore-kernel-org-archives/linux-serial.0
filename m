Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F18C43334
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 22:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiFHWh7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbiFHWh4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 18:37:56 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744E24CC9F
        for <linux-serial@vger.kernel.org>; Wed,  8 Jun 2022 15:37:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n11so572407iod.4
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 15:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TT6Vjknzkwt5ysDSpzsCMciL0Vv047NuW2ZsFO/n/E=;
        b=i/R4bTz8KBrI++HgQG8bEPv8MSsCYGOUziadxtC+agF5xyIZ+g2iKP5eHHMggWAZ9S
         +3szPG7NliBo665Bvl0ReN3HoqngQGy6W9BZcJEcJmse18WhwWgsREqY+I8KqDEtZcMg
         252GC0PBxHU9CIPvuzKC2/r5gLK6AGzBUPeP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TT6Vjknzkwt5ysDSpzsCMciL0Vv047NuW2ZsFO/n/E=;
        b=GWpGFMueYPw5p4OIQuTRGeR8HS5+AOi4QyxryFH4naiyHkSZClp+nGnZdT3cQcLGFD
         85JVnaLtm0+RzYYK9mKat1GOeQv4o/SfEQY4zWJqJgujgLVPVZqGBfM0uHp+S1ZKHc/a
         N9OlU9baSK1Ov7Jr/EXDQvusGTlAXwFnok1Q2Xy540i4aSpS8/KgG4XWnzxvVFDcRbYU
         DZfopN/G0uCgPlr3cLDphCjvJ9Dj7zVZsABOaqCG2CShnyUB9a+FlNkMWS6zYtZDXiD3
         aFSCKLqPnbCFDS9Kr6S7XLxuuwsr4r8iGXmISyHS7scwW5A3FJYDCM2QlIbbr70NUPUU
         o7aA==
X-Gm-Message-State: AOAM5313LkVDTTpVv+FALHxptuOWjoK+YaM2ZEVIzanKTx7WBfoXnmyR
        Y+pYIBR6oBiyn5Y1W1R3Pq6XT63+wiU3hRkI
X-Google-Smtp-Source: ABdhPJzvd0QnxLVAEKXO/DNB2K1qwGC7nvPDfMz06ugnIC8ri28Euux2oqexUUXmArGc7OdwyxyKEA==
X-Received: by 2002:a05:6638:14cd:b0:331:d9b3:fa47 with SMTP id l13-20020a05663814cd00b00331d9b3fa47mr4735453jak.303.1654727872807;
        Wed, 08 Jun 2022 15:37:52 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id i12-20020a02ca0c000000b0032e7d0a79basm8560104jak.158.2022.06.08.15.37.51
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 15:37:51 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id i16so739802ioa.6
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 15:37:51 -0700 (PDT)
X-Received: by 2002:a02:c012:0:b0:331:67b8:3d7e with SMTP id
 y18-20020a02c012000000b0033167b83d7emr18129289jai.244.1654727871122; Wed, 08
 Jun 2022 15:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com> <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com> <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
 <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com> <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
 <da18c508-f32e-fece-6392-e6a95f7c7968@quicinc.com> <CAD=FV=Wytm9EYu=4ndN+En2AFEgPK9NjrUMbFPA_h6TwyxGCYA@mail.gmail.com>
 <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com>
In-Reply-To: <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jun 2022 15:37:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
Message-ID: <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: minor fixes to get_clk_div_rate()
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, Jun 8, 2022 at 11:34 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
>
> On 6/8/2022 12:55 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jun 7, 2022 at 10:40 AM Vijaya Krishna Nivarthi
> > <quic_vnivarth@quicinc.com> wrote:
> >> Hi,
> >>
> >> On 6/7/2022 1:29 AM, Doug Anderson wrote:
> >>
> >> My only concern continues to be...
> >>
> >> Given ser_clk is the final frequency that this function is going to
> >> return and best_div is going to be the clk_divider, is it ok if the
> >> divider cant divide the frequency exactly?
> >>
> >> In other words, Can this function output combinations like (402,4)
> >> (501,5) ?
> >>
> >> If ok, then we can go ahead with this patch or even previous perhaps.
> > I don't see why not. You're basically just getting a resulting clock
> > that's not an integral "Hz", right?
> >
> > So if "baud" is 9600 and sampling_rate is 16 then desired_clk is (9600
> > * 16) = 153600
> >
> > Let's imagine that we do all the math and we finally decide that our
> > best bet is with the rate 922000 and a divider of 6. That means that
> > the actual clock we'll make is 153666.67 when we _wanted_ 153600.
> > There's no reason it needs to be integral, though, and 153666.67 would
> > still be better than making 160000.
> >
> Thank you for clarification.
> >>> power?)
> >> Actually power saving was the anticipation behind returning first
> >> frequency in original patch, when we cant find exact frequency.
> > Right, except that if you just pick the first clock you find it would
> > be _wildly_ off. I guess if you really want to do this the right way,
> > you need to set a maximum tolerance and pick the first rate you find
> > that meets that tolerance. Random web search for "uart baud rate
> > tolerance" makes me believe that +/- 5% deviation is OK, but to be
> > safe you probably want something lower. Maybe 2%? So if the desired
> > clock is within 2% of a clock you can make, can you just pick that
> > one?
> Ok, 2% seems good.
> >
> >>>> Please note that we go past cases when we have an divider that can
> >>>> exactly divide the frequency(105/1, 204/2, 303/3) and end up with one
> >>>> that doesn't.
> >>> Ah, good point. Luckily that's a 1-line fix, right?
> >> Apologies, I could not figure out how.
> > Ah, sorry. Not quite 1 line, but this (untested)
> >
> >
> > freq = clk_round_rate(clk, mult);
> >
> > if (freq % desired_clk == 0) {
> >   ser_clk = freq;
> >   best_div = freq / desired_clk;
> >   break;
> > }
> >
> > candidate_div = max(1, DIV_ROUND_CLOSEST(freq, desired_clk));
> > candidate_freq = freq / candidate_div;
> > diff = abs((long)desired_clk - candidate_freq);
> > if (diff < best_diff) {
> >    best_diff = diff;
> >    ser_clk = freq;
> >    best_div = candidate_div;
> > }
>
> But then once again, we would likely need 2 loops because while we are
> ok with giving up on search for best_div on finding something within 2%
> tolerance, we may not want to give up on exact match (freq % desired_clk
> == 0 )

Ah, it took me a while to understand why two loops. It's because in
one case you're trying multiplies and in the other you're bumping up
to the next closest clock rate. I don't think you really need to do
that. Just test the (rate - 2%) and the rate. How about this (only
lightly tested):

    ser_clk = 0;
    maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
    div = 1;
    while (div < maxdiv) {
        mult = (unsigned long long)div * desired_clk;
        if (mult != (unsigned long)mult)
            break;

        two_percent = mult / 50;

        /*
         * Loop requesting (freq - 2%) and possibly (freq).
         *
         * We'll keep track of the lowest freq inexact match we found
         * but always try to find a perfect match. NOTE: this algorithm
         * could miss a slightly better freq if there's more than one
         * freq between (freq - 2%) and (freq) but (freq) can't be made
         * exactly, but that's OK.
         *
         * This absolutely relies on the fact that the Qualcomm clock
         * driver always rounds up.
         */
        test_freq = mult - two_percent;
        while (test_freq <= mult) {
            freq = clk_round_rate(clk, test_freq);

            /*
             * A dead-on freq is an insta-win. This implicitly
             * handles when "freq == mult"
             */
            if (!(freq % desired_clk)) {
                *clk_div = freq / desired_clk;
                return freq;
            }

            /*
             * Only time clock framework doesn't round up is if
             * we're past the max clock rate. We're done searching
             * if that's the case.
             */
            if (freq < test_freq)
                return ser_clk;

            /* Save the first (lowest freq) within 2% */
            if (!ser_clk && freq <= mult + two_percent) {
                ser_clk = freq;
                *clk_div = div;
            }

            /*
             * If we already rounded up past mult then this will
             * cause the loop to exit. If not then this will run
             * the loop a second time with exactly mult.
             */
            test_freq = max(freq + 1, mult);
        }

        /*
         * test_freq will always be bigger than mult by at least 1.
         * That means we can get the next divider with a DIV_ROUND_UP.
         * This has the advantage of skipping by a whole bunch of divs
         * If the clock framework already bypassed them.
         */
        div = DIV_ROUND_UP(test_freq, desired_clk);
        }

    return ser_clk;
