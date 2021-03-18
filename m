Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA496C4332B
	for <linux-serial@archiver.kernel.org>; Thu, 18 Mar 2021 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E164D9D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Mar 2021 17:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhCRRNo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Mar 2021 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhCRRNj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Mar 2021 13:13:39 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A58C061761
        for <linux-serial@vger.kernel.org>; Thu, 18 Mar 2021 10:13:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f17so1626024plr.0
        for <linux-serial@vger.kernel.org>; Thu, 18 Mar 2021 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1sseX0Xf3BUtKz3PR0Gizm8Ulb+76kkvwxNlI1Phel0=;
        b=lPHk5Qo2Lb35CXcQnM+dRJ5QATTMsQuJnxyOV8yE5AlzOJe7G7CXoxkCB7ivQ1MHCq
         B0Dm0BhakKimujDv9ePNv9PH/WSAC/PW8M3GpTFZZTKsPwsBEPHQeT7nPFnN4GWCBNKC
         6kDr0+TmcPqWTq4cnlMVj4fQ/ezN8uIhxFx9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1sseX0Xf3BUtKz3PR0Gizm8Ulb+76kkvwxNlI1Phel0=;
        b=DvY8fIW5xJn85Clvp7fsf6A276agTDCuc7TIzN03rahVJVszRk0J8vNedOMzAfFkur
         2cQzePTQCQVz3tP3pqWKjqYDTBrG0YCS1DspHXJGbDNUIunKLDqNR2YvuAYRUJGeWOqS
         1DzLjfVWB+Yu2MHrLnPuf/GKEiloJgfXKDDbLQ/SALkWG3PdffS5a3bv3W8HLas1TO0N
         Twu+/8ejrK/rRsUhbiniXUUJEQ124hCJrXfAT4IhXQzFggJh1Qk+5EbcT7+FUHNFJpNL
         E+NF0CzFeGieXkGjKmq9MoXTPP1TGk0/HdcSNQl+baBPXBkGZ1KjAEyQmviYG8McrjlO
         KRdw==
X-Gm-Message-State: AOAM530KNmlz0MBnsupZHyNw6DyEmIJ+P5W3X4n9nZk/2ObKzPqHSW1b
        J/EObDclQERkd6xL7KXkatshuQ==
X-Google-Smtp-Source: ABdhPJwbOEmo329XpSz1wEf3cFY6vA7M4NEYEfSU9e0kOD9VDn2EAXvUS6ECDxze8HrI66RfVx5BJA==
X-Received: by 2002:a17:902:441:b029:e6:364a:5f55 with SMTP id 59-20020a1709020441b02900e6364a5f55mr10714521ple.7.1616087618263;
        Thu, 18 Mar 2021 10:13:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3cf8:6a09:780b:f65d])
        by smtp.gmail.com with UTF8SMTPSA id 21sm2666277pgf.69.2021.03.18.10.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 10:13:37 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:13:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V2 1/2] soc: qcom-geni-se: Cleanup the code to remove
 proxy votes
Message-ID: <YFOKQKlI3MjMouEA@google.com>
References: <20210318111009.30365-1-rojay@codeaurora.org>
 <20210318111009.30365-2-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210318111009.30365-2-rojay@codeaurora.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 18, 2021 at 04:40:08PM +0530, Roja Rani Yarubandi wrote:
> ICC core and platforms drivers supports sync_state feature, which
> ensures that the default ICC BW votes from the bootloader is not
> removed until all it's consumers are probes.
> 
> The proxy votes were needed in case other QUP child drivers
> I2C, SPI probes before UART, they can turn off the QUP-CORE clock
> which is shared resources for all QUP driver, this causes unclocked
> access to HW from earlycon.
> 
> Given above support from ICC there is no longer need to maintain
> proxy votes on QUP-CORE ICC node from QUP wrapper driver for early
> console usecase, the default votes won't be removed until real
> console is probed.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>

I suggest to mention that this is essentially a revert of commit
048eb908a1f2 ("soc: qcom-geni-se: Add interconnect support to fix
earlycon crash"). This makes the life of reviewers easier and it's
also good to have the reference in the git history.

You could also mention commit 7d3b0b0d8184 ("interconnect: qcom:
Use icc_sync_state") in the intro.

I tried to test by first reproducing the original issue without
'sync_state' in the ICC, but wasn't successful, probably something
changed in the boot/ICC timing in the meantime ¯\_(ツ)_/¯.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
