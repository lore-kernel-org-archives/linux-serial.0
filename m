Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC27C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457B5613CB
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 09:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhDWJzq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:55:46 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:44709 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDWJzq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 05:55:46 -0400
Received: by mail-wm1-f51.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so878669wmf.3;
        Fri, 23 Apr 2021 02:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxU1ZzxRokGVb1YELDuu4vCkimZAQe95BQeIGMh2iio=;
        b=o1WF88X9UhdmS5BjDxIxb7fQ7diZ338Y0iRHyjRM8jQmyMuFNN0B4GLr6rODWjq9tJ
         DcBfKPoOm99cDqPxZoS1hXXGPoYILLm8xK+WBtZvVasVD8IkUS5JKnGe0xSrbTWAMJBB
         LQZ9WFf8vyI2+HJ3AeqLNTSghbJ4IM8b6rziPzuubYOdCkdxRGb/cvmSBOxmQBZSUwIv
         RGH3FmyyxZkJ+jdLgCTMIbpmNqkl51QxnoG4fFY2V7/VRxdqSoavzH+xux/U2OEO/O+E
         AXye8kxDFOgrG1ixTHS7gJGHA4YY7pdJE+lO4x6+8j0ST4IiCVZvd/wl2+I5UGx5C87Q
         Wu4g==
X-Gm-Message-State: AOAM531GfSsHuMo4s27l9UTypbmuAEYBtF2cpcIn1zIE0Rq5U2P8vQE1
        DTr7Y83nV2aJzntUi2LSQ74=
X-Google-Smtp-Source: ABdhPJwlQLqLgFtdKujrYNdTUf6A/yxTMbeJrybYimSjvjgT39D781oxlI+zCcKf97ePTj88RTxBrw==
X-Received: by 2002:a7b:c10a:: with SMTP id w10mr841773wmi.176.1619171708976;
        Fri, 23 Apr 2021 02:55:08 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id x2sm8970962wrg.31.2021.04.23.02.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 02:55:08 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: samsung_tty: remove set but not used
 variables
To:     Tian Tao <tiantao6@hisilicon.com>, gregkh@linuxfoundation.org
Cc:     linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Hyunki Koo <hyunki00.koo@samsung.com>
References: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <6f8d59ca-3d28-82a9-0105-a471ee90ac1f@kernel.org>
Date:   Fri, 23 Apr 2021 11:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23. 04. 21, 11:39, Tian Tao wrote:
> The value of 'ret' is not used, so just delete it.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>   drivers/tty/serial/samsung_tty.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d9e4b67..d269d75 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2220,7 +2220,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   			default:
>   				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
>   						prop);
> -				ret = -EINVAL;
>   				break;

Added by:
commit 57253ccd5831e7e5720c433437775c3e6b7d0c72
Author: Hyunki Koo <hyunki00.koo@samsung.com>
Date:   Wed May 6 17:02:40 2020 +0900

     serial: samsung: 32-bit access for TX/RX hold registers

Hyunki, what was the intention with "ret" here?

>   			}
>   		}
> 


-- 
js
suse labs
