Return-Path: <SRS0=MLOr=CS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5E9C433E2
	for <linux-serial@archiver.kernel.org>; Wed,  9 Sep 2020 11:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87E121D7E
	for <linux-serial@archiver.kernel.org>; Wed,  9 Sep 2020 11:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4KHcZLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIIL0Z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIILIq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Sep 2020 07:08:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36423C061795
        for <linux-serial@vger.kernel.org>; Wed,  9 Sep 2020 04:08:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j34so1818639pgi.7
        for <linux-serial@vger.kernel.org>; Wed, 09 Sep 2020 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hHbPBPqCAjeHpFptYktHnZF2Ot4j4iCHuxaSsZ+eCnQ=;
        b=m4KHcZLZ3vphfXLl8Z6uPW+Z5xRc7prauxsfl0JLhrjWsiglWRJP4MpIyU91H/iLho
         zrypWq/9xIvYPiotVpXou3HNQ/xOAUSdnA0p1Aeb2P6B8wsSa9RZ/k3wQsg8i79uXKFf
         oqrgkMysLIqLInktyZ0qNeCahTkBgCR1FU+Sdh8z08fzYT7FIdiuUuOj/THP1lBYxblb
         crk/ICcFVagGGuLu1MtvSBSpBtzUON7VuahiwpKU9qQILtWVvIRGlEVE5GFGdKpbyIDw
         gFqItvEzQktmZxC+C5bsJupV5InVVkiOeLk+WlFuumCOeBab41igCm17UsYlleFsQ8ke
         LG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hHbPBPqCAjeHpFptYktHnZF2Ot4j4iCHuxaSsZ+eCnQ=;
        b=ccWi7JYRrVCyLmunbQmXkAUtIFw/UxmySkdI6VM57dd5YEX48jMxvU3NYtgltRSLxu
         Lcf7Loj09Ywc44xDeGfPuw8L8mjhe/olPCsFJ/21Y6xXXkptl2u4OzLGIUmTP0Sag3+S
         7DIclRQoNtHbxUfBRbgzfaVM4H0YTOIM5W2qiayf+9NpX59PsuNlcbTrRg/zcF5oHslc
         +dIfVN7cbsjzj41bAzsW4VYhVkZBdGlizzrfG3vGjQOH6cegF9/oeBRLsLncHzrsWFjN
         3KRRZAC2iy5eMhI5ejj5u9f/uhUZXJWY00C99GbPOOIgK5Yq0GvHmqtyUanIM0t+Q2Ci
         NjCw==
X-Gm-Message-State: AOAM531brk5vwlxJ2ev1ZWgKapBr82efVbD4erOrhfQQqFK4gReuth2U
        ookrs9Eb0ecuR1e93BuDabxDew==
X-Google-Smtp-Source: ABdhPJy2EZv/VIxB9RnTfqRMANkRu2WWxpNJfCDbS9BRC+1+0r57LjDxgPFYplFTRs+2i65+o+pECA==
X-Received: by 2002:a65:5849:: with SMTP id s9mr215399pgr.439.1599649690536;
        Wed, 09 Sep 2020 04:08:10 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id w185sm2619035pfc.36.2020.09.09.04.08.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 04:08:09 -0700 (PDT)
Date:   Wed, 9 Sep 2020 16:38:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Qiang Yu <yuq825@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sean Paul <sean@poorly.run>, Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH V2 0/8] opp: Unconditionally call
 dev_pm_opp_of_remove_table()
Message-ID: <20200909110807.aw3q4bqxis3ya5ci@vireshk-i7>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <20200831110939.qnyugmhajkg36gzw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831110939.qnyugmhajkg36gzw@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31-08-20, 16:39, Viresh Kumar wrote:
> On 28-08-20, 11:37, Viresh Kumar wrote:
> > Hello,
> > 
> > This cleans up some of the user code around calls to
> > dev_pm_opp_of_remove_table().
> > 
> > All the patches can be picked by respective maintainers directly except
> > for the last patch, which needs the previous two to get merged first.
> > 
> > These are based for 5.9-rc1.
>  
> > Viresh Kumar (8):
> >   cpufreq: imx6q: Unconditionally call dev_pm_opp_of_remove_table()
> >   drm/lima: Unconditionally call dev_pm_opp_of_remove_table()
> >   drm/msm: Unconditionally call dev_pm_opp_of_remove_table()
> >   mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
> >   spi: spi-geni-qcom: Unconditionally call dev_pm_opp_of_remove_table()
> >   spi: spi-qcom-qspi: Unconditionally call dev_pm_opp_of_remove_table()
> >   tty: serial: qcom_geni_serial: Unconditionally call
> >     dev_pm_opp_of_remove_table()
> >   qcom-geni-se: remove has_opp_table
> 
> During testing by some of the Linaro folks on linux-next, we found out
> that there was a bug in the OPP core (which makes the kernel crash in
> some corner cases with these patches) for which I have sent a fix
> today which should be part of 5.9-rc4:
> 
> https://lore.kernel.org/lkml/922ff0759a16299e24cacfc981ac07914d8f1826.1598865786.git.viresh.kumar@linaro.org/
> 
> Please apply the patches over rc4 only once it comes out (I will
> confirm by that time once the patch gets merged). Else you guys can
> provide your Ack and I can take the patches through OPP tree.

The fix got merged in 5.9-rc4, please apply the patches from this
series in your trees and base them on rc4. Thanks.

-- 
viresh
