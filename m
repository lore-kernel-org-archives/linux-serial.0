Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893FCE79CF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Sep 2023 12:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjITMfW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjITMfU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 08:35:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF85A3
        for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 05:35:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf3f59905so911293366b.3
        for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695213312; x=1695818112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLTqYIzg+lzYdWxVhMCzWlzNaCtUEOxWm6ZlofL9b/k=;
        b=I+cPSUGb1xePAT25tlhq0vjw56sxYd1o9HyIWJWro1rQouVzNe8MYOCdFiHjGsPvic
         vRJbY2OtepC7s520ALHDcgKAPwCyUxiEiZvdqKBZ2PnQ/WauPVYbxItwFaBgU1bClJN0
         tnrunym4zhCXJ0+Sm7VCVN+b99CL298pVYCtR/xDJ22EUGQ6MwulO5xqzR6FjbaRxd2s
         YI4AP7ZbuYCpD5mlV8wnzeN61f71XkR9BQ2t2hRk5OPXAeqHetn9rDTLDzkRnaJtHw08
         vwFSNRzMyGgRh1HcDzoqrUawSq/2xN6uOBdi+iw6sRRiC3HEt3/E7aXU5C397daL6zCr
         Y9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213312; x=1695818112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLTqYIzg+lzYdWxVhMCzWlzNaCtUEOxWm6ZlofL9b/k=;
        b=Dt5IXle+PV0aHZ6NjUUYuU3mHowtJ3INP0ymJpsuIlri1iNE3XPXtIUVV6LAstdV5O
         lrPaM4H8PMTkuiqHjscYF3Kehbz/CE9iRroFDsvfVbtQPLzwTZzeXVkA1q21VWEP8FY3
         H+8qbZrmuJnEHk2tiGW7z3D+wLV3V6MrlwOLv7vfiUvpXwPTjfIYdAL+4T4kkDir46l3
         B0B6JpIDy5f2Q2H2kdfzvcv7zLRF2nfi5ToupV0rXSzgpcbh6Db1e7jEjZBGMRqE4RJI
         xbYTdz4OJ+YjdYmAJx1OHlS6YwnmDf4swe/d+vgEXr+yrDe1dd7+A1nE8uQbT08fg+y7
         Ycng==
X-Gm-Message-State: AOJu0Yyt+NQyAJkI/mh0M+0vDaNTtcPTM0qaC4rywP+vRvKSDTEK03/B
        f033900mV4MpDHY+6ZEyHqBFFQ==
X-Google-Smtp-Source: AGHT+IGwvU86FMvs+bljEO41B9RgRTmfnEPEA0QwaQ7OV1Kiu3h4DYuDlsLWhXSICh5oRzDAYMOvHg==
X-Received: by 2002:a17:907:2c62:b0:9ae:3e2d:e2e0 with SMTP id ib2-20020a1709072c6200b009ae3e2de2e0mr2040658ejc.71.1695213311891;
        Wed, 20 Sep 2023 05:35:11 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id sb4-20020a170906edc400b00992b8d56f3asm9271582ejb.105.2023.09.20.05.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 05:35:11 -0700 (PDT)
Message-ID: <97a04999-91d5-2f4b-3fc1-d9fecb89082c@linaro.org>
Date:   Wed, 20 Sep 2023 14:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] dt-bindings: serial: document esp32s3-acm
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
 <20230920022644.2712651-5-jcmvbkbc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230920022644.2712651-5-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/09/2023 04:26, Max Filippov wrote:
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +

Same comment here - missing $ref to serial.yaml. Sorry for no bringing
it up earlier.

Best regards,
Krzysztof

