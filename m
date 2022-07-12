Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E690BC43334
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 14:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiGLOLi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiGLOLg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 10:11:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC333E28
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 07:11:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v12so10244513edc.10
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBU84SRNLc6JB1Nu5oUhv+2JH/yb6vYKX7qMUKcEA/U=;
        b=HVDAKTb8QU6+A5APYQt524idn27AtAFUkPxSl1zqDjminGIQq8VZ28WSHeIeH1cYmp
         Zei6wL2/JJOlPrXH3YXdM3QmDxLvPhupy9vKx8veZjVLJp8/pHA6FccBbfFHGzMPlpWK
         5LoNik9uVHiE432REpBpgVr3ox45JYIthlEMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBU84SRNLc6JB1Nu5oUhv+2JH/yb6vYKX7qMUKcEA/U=;
        b=O+F9vCrb7pUGpfLXt64sm2zB7Qv75NKa/11IYH3XlVO+PnyzDerOl+VhJOd2JwfyhY
         V8uGcNAtE4740DfiA4+P+f4hJNyH0X/7+rtLNh9d5X4Wln4lcdY35bfcl+/IoVsTn2HA
         zwef8giCHzJCqvOK1GS4qt7jo8iQIr+jQqYYBBVXaE6JB5sCAihRPJ3Qk6IOcIZT9Fo6
         W5XNfBd+YBDmIJ6UcZHIEPniuzVWtibeUzm6hqeUc8i+sxeoh0dYZuS80B9EfCPNaRJd
         22foVVz1pdm/cQpRkzrV3B2Yems6yOWEisATLZs8Ge3nP2jOeaLYx5qu5Rt2xHb52Yf2
         lx5A==
X-Gm-Message-State: AJIora+byFdhak/5jtmpFl1VX8GfkpENdHCppRcB+PSY2XcUbslC5TbG
        9XKatC67EqGLjrWvVqsWFB6fTxRWlPPeDI2D0i0=
X-Google-Smtp-Source: AGRyM1tJ3vi8EtJ59PqmRt4FKCR/6D0uMfM6zqR/tiLn3Ll55pGNSd58r9HuG8g0zRR6M/F85nBiXQ==
X-Received: by 2002:a05:6402:448c:b0:435:9dcc:b8a5 with SMTP id er12-20020a056402448c00b004359dccb8a5mr32001472edb.287.1657635092180;
        Tue, 12 Jul 2022 07:11:32 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id qx15-20020a170906fccf00b0072b1bc9b37fsm3826167ejb.22.2022.07.12.07.11.31
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 07:11:31 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id l42so4727693wms.5
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 07:11:31 -0700 (PDT)
X-Received: by 2002:a05:600c:285:b0:3a2:e5fd:84eb with SMTP id
 5-20020a05600c028500b003a2e5fd84ebmr4162603wmk.151.1657635090577; Tue, 12 Jul
 2022 07:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <1657629905-24685-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1657629905-24685-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Jul 2022 07:11:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XGivNzu_e5nrgOYkkqpWdXGgyG2MjB9xRbXm_V3JyPsw@mail.gmail.com>
Message-ID: <CAD=FV=XGivNzu_e5nrgOYkkqpWdXGgyG2MjB9xRbXm_V3JyPsw@mail.gmail.com>
Subject: Re: [V5] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
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

On Tue, Jul 12, 2022 at 5:45 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> In the logic around call to clk_round_rate(), for some corner conditions,
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
> v5: corrected format specifiers for logs
> v4: replaced pr_dbg calls with dev_dbg
> v3: simplified algorithm further, fixed robot compile warnings
> v2: removed minor optimisations to make more readable
> v1: intial patch contained slightly complicated logic
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 89 +++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 35 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
