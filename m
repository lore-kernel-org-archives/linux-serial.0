Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D220C43334
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 20:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiFFUAK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiFFUAA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 16:00:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E442A17
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 12:59:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gl15so17162289ejb.4
        for <linux-serial@vger.kernel.org>; Mon, 06 Jun 2022 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyBIlHlvNnNukF5G0n9+2AGCAoU99vx7TpccBzJvzGk=;
        b=Dh6hO/bbO4U7Wwjb0yjg8aPpKaeV3WtXIWRnsKFRLoP0wSC2DM18KCiugxyQqZJ10I
         pTVrCF0N8YsZZ4QCHy5byDFsKoikoMIiyGJrR/ZPKOaxg7Q6/8yEw3SvECCrOR2jPYW+
         G3qmInSfX+VJqatxbhHuEet40CcCHXPRZks0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyBIlHlvNnNukF5G0n9+2AGCAoU99vx7TpccBzJvzGk=;
        b=gFkR05QhNnTdavQ+dSAao0limKsyMMlKXMNQNg+5QnQR6FL678zJg7Utt5fNndcq4C
         jKWzFpLkwu/TafY0vPo7/Iks01osD2mB9rwI/7HEbNs+LhFSHkXl/VWYXpC0Tt4EBL1S
         S8JlPoYcJ7mk4Hzd76wgh7gwnYKezJaHpIdwvu8tYx8wrY1Oz8t96q5ry7w/TBeCzGMT
         VvQPPpIQgmADZnsS6uDjcS+EnQNoWmF+ejxJ9YQxmYgkcz7vSzVFA9HNevaujfb+9JoE
         g7qOlv7OiiIt8qZNS400r6DgCuZSHxtY4YTB/sJBcui0zzu8BDCSm/9QOB3rqKbDbomZ
         a2Hg==
X-Gm-Message-State: AOAM533fm8E+MAnWtWOZTFAnOVRopvrygHe9z6LfI5epan3gsE9a8JID
        BdM+s0NdQHeRIwffbJIHevRnbvEuDSjharo0V5Y=
X-Google-Smtp-Source: ABdhPJwtIYNPUn/jgPxL+32+Mz13K4W44IpqcdlvgeSKIdzM13gbTjipVwtmxhOlZ6GyLUcye4OiIA==
X-Received: by 2002:a17:906:dc89:b0:6f4:d3a9:34ed with SMTP id cs9-20020a170906dc8900b006f4d3a934edmr22865232ejc.459.1654545596836;
        Mon, 06 Jun 2022 12:59:56 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id u2-20020aa7d982000000b0042ab4e20543sm9050133eds.48.2022.06.06.12.59.55
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 12:59:56 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id t13so21243653wrg.9
        for <linux-serial@vger.kernel.org>; Mon, 06 Jun 2022 12:59:55 -0700 (PDT)
X-Received: by 2002:a05:6000:1685:b0:218:45f0:5be6 with SMTP id
 y5-20020a056000168500b0021845f05be6mr4306754wrd.301.1654545595132; Mon, 06
 Jun 2022 12:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com> <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com> <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
 <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com>
In-Reply-To: <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 12:59:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
Message-ID: <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
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

On Mon, Jun 6, 2022 at 11:19 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
>
> On 6/4/2022 12:10 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 3, 2022 at 10:43 AM Vijaya Krishna Nivarthi
> > <quic_vnivarth@quicinc.com> wrote:
> >>
> >> Ah, or I guess what you're saying is that the table historically
> >> contained "rounded" rates but that clk_round_rate() isn't returning
> >> nice round rates. OK, but if we truly want to support an inexact
> >> match, you'd want to pick the rate that reduces the error, not just
> >> pick the first one. In other words, something like this (untested):
> >>
> >> freq = clk_round_rate(clk, mult);
> >> diff = abs(((long)mult - freq) / div);
> >> if (diff < best_diff) {
> >>     best_diff = diff;
> >>     ser_clk = freq;
> >>     best_div = div;
> >> }
> >> I am not sure if its required that freq is a multiple of best_div now
> >> that we don't have a multiple of desired_clk anyway.
> > How about just this (untested):
> >
> > freq = clk_round_rate(clk, mult);
> > candidate_div = max(1, DIV_ROUND_CLOSEST(freq, desired_clk));
> > candidate_freq = freq / candidate_div;
> > diff = abs((long)desired_clk - candidate_freq);
> > if (diff < best_diff) {
> >    best_diff = diff;
> >    ser_clk = freq;
> >    best_div = candidate_div;
> > }
>
> I am afraid this still doesn't guarantee that ser_clk is a multiple of
> best_div

OK. ...I guess my question would be: does it matter for some reason?
"ser_clk" is just a local variable in this function. Who cares if it's
not a multiple of best_div? This is why we're keeping track of
"best_div" in the first place, so that later in the function instead
of:

*clk_div = ser_clk / desired_clk;
if (!(*clk_div))
  *clk_div = 1;

You just do:

*clk_div = best_div;


> I tested it with a function simulates clk_round_rate.
>
> static unsigned long clk_round_rate_test(struct clk *clk, unsigned long
> in_freq)
> {
>      unsigned long root_freq[6] = {105, 204, 303, 402, 501, 602};
>      int i;
>
>      for (i = 0; i < 6; i++) {
>          if (root_freq[i] >= in_freq)
>              return root_freq[i];
>      }
>      return root_freq[6];
> }
>
>      {
>          unsigned long ser_clk;
>          unsigned long desired_clk;
>          unsigned long freq;
>          int div_round_closest;
>          unsigned long div;
>          unsigned long mult;
>          unsigned long candidate_div, candidate_freq;
>
>          unsigned long diff, best_diff, best_div;
>          unsigned long one;
>
>          desired_clk = 100;
>          one = 1;
>          best_diff = ULONG_MAX;
>          pr_err("\ndesired_clk-%d\n", desired_clk);
>          for (div = 1; div <= 10; div++) {
>              mult = div * desired_clk;
>
>              freq = clk_round_rate_test(clk, mult);
>              div_round_closest = DIV_ROUND_CLOSEST(freq, desired_clk);
>              candidate_div = max(one, (unsigned long)div_round_closest);
>              candidate_freq = freq / candidate_div;
>              diff = abs((long)desired_clk - candidate_freq);
>              pr_err("div-%d, mult-%d, freq-%d, div_round_closest-%d,
> candidate_div-%d, candidate_freq-%d, diff-%d\n",
>                  div, mult, freq, div_round_closest, candidate_div,
> candidate_freq, diff);
>              if (diff < best_diff) {
>                  pr_err("This is best so far\n");
>                  best_diff = diff;
>                  ser_clk = freq;
>                  best_div = candidate_div;
>              }
>          }
>          pr_err("\nbest_diff-%d, ser_clk-%d, best_div-%d\n",
>              best_diff, ser_clk, best_div);
>      }
>
> And here is the output
>
> [   17.835167] desired_clk-100
> [   17.839567] div-1, mult-100, freq-105, div_round_closest-1,
> candidate_div-1, candidate_freq-105, diff-5
> [   17.849220] This is best so far
> [   17.852458] div-2, mult-200, freq-204, div_round_closest-2,
> candidate_div-2, candidate_freq-102, diff-2
> [   17.862104] This is best so far
> [   17.865345] div-3, mult-300, freq-303, div_round_closest-3,
> candidate_div-3, candidate_freq-101, diff-1
> [   17.874995] This is best so far
> [   17.878237] div-4, mult-400, freq-402, div_round_closest-4,
> candidate_div-4, candidate_freq-100, diff-0
> [   17.887882] This is best so far
> [   17.891118] div-5, mult-500, freq-501, div_round_closest-5,
> candidate_div-5, candidate_freq-100, diff-0
> [   17.900770] div-6, mult-600, freq-602, div_round_closest-6,
> candidate_div-6, candidate_freq-100, diff-0
> [   17.910415] div-7, mult-700, freq-602, div_round_closest-6,
> candidate_div-6, candidate_freq-100, diff-0
> [   17.920057] div-8, mult-800, freq-602, div_round_closest-6,
> candidate_div-6, candidate_freq-100, diff-0
> [   17.929703] div-9, mult-900, freq-602, div_round_closest-6,
> candidate_div-6, candidate_freq-100, diff-0
> [   17.939353] div-10, mult-1000, freq-602, div_round_closest-6,
> candidate_div-6, candidate_freq-100, diff-0
> [   17.949181]
> [   17.949181] best_diff-0, ser_clk-402, best_div-4

That doesn't look like a terrible result. I guess nominally 602 is a
better approximation, but if we're accepting that we're not going to
have an exact rate anyway then maybe being off by that tiny amount
doesn't matter and we'd do better with the slow clock (maybe saves
power?)


> Please note that we go past cases when we have an divider that can
> exactly divide the frequency(105/1, 204/2, 303/3) and end up with one
> that doesn't.

Ah, good point. Luckily that's a 1-line fix, right?


-Doug
