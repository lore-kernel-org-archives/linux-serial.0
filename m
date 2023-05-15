Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79158C7EE24
	for <linux-serial@archiver.kernel.org>; Mon, 15 May 2023 06:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjEOGY3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 May 2023 02:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbjEOGY2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 May 2023 02:24:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F41FE8
        for <linux-serial@vger.kernel.org>; Sun, 14 May 2023 23:24:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9659f452148so2246685666b.1
        for <linux-serial@vger.kernel.org>; Sun, 14 May 2023 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684131859; x=1686723859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZrCCJnB8j04SQidDp73H5RlpBN8W7gZ1uSfWyGv/a0=;
        b=gw8iMh754Svye3MoH+GldEiAvTGQQ3ivNI4h9pqyp5ulva34F/fRSSXTHRZrTh5qzs
         UCZKLAvuLoPMqtYIyZI9y5iqamV6v0lLZDIm39CVNRaXT1ptv7iyTHPWkKezjx2HSMra
         EVvPokJmbZe3x1BxjF1oo/ju1eh1ktk1QTxLgtf3Il3PvdTcOACQiuiPzR3KrOauzvBs
         zLKcxwTWzFe3EIkgo7KYO6tVHvXSMKFf3ZZXtOC9xY4s7FJoRNM7detu2IexNxkmHJEW
         L5es9j/sFYxpWMvQ0VdZGWxmkOesVtUFgTbUP7KEBPPKR52rwzdoS3EOYjeUgR1qvxT8
         FgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131859; x=1686723859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZrCCJnB8j04SQidDp73H5RlpBN8W7gZ1uSfWyGv/a0=;
        b=kl49iazYYtZZn8mm007MzUDvj/b9m3lkqqJh3oCU9NdY+hxvTG9ImgTg2YsC62yu/K
         s5hN14aVJivT8Qb8z4sT1xae3mu7yS4e1RFqS8riFctbX39v5PT6q+u7Y0ubQubuETWu
         blV5ddAkiWQtVYg4IsLeNb2jfG/lkcXaBOEinQ6cQsYoWut6k+6VTGciIq2bCFpdXIVT
         sqmg/VZUw1u1wxDfcvxyWsleXGw3YoPufriCbFGvsIsU+hfHwGfDQd5i1mE6Vdh+chAj
         fVMW8DLgE6bJ5Qx2vwvNbioRW9yBr70ssAFCfeVSLwmyLSq2OW4wjyy5kqmTp4qqjMLk
         ytpg==
X-Gm-Message-State: AC+VfDxMPB+shX/NSWB2y0upJV8CUoKMWhOPRVWolUVzVLjzMFEuu6bG
        AUr/yaormpYAY/rG3AoEGsrPNQ==
X-Google-Smtp-Source: ACHHUZ4k7nrcgyH1Qra2Mu296AsBuB70tNW9OEut7qSvtCarjgHLds9kwSn1mp7vLBj5nECNleh6Mw==
X-Received: by 2002:a17:907:6d85:b0:966:5eb6:40e1 with SMTP id sb5-20020a1709076d8500b009665eb640e1mr25219014ejc.74.1684131858857;
        Sun, 14 May 2023 23:24:18 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b00959c6cb82basm8981963ejc.105.2023.05.14.23.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:24:18 -0700 (PDT)
Date:   Mon, 15 May 2023 08:24:16 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, Jiri Slaby <jirislaby@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
Message-ID: <20230515062416.mnxuudjbx44skclh@krzk-bin>
References: <20230514165651.2199-1-jszhang@kernel.org>
 <20230514165651.2199-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230514165651.2199-4-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 15 May 2023 00:56:44 +0800, Jisheng Zhang wrote:
> Add bindings doc for Bouffalolab UART Driver
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  .../serial/bouffalolab,bl808-uart.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/serial/bouffalolab,bl808-uart.yaml#

See https://patchwork.ozlabs.org/patch/1781053

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
