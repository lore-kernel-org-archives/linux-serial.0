Return-Path: <SRS0=VfF8=BB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA37C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 05:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E67920792
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 05:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPcUArAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGVFYt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGVFYt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 01:24:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF823C0619DB
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 22:24:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d7so370605plq.13
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 22:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sKsu2k4zgHSwkJM1tGdl1w2cpO2vsxMcLmVlUEcUe4I=;
        b=tPcUArAXeKgDPP+5uhYAO+IddNgf5clIh1GvfT9og2rVyw/GDB3vMFPJLJT5Q80lK7
         M16unqNehP0zaoRQWzToJQd6ZSZQT4ojfUQxhSXRUsHWWJUGDOammwIs9huiuZxi+QgC
         RqbR3edVqGyYFjt1qRUk5KOLP6oCzp4Hg9lm4vF9vhk5WhCCbX34GM0kiucsa6RaR1sB
         LqHKrmbTDBkhjC+Gt+dyJz7+C0BOn/9dkl3zIibme2ggwqFSRCU1KmiqY7jjlN+vJG+v
         0OQjg/2MN/F+H6TCzgo18p4/0jV0EXYV2IeDm0dhOKhbJzsZQk58g5Av6pakErnj5qfg
         nI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sKsu2k4zgHSwkJM1tGdl1w2cpO2vsxMcLmVlUEcUe4I=;
        b=kmF+rDqTHXCdWF4ogPUfKastsdyDHebo8IUEWw/X3kgY5lucwLvTXjKZqz/lnzg28h
         c4NR938gw8sbSlenSlJsiaZbah453e/oS9eeiqDTnBgBmp9sn4bpNF38H51TRRy7QaIe
         AGW8hZAXpqp8OfOHDKD8Y2gPIwO1sR4GXu3ObPhYnME/1vMr7WD8jnVvdELZFed6nY5u
         jdQHJ/tL+ydak1L4cQ+EHR6fO/tLiS3/M1ZNj1yZY6kHlTL3+vftJiq9upoAFrlcmXAO
         oQP6vTiNdQ/FAfW84pYamzhMmykFpomjK8t2bF0DquK4LA7Z2Ejx87EkY2jOZdx3uD6a
         gqbw==
X-Gm-Message-State: AOAM530squPO8sThjtP6sKBBljBlCR5bSBkgjHcHBjz2l3mV+TooO1Hz
        5DKgd9yIFnDTvOEgP+eAQDal/A==
X-Google-Smtp-Source: ABdhPJy4KtwrRmb0WHGLTdusgx9+v5/UvU1PCVaIysq25oC726zsaTjQhBx2RAqTt8iVfLZkBgfnIg==
X-Received: by 2002:a17:90a:f68c:: with SMTP id cl12mr7306414pjb.116.1595395488285;
        Tue, 21 Jul 2020 22:24:48 -0700 (PDT)
Received: from localhost ([182.77.116.224])
        by smtp.gmail.com with ESMTPSA id 21sm22102854pfu.124.2020.07.21.22.24.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 22:24:46 -0700 (PDT)
Date:   Wed, 22 Jul 2020 10:54:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@chromium.org,
        robdclark@gmail.com, stanimir.varbanov@linaro.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/6] tty: serial: qcom_geni_serial: Use OPP API to set
 clk/perf state
Message-ID: <20200722052444.updchi2yfjgbf3hb@vireshk-mac-ubuntu>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-2-git-send-email-rnayak@codeaurora.org>
 <159347264530.1987609.11350620235820019545@swboyd.mtv.corp.google.com>
 <a3d53f82-b29d-97ef-3ba1-ca9bd650d354@codeaurora.org>
 <20200630030552.cfp5oh33qde6nlnf@vireshk-i7>
 <159532101373.3847286.9695594340556014384@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159532101373.3847286.9695594340556014384@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21-07-20, 01:43, Stephen Boyd wrote:
> It seems that dev_pm_opp_set_rate() calls _find_opp_table() and finds
> something that isn't an error pointer but then dev_pm_opp_of_add_table()
> returns an error value because there isn't an operating-points property
> in DT. We're getting saved because this driver also happens to call
> dev_pm_opp_set_clkname() which allocates the OPP table a second time
> (because the first time it got freed when dev_pm_opp_of_add_table()
> return -ENODEV because the property was missing).
> 
> Why do we need 'has_opp_table' logic? It seems that we have to keep
> track of the fact that dev_pm_opp_of_add_table() failed so that we don't
> put the table again, but then dev_pm_opp_set_clkname() can be called
> to allocate the table regardless.
> 
> This maintainer is paying very close attention

:)

> to super confusing code like
> this:
> 
> 	if (drv->has_opp_table)
> 		dev_pm_opp_of_remove_table(dev);
> 	dev_pm_opp_put_clkname(drv->opp_table);
> 
> which reads as "if I have an opp table remove it and oh by the way
> remove the clk name for this opp table pointer I also happen to always
> have".
> 
> Maybe I would be happier if dev_pm_opp_of_table() went away and we just
> had dev_pm_opp_add_table(const struct opp_config *config) that did all
> the things for us like set a clk name, set the supported hw, set the
> prop name, etc. based on the single config struct pointer and also
> parsed out the OPP table from DT or just ignored that if there isn't any
> operating-points property. Then the caller wouldn't need to keep track
> of 'if has_opp_table' because it doesn't seem to actually care and the
> core is happy to allocate a table for the device anyway so long as it
> sets a clk name.

The config style wouldn't work as well as we don't really want to
allocate an OPP table if the property isn't found in DT.

All the mess is coming from the fact that I wanted to make it easy for
the generic drivers to have code which can do opp-set-rate or
clk-set-rate depending on how the platform is configured. While the
intention was fine, the end result is still not great as you figured
out.

Because we need to keep a flag to make the right decision anyway, I
wonder if doing this is the best solution we have at hand.

if (opp-table-present)
        opp_set_rate();
else
        clk_set_rate();

Or maybe stop printing errors from dev_pm_opp_of_remove_table() if the
OPP table isn't found. And so we can get rid of the flag.

-- 
viresh
