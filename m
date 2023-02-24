Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8429C61DA3
	for <linux-serial@archiver.kernel.org>; Fri, 24 Feb 2023 11:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBXLUm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Feb 2023 06:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBXLUl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Feb 2023 06:20:41 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0286B628DD
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 03:20:38 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ee7so38376609edb.2
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3hEGyCucdzbqe3LrutT0J4NZq9m5aBL5wEqBphvaXQ=;
        b=jbUpwEFLdpLKVZ953n8tg2+JdWrD2rrbXAVTkJRRzca1k45TyM00PvwsLpS0vJGFrc
         RwMLvwKwI8TwqNYj21oQJA/ud3Unyv4HVPhUVAe50anXgbAQmTwr0li8Xf+i6ZZHJ1im
         UCc0uoXxnARYlaoAX8eqvTYwDn1zSGFZ0u+N72c6LQ1VYgNk/JFUQCb3OJzvoyUEzoaD
         cRxSDJWSpmiEb7qYa/k0szyVNZ3gEQ8vnk08SvSP65B4jXmH6bf4LXWGRZq+aBwve8de
         ehfwXeVca7WeyRLbqMBhfzNx+pPeQzprzUc5xdj0xZTzxwdu5Xtitvmrwzt4Es8uGUnn
         khOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3hEGyCucdzbqe3LrutT0J4NZq9m5aBL5wEqBphvaXQ=;
        b=spRpoQdtZQDvk/8ewv+Iea9l+Eemx9IRU+cyEzB/1B+EDamqpYTF2JtEnTEs6/lXBe
         N2VQSz5QDWf5c9tRyiAXYhuF5UBABcLrLpbKNmP6t72J/YneOPMOt6PMuizH5cG5e4PM
         czxp2eCu7fMjm/U3I3MoTaecNM2HLQ9YHRSayBTznZ5+L/u6ZJRKOvZicniQET968dF/
         VFf1tfQ3jj4nAUxt1FapWmmX2otsD9cC6ba4Z7M3XCglyop4l6tb54rMInAYbYt2Esmg
         25BhdZByElh6BmvBwA3Y8S+kGZ0q/sQ7lBZ/aqhWTr706D5KD+o66X8BG3G6Loi4PQmt
         hhOg==
X-Gm-Message-State: AO0yUKXsahaVODi4bN3Tghy0b8oDWfVOyf2ixreRCLhxfnWI7kzgXlQr
        dZYIlsoV6OBDuVylsnDXB5pKvw==
X-Google-Smtp-Source: AK7set98CJO+wXTLM4UFAXnn0d/1LPj+v6ZqaACgh7v/kaIs6ZoV7T9E/BJ/U9Ahs/LjexIsQttccg==
X-Received: by 2002:a17:906:1093:b0:8b1:75a0:e5c6 with SMTP id u19-20020a170906109300b008b175a0e5c6mr26507949eju.18.1677237636530;
        Fri, 24 Feb 2023 03:20:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b008e53874f8d8sm3436088ejc.180.2023.02.24.03.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:20:36 -0800 (PST)
Message-ID: <1cda61a7-91cd-6f47-619b-e38a5131d182@linaro.org>
Date:   Fri, 24 Feb 2023 12:20:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/3] dt-bindings: net: Bluetooth: Add NXP bluetooth
 support
Content-Language: en-US
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        alok.a.tiwari@oracle.com, hdanton@sina.com,
        ilpo.jarvinen@linux.intel.com, leon@kernel.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-serial@vger.kernel.org, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
References: <20230223103614.4137309-1-neeraj.sanjaykale@nxp.com>
 <20230223103614.4137309-3-neeraj.sanjaykale@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223103614.4137309-3-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23/02/2023 11:36, Neeraj Sanjay Kale wrote:
> Add binding document for NXP bluetooth chipsets attached over UART.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

