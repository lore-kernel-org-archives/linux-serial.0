Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A7FC433FE
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 19:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347277AbiEaT2e (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346136AbiEaT2d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 15:28:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930688B0A3
        for <linux-serial@vger.kernel.org>; Tue, 31 May 2022 12:28:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jx22so28514327ejb.12
        for <linux-serial@vger.kernel.org>; Tue, 31 May 2022 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DT1x8TLoaq/2aEcPF9yc25Y7gGZNqIa6OPt/9Mp+d6o=;
        b=BiTqHH1d77R6l5gMjMmYdehih1O7opPVsJ7Bxq1gsyya6CNRYUxnRfdBuxqKfhTYsl
         klBq6jkA3GcAFjfn6zFUPB498xdOb+BcTXdqB16WnfohHNUgW+VWqEcwI38+iWz0NMmI
         ZHnUUOR6xk/3/RA0uAmjbBjTzDu9DxmI5j4SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DT1x8TLoaq/2aEcPF9yc25Y7gGZNqIa6OPt/9Mp+d6o=;
        b=kQt94PMS4B69X/cV9GakvqRU1LbU6BkdJEkt3h2o7/HlwK1PAbO2Sv6zGf0cqzIFyU
         LX+9LfTxlN9gosLcR/KDULEzvz1sxJwYiTUPdOR0hfyEJf1vxzVzHXS9GIAcADhL2Lyo
         SLVAHvJZtaDXLEGnbPcE4TK/f7gimAh5p7LpBFRgGK1hNPyWoxkFOrr4ZoHzMZ9mlXCe
         DSSW0IcxIkE17slqQBKXFLZLQuiK+dc3eXfUrhK30H4i/G4VVyn+jJs7Si0h4TSZ1sqr
         5jIgLQjodIVz2lRLPY3XwbsKnYtf+WQpyKboAN/8OoCZ78OIUt7pXfg+JOI1W8AeGG+m
         QoEA==
X-Gm-Message-State: AOAM530cOEDNLyscVophgD/6pW+SekzEKlxnqz2g7YU9xwUloOrdwNmd
        PSAmRnyIViyhKlyIYSm/b7TcW54W3EpaWQ==
X-Google-Smtp-Source: ABdhPJzlMExxZO0inYSwcEBKCCc9kHV7m8nBKFpC18Q7bMfPx8ZkRlEk4KHuiNENpqxC1SHclWjcKw==
X-Received: by 2002:a17:906:99c3:b0:6ff:1254:7227 with SMTP id s3-20020a17090699c300b006ff12547227mr28487926ejn.692.1654025310897;
        Tue, 31 May 2022 12:28:30 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906828500b006fec8e5b8a9sm5247453ejx.152.2022.05.31.12.28.28
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 12:28:29 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id h5so11897477wrb.0
        for <linux-serial@vger.kernel.org>; Tue, 31 May 2022 12:28:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr41530977wry.513.1654025308057; Tue, 31
 May 2022 12:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 31 May 2022 12:28:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
Message-ID: <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
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

On Tue, May 31, 2022 at 11:18 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Add missing initialisation and correct type casting
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 4733a23..08f3ad4 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -943,11 +943,11 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>  static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>                         unsigned int sampling_rate, unsigned int *clk_div)
>  {
> -       unsigned long ser_clk;
> +       unsigned long ser_clk = 0;

In this patch it's not at all obvious why you'd need to init to 0. I
think the "for loop" is guaranteed to run at least once because
"max_div" is known at compile time. ...and currently each time through
the "for" loop you'll always set "ser_clk".

I think in a future patch you'll want to _remove_ this from the for loop:

if (!prev)
  ser_clk = freq;

...and _that's_ when you should init "ser_clk" to 0. Until then I'd
leave it as uninitialized...

Honestly, I'd throw all the fixes into one series, too.


>         unsigned long desired_clk;
>         unsigned long freq, prev;
>         unsigned long div, maxdiv;
> -       int64_t mult;
> +       unsigned long long mult;
>
>         desired_clk = baud * sampling_rate;
>         if (!desired_clk) {
> @@ -959,8 +959,8 @@ static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>         prev = 0;
>
>         for (div = 1; div <= maxdiv; div++) {
> -               mult = div * desired_clk;
> -               if (mult > ULONG_MAX)
> +               mult = (unsigned long long)div * (unsigned long long)desired_clk;

I think you only need to cast one of the two. The other will be
up-cast automatically.


> +               if (mult > (unsigned long long)ULONG_MAX)

I don't think you need this cast. As far as I know the C language will
"upcast" to the larger of the two types.


-Doug
