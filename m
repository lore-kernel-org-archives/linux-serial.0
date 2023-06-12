Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C9C7EE2E
	for <linux-serial@archiver.kernel.org>; Mon, 12 Jun 2023 04:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjFLExh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Jun 2023 00:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjFLEx3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Jun 2023 00:53:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD7E63
        for <linux-serial@vger.kernel.org>; Sun, 11 Jun 2023 21:53:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so4606974e87.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Jun 2023 21:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686545590; x=1689137590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DsAYCoMrZWXmZHOHi3xpwuuJU5o0mffow796IsUeVXw=;
        b=uylZGDYC7ysHGPy0ozWEyK3fAhI60LQ0SrXRtA1BP/aLccZYEYQ1WZnFfjdosodyOb
         3ofMcOSn6WSGE8UHhk2JFhRn9LkxDGJ0IKK4JpNDqUjqbe8M9AzDKuIQqYSofB67JWKt
         FqTF1iItcDI4e3/ZobEFRhg7Or7+w+eFPdE0PjlhKx7Op7KQN+qtVuCEuJOPYi0FnAwI
         6SGoyqJkBe14W2l876/9p0DpGxM7hen4W6qB7n2GZRNW/wYPiLdy/IMcL8RF56EnVqQx
         A+AvLvyG4RyAPKyLZLQZn9pm3zjJef7sYw9sB0aWB5OXVRe6ZzXmrdoo7KHbFgNpZMSY
         NgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686545590; x=1689137590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsAYCoMrZWXmZHOHi3xpwuuJU5o0mffow796IsUeVXw=;
        b=d8qqwYfDCqMF0L7yY08FqiGTvre/bEI0x0h12+OBQ4QOIUAMtu9Fe32EsJ0FLgzpd+
         kFDLHu6ssRIQ4T90hvLv4VhzPH4e4KD4RsUjq9qBIpOdOGO0B7xfj9p0Q+lkEf9cogJB
         u723cxorXCS8cL6g3PDBqCsTgY3MylSgFoYaJlmjE5Ta1SneP1nWkz+lhZBuAM1OQZwU
         cnioicNvihHa3kUYqIr2v+mYEk36hKVy7nSk4iuDjCk2td3JGnZx0/v8THTsvwf0JX/e
         xy0TF9RKi9ZCYO8ggGYxjZSE/HfAaXgBGV7zOR1Ar+s6Xbr9HtQfGKNKLfm+ezTZOVxN
         AH4g==
X-Gm-Message-State: AC+VfDx2GSg+gU3/kUobu4vir8b/7Jt62QGVQeej5GKJo/5gwbaqn4xD
        SN9SHawyVueXIu5yXgBb5shXBA==
X-Google-Smtp-Source: ACHHUZ47Jmdm+lvCel+EEPkd2b96l6yrDuD/wa7/D+5IUTZoedzSR9whssxVEWOYxoF7yNzD7g5MpQ==
X-Received: by 2002:ac2:5b9a:0:b0:4f6:47a2:7bb4 with SMTP id o26-20020ac25b9a000000b004f647a27bb4mr3320762lfn.60.1686545590590;
        Sun, 11 Jun 2023 21:53:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l11-20020adfe9cb000000b0030ae54e575csm11287820wrn.59.2023.06.11.21.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 21:53:07 -0700 (PDT)
Date:   Mon, 12 Jun 2023 07:53:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
Message-ID: <30c3b1ae-8df0-4112-bfbb-988d6c8a04e0@kadam.mountain>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
 <58d3f250-499d-5a18-6798-f9833cc2dbbd@wanadoo.fr>
 <20230610145429.uvmxxgxc5tc6x5b5@intel.intel>
 <eb935f16-1f89-0be9-86c9-24e8a88c2d8b@linaro.org>
 <20230610171015.vf7emd5crpr7n4mg@intel.intel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610171015.vf7emd5crpr7n4mg@intel.intel>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 10, 2023 at 07:10:15PM +0200, Andi Shyti wrote:
> All errors are unlikely and if it's unlikely, why there is no
> unlikely(!rate)?

The likely/unlikely() annotations help performance at the expense of
readability.  If they improved readability every if statement would have
them.  They should only be used if it makes a difference in a benchmark.
I think I have heard other people say the rule is that they shouldn't be
used in the drivers/ directory.

Also the other thing to consider is that quite often GCC is clever
enough to figure out which paths are success paths and which are failure
paths.  So sometimes adding the annotation is redundant.

regards,
dan carpenter

