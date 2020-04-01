Return-Path: <SRS0=XHY+=5R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F248FC43331
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981EF2166E
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mY6lhPu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbgDAQ04 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:26:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36714 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733168AbgDAQ0y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Apr 2020 12:26:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id b1so125501ljp.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2020 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlnGKqC/ksqt7PwOjXqDO3WpjQwi8cgdWrR0LC5/SsA=;
        b=mY6lhPu6r3dtFh6Z65KXh5PfV4ehb6xbJ/qhRAI3rZHpLXxCY+F5t37DelqrPtp7D7
         5IkwQcVghOeDbcTvjkKoVhALKtuwX4xrB2cf8+b8ZNiPjczg7fw8D7O6W8V13iFcQhUp
         kx9C8oIn5wkZsimqa74YxFDF+Id7c35GhJrr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlnGKqC/ksqt7PwOjXqDO3WpjQwi8cgdWrR0LC5/SsA=;
        b=AVSgToBd1ZBSJoJyXDaUPv+O994NJmhwbzRSANrY7cjz7SHT/gqmkZ6kwSjjBf34an
         MgKiRhCfoL00tssTav3bSweslMVANEvjez2lQRJZGR7+na56ZAKczDu4RN95uXj5fAiu
         nubctcirkzDBNlAuQnBk6w1jtKcm2vXWK12GRM0o9emXdrxBFD9/xPpQbe1uWCx3fTek
         CHo2QudRFoRBQOcIaVK93WcQMZHsb2Kxp2YRFzivYNGgSsSsk4eJs6qrSBVuZ8AahOor
         flqetIWF35+MUOpjz3pStxCnh0CBelN5V/Y4K5j/43s8ji8fmrFXy7hxjKxwZs3hzINK
         D0yA==
X-Gm-Message-State: AGi0PuZlmL2wI1VlmcQKtiPQVQdZKv1mVXXcyCHdHKhQZx5wpHFB7HGs
        xo8dmbNntHwvDOsTgOtvg8b2Pg3lZmM=
X-Google-Smtp-Source: APiQypLVBeY/+Gh2WKju567nm5vMV9zrPim8sAVWmr460FHS98gOE/2YXsfljHf3G/UQVKSMYw73+g==
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr13102701ljo.198.1585758412875;
        Wed, 01 Apr 2020 09:26:52 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 24sm1471030ljv.105.2020.04.01.09.26.52
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 09:26:52 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id r24so116761ljd.4
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2020 09:26:52 -0700 (PDT)
X-Received: by 2002:a2e:9d83:: with SMTP id c3mr13562274ljj.3.1585758411425;
 Wed, 01 Apr 2020 09:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-3-git-send-email-akashast@codeaurora.org> <20200331233209.GF254911@minitux>
In-Reply-To: <20200331233209.GF254911@minitux>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 1 Apr 2020 09:26:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft6B2UCBVaKVCJXED8waFWci8WJ+sTM3CT+3e_eYS=-BDQ@mail.gmail.com>
Message-ID: <CAE=gft6B2UCBVaKVCJXED8waFWci8WJ+sTM3CT+3e_eYS=-BDQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/8] soc: qcom: geni: Support for ICC voting
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Akash Asthana <akashast@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>, wsa@the-dreams.de,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
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

On Tue, Mar 31, 2020 at 4:32 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 31 Mar 04:09 PDT 2020, Akash Asthana wrote:
>
> > Add necessary macros and structure variables to support ICC BW
> > voting from individual SE drivers.
> >
> > Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> > ---
> > Changes in V2:
> >  - As per Bjorn's comment dropped enums for ICC paths, given the three
> >    paths individual members
> >
> > Changes in V3:
> >  - Add geni_icc_get, geni_icc_vote_on and geni_icc_vote_off as helper API.
> >  - Add geni_icc_path structure in common header
> >
> >  drivers/soc/qcom/qcom-geni-se.c | 98 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/qcom-geni-se.h    | 36 +++++++++++++++
> >  2 files changed, 134 insertions(+)
> >
> > diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> > index 7d622ea..9344c14 100644
> > --- a/drivers/soc/qcom/qcom-geni-se.c
> > +++ b/drivers/soc/qcom/qcom-geni-se.c
> > @@ -720,6 +720,104 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
> >  }
> >  EXPORT_SYMBOL(geni_se_rx_dma_unprep);
> >
> > +int geni_icc_get(struct geni_se *se, const char *icc_core, const char *icc_cpu,
> > +             const char *icc_ddr)
> > +{
> > +     if (icc_core) {
>
> Afaict it's only this that might be passed as NULL, so please drop these
> conditionals (keep the last one).
>
> > +             se->to_core.path = devm_of_icc_get(se->dev, "qup-core");
> > +             if (IS_ERR(se->to_core.path))
>
> It would be useful to print an error message here (if PTR_ERR(path) !=
> -EPROBE_DEFER).
>
> > +                     return PTR_ERR(se->to_core.path);
> > +     }
> > +
> > +     if (icc_cpu) {
> > +             se->from_cpu.path = devm_of_icc_get(se->dev, "qup-config");
> > +             if (IS_ERR(se->from_cpu.path))
> > +                     return PTR_ERR(se->from_cpu.path);
> > +     }
> > +
> > +     if (icc_ddr) {
> > +             se->to_ddr.path = devm_of_icc_get(se->dev, "qup-memory");
> > +             if (IS_ERR(se->to_ddr.path))
> > +                     return PTR_ERR(se->to_ddr.path);
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(geni_icc_get);
> > +
> > +int geni_icc_vote_on(struct geni_se *se)
> > +{
> > +     int ret;
> > +
> > +     if (se->to_core.path) {
>
> icc_set_bw(NULL, ...) is valid and will return 0, so these checks
> doesn't add any value.
>
> > +             ret = icc_set_bw(se->to_core.path, se->to_core.avg_bw,
> > +                     se->to_core.peak_bw);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for core\n",
> > +                                             __func__);
>
> Please drop the __func__, the message is specific enough.
>
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (se->from_cpu.path) {
> > +             ret = icc_set_bw(se->from_cpu.path, se->from_cpu.avg_bw,
> > +                     se->from_cpu.peak_bw);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for cpu\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (se->to_ddr.path) {
> > +             ret = icc_set_bw(se->to_ddr.path, se->to_ddr.avg_bw,
> > +                     se->to_ddr.peak_bw);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for ddr\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(geni_icc_vote_on);
> > +
> > +int geni_icc_vote_off(struct geni_se *se)
> > +{
> > +     int ret;
> > +
> > +     if (se->to_core.path) {
> > +             ret = icc_set_bw(se->to_core.path, 0, 0);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for core\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (se->from_cpu.path) {
> > +             ret = icc_set_bw(se->from_cpu.path, 0, 0);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for cpu\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (se->to_ddr.path) {
> > +             ret = icc_set_bw(se->to_ddr.path, 0, 0);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for ddr\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(geni_icc_vote_off);
>
> Given that these two functions only switch the bandwidth request between
> some value and 0, I really think we should carry a "bool enabled" on the
> path and replace these two functions with
> icc_bulk_enable()/icc_bulk_disable().
>
> The added benefit of this would be that you call icc_set_bw() instead of
> changing the geni_icc_path->{avg_bw,peak_bw} and don't need to keep
> track of them here.

Yes yes! I had the same thought here [1].

Georgi, what do you think?
-Evan

[1] https://lore.kernel.org/linux-arm-msm/CAE=gft58QsgTCUHMHKJhcM9ZxAeMiY16CrbNv2HaTCRqwtmt7A@mail.gmail.com/
