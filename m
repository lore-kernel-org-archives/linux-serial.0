Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C0C433EF
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 13:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB4061251
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 13:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbhJGNfG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:35:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36600
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241508AbhJGNfG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Oct 2021 09:35:06 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0214D3FFE4
        for <linux-serial@vger.kernel.org>; Thu,  7 Oct 2021 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633613592;
        bh=XOOtcMxu4VGplGw4HdBrnq8LT8wk3wMvDJtbbxYgvsw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Hm0ObiBkLQ/uvvAkSfpV/DAlHEH9GBBRC7DBOC4aBdXrFVvwWquRyo2ArUINBLpRH
         F+1aqEXzH9gx8FcWOB1rDC7msnQi2BTzZHzoKzqeqNQqebfyA3M4Rzr+9pcClMtgau
         f8RQA/Shljmh728voCd24eCl92vpQLDNECfNUlnJRPYUZrPMxzjJBX4epn2vIMQHMm
         bDuO9JtXZ+s3ODF/Lb8pCXnX9CCyEiih6qE2Btoc01BLTXxYAJTPVsBrQSwCEolvvI
         xuu+lSx0/oMTno4oHuLsSIG9M82kxFGM06tSIxqbmcEeCaGDA2hO7KUBOAkZ329wfY
         feVa95XfbHrfw==
Received: by mail-wr1-f72.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so1037779wrm.3
        for <linux-serial@vger.kernel.org>; Thu, 07 Oct 2021 06:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOOtcMxu4VGplGw4HdBrnq8LT8wk3wMvDJtbbxYgvsw=;
        b=eR/KByOX7PPp1VJCDKnIoWemdBcebXsH123nEQ4bZDBPYkekccZx5J66VDSdPCDPVZ
         q9d06B52FNDbssqlsIQUYz2c9KFrg6k/eIUVi1clXH8rxRER2xUumScjK6beqebh/Wwu
         yA3/4VmDF+FLp1dskO3BlilSf4fEwi68UKt1T5ZR5g5kwonz2kbuQVnWTM5ZRpVgJ5Yu
         OiMlAmLxCZOVY7H1Sktm4T7CZmiZu/xYgeMSmYkvrOxSjLaqIJdW6JJVma3Hwpj9n0S/
         utzhCJ+GprYAN/qCA8bm7KGfTOX+xTK2MPufhHf9CjNJJ5NIJkZx1ZQoZ8HUSpbaNgOQ
         N/Ew==
X-Gm-Message-State: AOAM532jq73JHDzVECp8UZw9QcOr1Gpw8Jgs2lW1NQfkpvfPIu6r81XI
        ga6kKhoQjNWqWP4IU8YijoZirGXm3MnScuAwXHHH3y7nV6BFHVJxkMRQ8FaplzKuClCaqZ2NHKC
        QGTElDwllLbw/6T1kH0S7xFB34/Br0ILlxmYtd4W++g==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr16396830wma.127.1633613591677;
        Thu, 07 Oct 2021 06:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjsCDvHGtPoTWQUiPu1xD+rfOLwo1X6CpLXbYUd/gRjlfYdJKXG9PE5H5BcQatFGmrqVvqCA==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr16396804wma.127.1633613591523;
        Thu, 07 Oct 2021 06:33:11 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id y1sm13474952wrh.89.2021.10.07.06.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:33:11 -0700 (PDT)
Subject: Re: [PATCH v2] tty: serial: samsung: Improve naming for common macro
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211005095800.2165-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e2e8cf83-b888-9472-c25d-03c4068e25d3@canonical.com>
Date:   Thu, 7 Oct 2021 15:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005095800.2165-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/10/2021 11:58, Sam Protsenko wrote:
> Having "_USI" suffix in EXYNOS_COMMON_SERIAL_DRV_DATA_USI() macro is
> confusing. Rename it to just EXYNOS_COMMON_SERIAL_DRV_DATA() and provide
> USI registers availability for all Exynos variants instead. While at it,
> also convert .has_usi field type to bool, so its usage is more obvious.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Converted .has_usi field to boolean
>   - Used true/false instead of 1/0 values in
>     EXYNOS_COMMON_SERIAL_DRV_DATA() macro
> 
>  drivers/tty/serial/samsung_tty.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
