Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F15AC04A6A
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 05:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjHDFKH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 01:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjHDFH6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 01:07:58 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAE54C27
        for <linux-serial@vger.kernel.org>; Thu,  3 Aug 2023 22:07:09 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso1509693f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 03 Aug 2023 22:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691125628; x=1691730428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45bv7PIUuXG3RPuCRQQtbV0lLOkmLUXWPVu+ha94M2k=;
        b=OvJbNA0MhPiuMcE4+kXgLRM2Mxdvyy54GRBcbaf+Aryp57j21YSex42ziwDeFdoKMT
         zZxIP6Qsw0ZN/vI9IqINL24qY4sDArZes6+zX5GJqDsEMgJXPfTsg5LXfu9BhuIevebr
         lj6nsGHvYPR1S0ggFBphkC2nlYPA4yFw48f9zfR/K5Bhl9NobuupP6BwKSBe/4aalMJ6
         uis+96rXvr1MO8IgniednhxlqeuqDpThrW6Q8OaGTIX1kXhx8ERffxwsX2joq880CmiE
         TE0KKvZlYfu2sYRoGT0ho9nQm/xmANrNyjw9hoxHA5+yViSaSRi1VSZHW8qUbDwMH60J
         Xxlg==
X-Gm-Message-State: AOJu0YyEbgpsaGgXjtL++a9bucpU8pEL2BxGO0Diz817r5eOkUhe65Lj
        IcSdoUkVMIGNKc3RKgADpn6w4f5VaqfHiQ==
X-Google-Smtp-Source: AGHT+IFW0x9JwzR9nNoi4y3OLx8hwlEHwnv6vm0ZDb9KTHaHNz4g7KPozzZtOUHQPCdOJxVJpg0zRA==
X-Received: by 2002:adf:f646:0:b0:314:1416:3be3 with SMTP id x6-20020adff646000000b0031414163be3mr366715wrp.70.1691125627516;
        Thu, 03 Aug 2023 22:07:07 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4565000000b0030647449730sm1476930wrc.74.2023.08.03.22.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 22:07:07 -0700 (PDT)
Message-ID: <19b30f4f-c4e4-f186-47ee-943d04219fd7@kernel.org>
Date:   Fri, 4 Aug 2023 07:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH -next] 8250_men_mcb: Fix unsigned expression compared with
 zero
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>, gregkh@linuxfoundation.org,
        jorge.sanjuangarcia@duagon.com, JoseJavier.Rodriguez@duagon.com
Cc:     yangyingliang@huawei.com, andriy.shevchenko@linux.intel.com,
        linux-serial@vger.kernel.org
References: <20230803142053.1308926-1-lizetao1@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230803142053.1308926-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03. 08. 23, 16:20, Li Zetao wrote:
> There is a warning reported by coccinelle:
> 
> ./drivers/tty/serial/8250/8250_men_mcb.c:226:6-19: WARNING:
> 	Unsigned expression compared with zero: data -> line [ i ]     <     0
> 
> The array "line" of serial_8250_men_mcb_data is used to record the
> registered serial port. When register a port failed, it will return
> an error code, but the type of "line" is "unsigned int", causing
> the error code to reverse. Modify the type of "data -> line" to solve
> this problem.
> 
> Fixes: 2554e6ba28a2 ("8250_men_mcb: Read num ports from register data.")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/tty/serial/8250/8250_men_mcb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
> index 5f301195575d..14cf6011a002 100644
> --- a/drivers/tty/serial/8250/8250_men_mcb.c
> +++ b/drivers/tty/serial/8250/8250_men_mcb.c
> @@ -46,7 +46,7 @@
>   
>   struct serial_8250_men_mcb_data {
>   	int num_ports;
> -	unsigned int line[MAX_PORTS];
> +	int line[MAX_PORTS];

LGTM

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

But I wonder why this didn't emit a warning:
   dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data->line[i]);

I.e. %d for uint?

thanks,
-- 
js
suse labs

