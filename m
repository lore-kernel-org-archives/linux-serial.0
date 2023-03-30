Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA84BC77B61
	for <linux-serial@archiver.kernel.org>; Thu, 30 Mar 2023 07:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjC3Haw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Mar 2023 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjC3Hau (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Mar 2023 03:30:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DE146B1
        for <linux-serial@vger.kernel.org>; Thu, 30 Mar 2023 00:30:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x17so23356854lfu.5
        for <linux-serial@vger.kernel.org>; Thu, 30 Mar 2023 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680161447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ePev2vXiIgB78j8RZMlh8oFnWZXwF4zj7s3jKCDd2Q=;
        b=idH5GZi7t+zdCK6XFxUczQMxOTmCS2hlZlqm5Oyh+OnxslFaIvG1o7aBLY9RwEaz1r
         yy8f7uk9HoJEzbLBBQR+X6YLdbyIAx3d5oRHBWmIbi3pGV8HQlR1hjF2psEg1BstQvNG
         oJwWTmtwB/Ki4zjwzL9QO/5vSuIfkUXfe1Fb7r2+LAWR4io19e262L4NiJTtNC5hupwd
         FTGLrimFlJkh44Fv5lIRK8F2ypF3nY1ZMekzz6KlXjPsaAGdOaDF6MaKlFq+w8ug3by8
         Jp63EIlqueGKm2dXOWtVUCIEz6M3BXjWCKl5M8bwG5ItdZ5TIx5fA/L12Lsbfs4dt+ON
         7Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ePev2vXiIgB78j8RZMlh8oFnWZXwF4zj7s3jKCDd2Q=;
        b=2l70FMeFHP2HK2fNndYUKnhUY4Ded4idwtoN+NomDHKspuU5LFLfwqC7i78yLVnLzb
         s96iZaXswqcDVLN2OgcVRkmsLEp+m1vZBbtDFB6HVBxrBnY7ahDh21QsyqvEHVXnX/Nn
         oQrU8x0uinMJQAIPSKU8Rcls9aaOkZC6tj3Xfpx9M8La0w7lSgSWM4MpPKW0M2msslkM
         pTVYmMhzqyLOa+6M68cnXa4zkr1LiXzf4A0WKxPXVOeZEXa0UrI6B10sPrBdW82QKXzN
         JTDMofYF/Og2v+q9blNHzm2IpDLZTDcQm2SkgesIwhd26YYNtOMcm8d0Qpdd/fQB2XJ1
         FIDw==
X-Gm-Message-State: AAQBX9dDofIIzCvt4ZYieMvaefUUU6TkaBtiS3FLcP/me9wTR8YzfGvI
        ch0i0mU+xebEi/ydA7rBJb4g1A==
X-Google-Smtp-Source: AKy350Yu2lXRZoxxaHjgaEkV7zH6CCNC1El5G29BfjKpUdlV+ksDUhprrVcdISepPgR7i+YQFsBwbw==
X-Received: by 2002:ac2:520c:0:b0:4a4:68b7:deab with SMTP id a12-20020ac2520c000000b004a468b7deabmr1467167lfl.7.1680161446819;
        Thu, 30 Mar 2023 00:30:46 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h1-20020ac250c1000000b004e83f386878sm5746221lfm.153.2023.03.30.00.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:30:46 -0700 (PDT)
Message-ID: <0803c821-4206-89b4-f5e5-531bd6548df0@linaro.org>
Date:   Thu, 30 Mar 2023 09:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
Content-Language: en-US
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230329154235.615349-3-brenda.streiff@ni.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230329154235.615349-3-brenda.streiff@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 29/03/2023 17:42, Brenda Streiff wrote:
> The National Instruments (NI) 16550 is a 16550-like UART with larger
> FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
> patch adds a driver that can operate this UART, which is used for
> onboard serial ports in several NI embedded controller designs.


> +
> +static const struct acpi_device_id ni16550_acpi_match[] = {
> +	{ "NIC7750",	(kernel_ulong_t)&nic7750 },
> +	{ "NIC7772",	(kernel_ulong_t)&nic7772 },
> +	{ "NIC792B",	(kernel_ulong_t)&nic792b },
> +	{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);

Looks like should spark warnings on allyesconfig with !ACPI.

Best regards,
Krzysztof

