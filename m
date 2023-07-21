Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D34EB64DD
	for <linux-serial@archiver.kernel.org>; Fri, 21 Jul 2023 12:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGUMsN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjGUMsL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jul 2023 08:48:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E730E4;
        Fri, 21 Jul 2023 05:48:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317009c0f9aso1615824f8f.0;
        Fri, 21 Jul 2023 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689943684; x=1690548484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWcqz9Mv4HI+eaPkkvqsQEiwNN0pLbZENRpAKS2EXZE=;
        b=R7lfBloi9SfqaQgx2ZueNSd5JHSmV2O/sRGh1VITEs38EWO8qcC/8tp7q4DQ50bJD0
         EGpqcHzV3fprIjGGH0A6yUUz2sAxNNQZFRHFwOAtwGVY10Vgrpyfm8uRGnfZ43TsrsQc
         wVj6JnVDc5uEMinfC0wLCaFAKh+zUVqPqCUeooOpZ32Dh980w778teGVUP5OG7eblrtK
         Xl232glVvdqAf8RAGedfSpkHecECc6UqPrTDet4XhmmITlxKVO6tcbIvFWaClXybWR0S
         Bb6tJ4DX97BtX9lI142vNlCxOnUm3EZ0/pLCnqvlWlvdqr+VV9Clm7OK02FLiDeflWIB
         N+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943684; x=1690548484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWcqz9Mv4HI+eaPkkvqsQEiwNN0pLbZENRpAKS2EXZE=;
        b=itkS/7iQ6zBgVnZGTANr7e0GTXtw9sDE/Tw7yN5vY/Wl2qPYosQxMkk3zZLeZYKbVj
         zhgr+zETO0FrvxuAWekL3vMUwk78rBMNhpcbRESWbZpht68ou3Qf6F2UbIUfU2r6quFX
         vqyMf/0HCB66q2zJcilr+G4apC/ZO9dWdKp9TJ6lS0/9otsAE3PL6RtiiXv2p5UgxO5Z
         B/pP0UNzjl9N+HjxLrDeMqY9iB+WOcdpJ/Yj5qJdLAtIvE1XpEVdJmGQyUTCVE/CCOnU
         7i6/N+ho3mzk2q53DV4k5mJsTpbhTHGf2/dgTC+llDvz3/Jpw/iixnAecaq8V2LCEkqr
         v6+g==
X-Gm-Message-State: ABy/qLYp98xECGnjmM3MwUO/BbgLnVwsqSu7Xqu2MV6yPqVHjLMAZZDX
        u7KzlpHrHMigEGgXbk+WTeY=
X-Google-Smtp-Source: APBJJlEKzdxuWLAJ7uMvQhrQRKj+a2acYf8JtH/ZDEbLCiiIp+FKYH7OT3KjEitMBFUXc6viT/fRQQ==
X-Received: by 2002:a05:6000:1187:b0:315:8a86:cf7f with SMTP id g7-20020a056000118700b003158a86cf7fmr1168091wrx.70.1689943683795;
        Fri, 21 Jul 2023 05:48:03 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o5-20020adfcf05000000b003172510d19dsm4130464wrj.73.2023.07.21.05.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:48:01 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: tegra-hsuart: Convert to json-schema
Date:   Fri, 21 Jul 2023 14:47:59 +0200
Message-ID: <168994366590.2988875.8075788472023151344.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705151802.2512186-1-thierry.reding@gmail.com>
References: <20230705151802.2512186-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Wed, 05 Jul 2023 17:18:02 +0200, Thierry Reding wrote:
> Convert the Tegra High-Speed UART bindings from the free-form text
> format to json-schema.
> 
> While at it, also fix fix the example to reflect the correct compatible
> string for Tegra30 chips.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: serial: tegra-hsuart: Convert to json-schema
      commit: 1e218a91103f725bcf1c8788d272a7c213bce96a

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
