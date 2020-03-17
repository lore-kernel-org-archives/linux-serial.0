Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6733C1975A
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 19:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4720714
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 19:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WBBI5+Fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQTQH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:16:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45727 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCQTQH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 15:16:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id h62so27943346edd.12
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2020 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HslPcJIo3S/gfJwOLWKAp+bbJPCMegwoA4gAtpRTBpw=;
        b=WBBI5+Fk6wbTGUQap4Fu6dRsazuD8ff8Gu5e+6AmXv7XDo742Zy9lrXGtOEjOpQ/7s
         Cip6Ty0dP3Ku+FzFfqT1DYN7Wr/tDh0ULC5Me0NCdG0TvwtkKB+CXrk5SN4IYPafjx2N
         fbbtkOKGR7y/cFKVvyGFODV5onhx7IGXNfDCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HslPcJIo3S/gfJwOLWKAp+bbJPCMegwoA4gAtpRTBpw=;
        b=uE6js/17dxtGO322YeoUB2zYMKU2Qiq5TIRySbIc6uFnURp3rQLJwq/d6LFcMfprfg
         1WgUgHsQ0hvW86W3Eoh0qgWgrADGjNsFTk+5MYBx+dzN7tES0M8sVaeCo24CuxHz1D91
         ZHrGTHS3EfH9kHF5SCVsfnGRrMWABW+671FR42Gtko8CgWuk9xW/s8KqfF9vZollT92h
         cs3hauD0XC/nPURGP7BOlLD//eWDa/1eyi9XpCRs/vDy3BWF5RktylNLgTeD7ZCRdJYY
         elwff01cTWhFppPisMQRNGqGJDPNAVnq2NEdguzlfpNZ1Xjre2KJfbl2HZeyZWJoyJIj
         8nDw==
X-Gm-Message-State: ANhLgQ1XAvRBCONNmBIFPa3lqrqR+qSM74spCD0VdLKsrWudkOCHemfC
        yXeFd8D31FLRMiE/hlVfAfJAHhlU3Z0=
X-Google-Smtp-Source: ADFU+vuPxRKK1Vd3Ms5z6r77auvRFiG0WWNpE747mShL3ix4KG84Uf1v797NE6j/rvwL0h5Y9xtR+w==
X-Received: by 2002:a05:6402:4d:: with SMTP id f13mr191721edu.382.1584472564898;
        Tue, 17 Mar 2020 12:16:04 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id dc18sm276660edb.20.2020.03.17.12.16.04
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 12:16:04 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id b23so27993858edx.4
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2020 12:16:04 -0700 (PDT)
X-Received: by 2002:a19:ec08:: with SMTP id b8mr536794lfa.34.1584472174941;
 Tue, 17 Mar 2020 12:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-8-git-send-email-akashast@codeaurora.org>
 <20200314005817.GN144492@google.com> <3aeb3083-2a31-b269-510d-eb608ff14ce5@codeaurora.org>
In-Reply-To: <3aeb3083-2a31-b269-510d-eb608ff14ce5@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 17 Mar 2020 12:08:56 -0700
X-Gmail-Original-Message-ID: <CAE=gft58QsgTCUHMHKJhcM9ZxAeMiY16CrbNv2HaTCRqwtmt7A@mail.gmail.com>
Message-ID: <CAE=gft58QsgTCUHMHKJhcM9ZxAeMiY16CrbNv2HaTCRqwtmt7A@mail.gmail.com>
Subject: Re: [PATCH V2 7/8] spi: spi-qcom-qspi: Add interconnect support
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        linux-serial@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 17, 2020 at 5:13 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Hi Matthias,
>
> On 3/14/2020 6:28 AM, Matthias Kaehlcke wrote:
> > Hi,
> >
> > On Fri, Mar 13, 2020 at 06:42:13PM +0530, Akash Asthana wrote:
> >> Get the interconnect paths for QSPI device and vote according to the
> >> current bus speed of the driver.
> >>
> >> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> >> ---
> >>   - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
> >>     path handle
> >>   - As per Matthias comment, added error handling for icc_set_bw call
> >>
> >>   drivers/spi/spi-qcom-qspi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 45 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> >> index 3c4f83b..ad48f43 100644
> >> --- a/drivers/spi/spi-qcom-qspi.c
> >> +++ b/drivers/spi/spi-qcom-qspi.c
> >> @@ -2,6 +2,7 @@
> >>   // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> >>
> >>   #include <linux/clk.h>
> >> +#include <linux/interconnect.h>
> >>   #include <linux/interrupt.h>
> >>   #include <linux/io.h>
> >>   #include <linux/module.h>
> >> @@ -139,7 +140,10 @@ struct qcom_qspi {
> >>      struct device *dev;
> >>      struct clk_bulk_data *clks;
> >>      struct qspi_xfer xfer;
> >> -    /* Lock to protect xfer and IRQ accessed registers */
> >> +    struct icc_path *icc_path_cpu_to_qspi;
> >> +    unsigned int avg_bw_cpu;
> >> +    unsigned int peak_bw_cpu;
> > This triplet is a recurring pattern, and is probably not limited to geni SE/QSPI.
> > On https://patchwork.kernel.org/patch/11436889/#23221925 I suggested the creation
> > of a geni SE specific struct, however adding a generic convenience struct to
> > 'linux/interconnect.h' might be the better solution:
> >
> > struct icc_client {
> >       struct icc_path *path;
> >       unsigned int avg_bw;
> >       unsigned int peak_bw;
> > };
> >
> > I'm sure there are better names for it, but this would be the idea.
>
> Yeah, I think introducing this to ICC header would be better solution.

+Georgi

I'm not as convinced this structure is generally useful and belongs in
the interconnect core. The thing that strikes me as weird with putting
it in the core is now we're saving these values both inside and
outside the interconnect core. In the GENI case here, we only really
need them to undo the 0 votes we cast during suspend. If "vote for 0
in suspend and whatever it was before at resume" is a recurring theme,
maybe the core should give us path_disable() and path_enable() calls
instead. I'm thinking out loud, maybe Georgi has some thoughts.

Akash, for now if you want to avoid wading into a larger discussion
maybe just refactor to a common structure local to GENI.


-Evan
