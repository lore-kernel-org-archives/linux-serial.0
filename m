Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2928C43334
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jun 2022 23:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiFWXMH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiFWXMH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jun 2022 19:12:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C45D112
        for <linux-serial@vger.kernel.org>; Thu, 23 Jun 2022 16:12:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id pk21so1265587ejb.2
        for <linux-serial@vger.kernel.org>; Thu, 23 Jun 2022 16:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvH+WCwwww3y35Yzw/6cK3NiQ2zgYQbh9kzZY1PopZk=;
        b=BD0ba7qdsK1G6kW6CFHgWzYQlkQiSHnf6NLG7sdKUUT7Z3FC3EV2LHafLNV3wC5YLl
         Bz2I2ddgL1EQn08kTtDUYBcPq/EUBzB6tHRHqY+C/p6o55o4iHKXb4AD+C8WqypChmJu
         rHzf3OKW5dHOFzTTBqM45JTTxQ9XX+AOHYD/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvH+WCwwww3y35Yzw/6cK3NiQ2zgYQbh9kzZY1PopZk=;
        b=ijMr6QM5pw0Xu228QcHAkszI6Ve+PkhraAg7yG0ILiXKRWDN/MQrk7v8vyuGfGaFht
         ekgd1TSM1PN9+GOohUhppW7sgcP8/CWc+fxRG9P60YbwkfAkuA+BDxniDZ172BTMEmOx
         wu8CpArN0a9nVFRU1UJkNqAAQNjktJxl6q7IdFSf7ENfCaKLf0VjdMCWsN+2Pm58xFY9
         LZBQ1IWe375KrEVxZCa+XR0QUBHyjs1xjCHj0rjFoUQRLJVgVgOe1N0mEWZ0QDtUfDBd
         uDoUvdRnt+7IkN3QVVY/r5x3NhnIJcR7fmcubORWP+/HKESRYcZ+SV9Gb/jyMlv83xHy
         SCeQ==
X-Gm-Message-State: AJIora/+JAAkNcMYkyN7ISR0cz+bJoLW4FvWCh79y+VnvgQJAtkftGCx
        aqtc05gpt34BSnN3dWOsts0pl83INxgykmrv
X-Google-Smtp-Source: AGRyM1vpelqykEqN9/T8Nok2xD+YxVcbrPStQwVYS/4rMl8m4MIqHC997C3f70rp8OU88LNoxN4IMQ==
X-Received: by 2002:a17:907:60d2:b0:722:fd02:d71b with SMTP id hv18-20020a17090760d200b00722fd02d71bmr6782465ejc.249.1656025923835;
        Thu, 23 Jun 2022 16:12:03 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id i24-20020a170906251800b007262a1c8d20sm208248ejb.19.2022.06.23.16.12.02
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 16:12:02 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id s1so797370wra.9
        for <linux-serial@vger.kernel.org>; Thu, 23 Jun 2022 16:12:02 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr10771841wrr.617.1656025921466; Thu, 23
 Jun 2022 16:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com> <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com> <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
 <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com> <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
 <da18c508-f32e-fece-6392-e6a95f7c7968@quicinc.com> <CAD=FV=Wytm9EYu=4ndN+En2AFEgPK9NjrUMbFPA_h6TwyxGCYA@mail.gmail.com>
 <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com> <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
 <BL0PR02MB4564C633F46BBCC315D86322FAB39@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB4564C633F46BBCC315D86322FAB39@BL0PR02MB4564.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Jun 2022 16:11:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoqTeUg9mQLck-fwtFptSqn2eC1htmRkt_b-pih+wqug@mail.gmail.com>
Message-ID: <CAD=FV=XoqTeUg9mQLck-fwtFptSqn2eC1htmRkt_b-pih+wqug@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: minor fixes to get_clk_div_rate()
To:     "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>
Cc:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Jun 21, 2022 at 10:58 AM Vijaya Krishna Nivarthi (Temp)
<vnivarth@qti.qualcomm.com> wrote:
>
> Hi,
>
> For desired_clk = 100 and clock rates like 1st from below, DIV_ROUND_UP seems to cause missing candidate solutions.
>
> static unsigned long clk_round_rate_test(struct clk *clk, unsigned long in_freq)
> {
>         //unsigned long root_freq[] = {301, 702, 1004};
>         //unsigned long root_freq[] = {301, 702, 1004, 2000, 3000};
>         //unsigned long root_freq[] = {50, 97, 99};
>         //unsigned long root_freq[] = {50, 97, 99, 200};
>         //unsigned long root_freq[] = {92, 110, 193, 230};
>         //unsigned long root_freq[] = {92, 110, 193, 230, 300, 401};
>         //unsigned long root_freq[] = {92, 110, 193, 230, 295, 296, 297, 401};
>         //unsigned long root_freq[] = {92, 110, 193, 230, 295, 296, 297, 300, 401};
>         //unsigned long root_freq[] = {197, 198, 199};
>         unsigned long root_freq[] = {197, 198, 199, 200};
>         int i;
>         size_t n = sizeof root_freq / sizeof *root_freq;
>
>         for (i = 0; i < n; i++) {
>                 if (root_freq[i] >= in_freq)
>                         return root_freq[i];
>         }
>         return root_freq[n-1];
> }
>
> I modified to handle such cases, optimised little and uploaded a patch.
> It seems to work for all the cases like above.

I think it would have been simpler to just change this little section:

/* Save the first (lowest freq) within 2% */
actual_mult = DIV_ROUND_CLOSEST(freq, desired_clk) * desired_clk;
if (!ser_clk && freq <= actual_mult + two_percent) {
  ser_clk = freq;
  *clk_div = div;
}

That was the only bug, right? Then you could keep the DIV_ROUND_UP() solution?

-Doug
