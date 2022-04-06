Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDABCC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Apr 2022 14:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiDFOlP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiDFOlH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Apr 2022 10:41:07 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D90730766A;
        Wed,  6 Apr 2022 04:06:31 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id yy13so3531180ejb.2;
        Wed, 06 Apr 2022 04:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N2THVurhsccxKkF2HWhrDY2pkiMynqfdfvLsobfM+Yo=;
        b=h37FkggXgRe/PZc/HrlLcRdGWom2nmcXS9h4nOplt/F8pSHnJVXdcofQuvA4W8PrW3
         Rz5ZsP8o8035FWp5blHx9zoE6hljZRyfieDAAiNsET4R2iaRaHW2eyrNt9WtSqwbgL8F
         iYqrgRwRY1vzcjJnz5lPttSwxfWWSmhGlT+0g5eVMuwjdCPnlAhQmFLcTnFNQ1YeqH26
         vdg5Cc8OzVhICFQJhiIwDrsyD77x6sIF9L5OY1kmP8PmjQjDVnew+tJQoW3CI4J3wF+j
         wgfWgsMGwv+/1nzku5TtJIZTqO1rPLqk/onMv0d/E33SizM5v+82ixJxVT0z1dxUzQ6Q
         M4UA==
X-Gm-Message-State: AOAM530MTGo15zq5d/gcgASfRgXZq3ZYPnOUhLOy1Rcr+Vu8WxDBMh6Q
        D2QyxJ3aqCYRVJXHbFSlhJCxFNi1elI=
X-Google-Smtp-Source: ABdhPJxXISf0CaAZeKMZm4PCEOg+znZcmcAigb+3y0I2v8/gVHE5FOEiAQ0D4VFoaP2rJ8ypaf4gyg==
X-Received: by 2002:a17:907:3e94:b0:6d1:d64e:3141 with SMTP id hs20-20020a1709073e9400b006d1d64e3141mr7510497ejc.213.1649243189374;
        Wed, 06 Apr 2022 04:06:29 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090670c800b006e49b0641ebsm6415423ejk.195.2022.04.06.04.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:06:28 -0700 (PDT)
Message-ID: <47a0164e-c8b7-8418-c965-3d12294553f5@kernel.org>
Date:   Wed, 6 Apr 2022 13:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty: Fix a possible resource leak in icom_probe
Content-Language: en-US
To:     Huang Guobin <huangguobin4@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220331091005.3290753-1-huangguobin4@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220331091005.3290753-1-huangguobin4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31. 03. 22, 11:10, Huang Guobin wrote:
> When pci_read_config_dword failed, call pci_release_regions() and
> pci_disable_device() to recycle the resource previously allocated.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


> Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
> ---
>   drivers/tty/serial/icom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
> index 03a2fe9f4c9a..02b375ba2f07 100644
> --- a/drivers/tty/serial/icom.c
> +++ b/drivers/tty/serial/icom.c
> @@ -1501,7 +1501,7 @@ static int icom_probe(struct pci_dev *dev,
>   	retval = pci_read_config_dword(dev, PCI_COMMAND, &command_reg);
>   	if (retval) {
>   		dev_err(&dev->dev, "PCI Config read FAILED\n");
> -		return retval;
> +		goto probe_exit0;
>   	}
>   
>   	pci_write_config_dword(dev, PCI_COMMAND,


-- 
js
suse labs
