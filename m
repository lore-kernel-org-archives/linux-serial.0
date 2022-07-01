Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADBC433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 10:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiGAKBI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiGAKBF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Jul 2022 06:01:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820473937
        for <linux-serial@vger.kernel.org>; Fri,  1 Jul 2022 03:01:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so2173677pjj.5
        for <linux-serial@vger.kernel.org>; Fri, 01 Jul 2022 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EU+80uB9AuFDDwuDBeiwAOcy+KrpS749JH5BAOBcYCY=;
        b=RQhyCVoJpISo4lW6ptfdIP1t2P+XiiVWvh7e5vn3W4BYATzrNOxd60d4k1GEEV9SL/
         9q/LZbrj7KEpHzy536su0G4HRm4Z+ASlnecJZH3wF3NpTP3eygNTaDLYO2GzwnQR7M5t
         FRVO301n6EcrOlF8BUEXNPI8ItnfRv5Lz5rdKct8qQBZCwhqpBD4lWyGCUxSBLM/2lCX
         Zp/kvsTzutYgg6rE0h+Dq9JGR1Wbj20SFrvJD0DBs76bVLZ9DkQtZcSnJRu8qNMEXdLt
         tYETEGNTgN0tM1wHhNM722aMFKs0F2nzuDQCum4RtACWqsB2jt7SJZ60KXf9bEHFkSWJ
         9JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EU+80uB9AuFDDwuDBeiwAOcy+KrpS749JH5BAOBcYCY=;
        b=GFtZCH6dyKxxjpgAwAuPZr915aT3onC25sMkEd11ugHtTWZip2X05lugJ43jUGSOU2
         ErnpX23jfPmRxsFao4jVJwKhA7wjnqROsGWZec8OdP9qj1u3d3mmBXoHY4cNjsJNxlbE
         aGO/m9i36k6jy3Aqf7zgNjtsyo+HUDv863/ohOGWmEF6Te78l4u/66T8gKfNnzTEYVze
         /dNtIOsW3Sut7Ec0ZCgBzCHox2Xr3Q+Jr9B1coOnvCFXhev6uFYvLII3/B8hBC8PfMOr
         WXrmBKL4NTLqDJT6HWAtANoLB+GXth2S5RcIO5Hlgy4KcrKUEOqjHWPGXhGP3NDvqUw1
         pifg==
X-Gm-Message-State: AJIora+Tz20bTLtZdBO8v5Vil1r8isxPN4Kk+qBgNzaNzt/q5WRGSKrV
        UpDx5vaJea7T2Gvc9oL7nyxolA==
X-Google-Smtp-Source: AGRyM1tV1beAgmHJBBN4pNbi1B7WPOwBFJgQ1MJ2XehV5ju/UBeogLNx5INSiFlIR65SHcj52wr0qg==
X-Received: by 2002:a17:902:f543:b0:16a:54c6:78c0 with SMTP id h3-20020a170902f54300b0016a54c678c0mr19537321plf.22.1656669663309;
        Fri, 01 Jul 2022 03:01:03 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id x1-20020a636301000000b004085adf1372sm14913513pgb.77.2022.07.01.03.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:01:02 -0700 (PDT)
Date:   Fri, 1 Jul 2022 15:31:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 24/30] serial: qcom: Migrate to dev_pm_opp_set_config()
Message-ID: <20220701100100.bxv4t4t7iqphalpv@vireshk-i7>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
 <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
 <Yr6z5ixRTsIbZvsq@kroah.com>
 <20220701092458.tzqv7yul476kh2o7@vireshk-i7>
 <Yr7AwAZeSPeQKDPU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr7AwAZeSPeQKDPU@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01-07-22, 11:39, Greg Kroah-Hartman wrote:
> It's now more complex for simple drivers like this, right?

They need to add a structure, yes.

> Why not
> provide translations of the devm_pm_opp_set_clkname() to use internally
> devm_pm_opp_set_config() if you want to do complex things,

That can be done, yes.

> allowing you
> to continue to do simple things without the overhead of a driver having
> to create a structure on the stack

I didn't think of it as complexity, and I still feel it is okay-ish.

> and remember how the "const char *[]"
> syntax looks like (seriously, that's crazy).

The syntax can be fixed, if we want, by avoiding the cast with
something like this:

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index a018b45c5a9a..1a5480214a43 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2559,8 +2559,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
        const struct sdhci_msm_offset *msm_offset;
        const struct sdhci_msm_variant_info *var_info;
        struct device_node *node = pdev->dev.of_node;
+       const char *clks[] = { "core" };
        struct dev_pm_opp_config opp_config = {
-               .clk_names = (const char *[]){ "core" },
+               .clk_names = clks,
                .clk_count = 1,
        };

> Make it simple for simple things, and provide the ability to do complex
> things only if that is required.

I still feel it isn't too bad for simple cases right now too, it is
just a structure to fill out but I don't have hard feelings for
keeping the old API around. I just feel it isn't too helpful to keep
the old interfaces around, it will just confuse people at the best.

Anyway, I will keep them around.

-- 
viresh
