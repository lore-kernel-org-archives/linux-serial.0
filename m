Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D272EC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  4 Oct 2021 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF29061354
	for <linux-serial@archiver.kernel.org>; Mon,  4 Oct 2021 18:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbhJDSaf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:30:35 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38728 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbhJDSae (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Oct 2021 14:30:34 -0400
Received: by mail-oi1-f175.google.com with SMTP id u22so22880109oie.5;
        Mon, 04 Oct 2021 11:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=30HQln+wER4i8oI6Ahs8n/SOkX4Lu7FziBzc1pJ6uKA=;
        b=l3cBqb0sU9tVn9yymGyHpjmCyARUaiDnR7MAdnEJYtgbdys+iv+XQdRx+jPFOVrBHF
         s2QsLtp+z6oV5Rip2ezpkMLOGuxESkBBfIkQWVKInvRMseIPS6pKs79oKFWMwTwN9w50
         tDF3eFyuz+v17hpFJNK1iqZ5u+6QJU4pU/tk7rNKUnavqmmSOPoOfPcOVviJ+3TsZj+8
         RbTpzO94VevXw15rhWVIeWhdot1En9PZCChzbTiUMrrXx3EHhTR8JlW38pJtxYxnQxXT
         ZekGk/gQ6kVxLE7tZx8cTKfN2pitcZArnLQflHFiVGEP5p+OE8AzI5TGBp44Eig8GlXL
         Mo+A==
X-Gm-Message-State: AOAM530ulgk0BlUW6Eku/FYv//BaG4zaHV/WN/ybUH5NY4u1jSc1DHGv
        K+sv5s63v+Al1oy1cECsqAnZoR+smA==
X-Google-Smtp-Source: ABdhPJzCDuSIId7VbAQ9f0isnbFJE0P4zrNq4x+qxUJML7ipjQ78ulHQ1eW1plPj4TYhadKmWBjp/g==
X-Received: by 2002:a05:6808:10d5:: with SMTP id s21mr15202923ois.152.1633372125179;
        Mon, 04 Oct 2021 11:28:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v32sm1213402ott.23.2021.10.04.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:28:44 -0700 (PDT)
Received: (nullmailer pid 1612537 invoked by uid 1000);
        Mon, 04 Oct 2021 18:28:43 -0000
Date:   Mon, 4 Oct 2021 13:28:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] dt-bindings: serial: Add a new compatible string for
 UMS512
Message-ID: <YVtH20qKiacsYp+X@robh.at.kernel.org>
References: <20210928095229.233572-1-zhang.lyra@gmail.com>
 <20210928095229.233572-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928095229.233572-3-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 28 Sep 2021 17:52:28 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> The UMS512 also uses the same serial device with SC9836.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
