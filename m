Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0BAC4332E
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E4220739
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 16:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZGRQRHVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCTQqR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:46:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38872 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgCTQqQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 12:46:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so7140239ljh.5
        for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2020 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVeMWWgOR9TOsajWbE931ud3emvQ0ziFK5hlBW9OADE=;
        b=ZGRQRHVYCzH20glp+CuGONYp6DfLbf36SiaLFRCofD+cDdIUlqDIJFyII0gsPvuBtO
         hCqPw+nLaQvXF1wEZLoYIPhwNfGVkUUZtXGg05RoKCrMYcQutWHg+7zLOZ3+BSB+QIvY
         EV93/VSdJajMFJqONuXGVgXN27wm7h3uUh4yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVeMWWgOR9TOsajWbE931ud3emvQ0ziFK5hlBW9OADE=;
        b=PsBCCEyKDtRjH2hmaRJ0EaMVFwhXqvUL0+lTAM1bMAykvb8509uwqxHxpeRPZAD0pm
         kN+O2nehKYJQSlEfWL26Y32HU+/xfmdqp0NgBUHHfdf7zkXQh4Y05W/UR1NgPYB05rpy
         ar+Oa0NE6R1bCJAfArU6pu41CXD/EyBqO1y4wGCnOjC0J75LLiDt7ZqhD2Fd5G/WBYqG
         v6G8QungB2EbrbYdlwgfpAImKwrh7qwtH7eyOyKZ938vh5q1vX/pmQUSk8P6jvHFvSvr
         NRj+vr6biZil7smdSmUYgZG1OkcsybGrP7QhnDNnmka3ErMZp+dDqgOxtqNApQehcrKb
         C5BA==
X-Gm-Message-State: ANhLgQ1W/EVi0or5JXrL/HKzOt+RTbLrqMAC04WlbGOnCHu5W8ooAAQz
        ng+w+vIrcDMDFplGPouzw56UJOXZ4zQ=
X-Google-Smtp-Source: ADFU+vuvhIx6fCKG57gXMILRHoiXEimofLgpAnLdLZyzmhNBs11FhAZKn9rYBvBH+Pr2G5+D9zx9mA==
X-Received: by 2002:a05:651c:1034:: with SMTP id w20mr6064279ljm.14.1584722772198;
        Fri, 20 Mar 2020 09:46:12 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b193sm962456lfd.74.2020.03.20.09.46.10
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 09:46:11 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q19so7106672ljp.9
        for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2020 09:46:10 -0700 (PDT)
X-Received: by 2002:a2e:2206:: with SMTP id i6mr5969667lji.208.1584722770463;
 Fri, 20 Mar 2020 09:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-3-git-send-email-akashast@codeaurora.org>
 <CAE=gft4_Su4+SXWAW_HWy5BF1mH7QaDHCiwAAhrNaekTeU57rA@mail.gmail.com> <74851dda-296d-cdc5-2449-b9ec59bbc057@codeaurora.org>
In-Reply-To: <74851dda-296d-cdc5-2449-b9ec59bbc057@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 20 Mar 2020 09:45:34 -0700
X-Gmail-Original-Message-ID: <CAE=gft5Uucr83DoQqaE7_8_H=ExnkPBQvRiUK_+LxOMeadam_g@mail.gmail.com>
Message-ID: <CAE=gft5Uucr83DoQqaE7_8_H=ExnkPBQvRiUK_+LxOMeadam_g@mail.gmail.com>
Subject: Re: [PATCH V2 2/8] soc: qcom: geni: Support for ICC voting
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wsa@the-dreams.de, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 20, 2020 at 4:03 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Hi Evan,
>
> +/* Core 2X clock frequency to BCM threshold mapping */
> +#define CORE_2X_19_2_MHZ               960
> +#define CORE_2X_50_MHZ                 2500
> +#define CORE_2X_100_MHZ                        5000
> +#define CORE_2X_150_MHZ                        7500
> +#define CORE_2X_200_MHZ                        10000
> +#define CORE_2X_236_MHZ                        16383
>
> These are all just 50 * clock_rate. Can you instead specify that one
> define of CLK_TO_BW_RATIO 50, and then use clk_get_rate() to get the
> input clock frequency. That way, if these end up getting clocked at a
> different rate, the bandwidth also scales appropriately. Also, can you
> enumerate why 50 is an appropriate ratio?
> -Evan
>
> -Evan
>
> Clock rate for Core 2X is controlled by BW voting only, we don't set clock rate for core 2X clock either by DFS or calling clk_set_rate API like we do for SE clocks from individual driver.
>
> In DT node it's not mentioned as clock.
>
> As discussed in patch@ https://patchwork.kernel.org/patch/11436897/  We are not scaling Core 2X clock based on dynamic need of driver instead we are putting recommended value from HW team for each driver.

Oh I get it. This is pretty opaque, since this table is saying "here
are the bandwidth values that happen to work out to a Core2X clock
rate of N". But it's not obvious why setting the Core2X clock rate to
N is desirable or appropriate. The answer seems to be hardware guys
told us these thresholds work well in practice. And if I'm reading
into it more, probably they're saying these bandwidths are too low to
be worth dynamically managing beyond on/off.

At the very least we should explain some of this in the comment above
these defines. Something like:
/* Define bandwidth thresholds that cause the underlying Core 2X
interconnect clock to run at the named frequency. These baseline
values are recommended by the hardware team, and are not dynamically
scaled with GENI bandwidth beyond basic on/off. */
-Evan
