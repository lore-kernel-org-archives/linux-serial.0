Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF19DC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 05:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FC16103C
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 05:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhJZFX2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:23:28 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:46667 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhJZFX1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 01:23:27 -0400
Received: by mail-wm1-f48.google.com with SMTP id 83-20020a1c0456000000b0032cb02544aaso901935wme.5;
        Mon, 25 Oct 2021 22:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KpIMXljSkpWfrVfYZnrE4DEBfDZICSQQe+jQVt49vfU=;
        b=BEKUv8y+3aeMVQVjM6VHRzEzQEln7WOeuj3fkRGWKB0icOkTZfNERuZTlm6yDcd+xr
         ONFfgjsT3ujVHD1Ebt0yTbxube2+0M5doU0poK0gbm/Cv+v5vd2zmJegBHvKk+Zzt6PY
         ockzhjmih8gUhkSQ91dimEOJe59V7QCtOvrU1Uns+UcEOgHVmhW6OFZzbAwZOcKy4sIv
         8QhCmT6T1kwmMjeKn52EhIgo3K/IXQOxDiErjbMxyS3pqrl4TovlnorLpoMLIcTLxtJp
         VNHsqEumQhKUy4UvpdElvJbedK1jzh5TQKKpzzGDHQvxxzEHtq/QS8JwzWv9dhyrYH4u
         p5Kw==
X-Gm-Message-State: AOAM530WFH2jmJ7Y+/LCNfP8494Tqr1NikI4eyt0Pny0fhQU0+Ut2frv
        BUEvVVPclRZ3ulrUfnT4k4I=
X-Google-Smtp-Source: ABdhPJxRFff+9Q9aHTGZ2pfZO8yqlEIyxpLr0fOcwEOeU78Q/kRTdtAtBr7KNzCaca/0fvx3Vhq5tg==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr24944988wmj.23.1635225663198;
        Mon, 25 Oct 2021 22:21:03 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id k17sm1065883wmj.0.2021.10.25.22.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 22:21:02 -0700 (PDT)
Message-ID: <3ea8b7f1-292c-8710-e094-55ed409f0a37@kernel.org>
Date:   Tue, 26 Oct 2021 07:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/3] serial: 8250_pci: Get rid of redundant 'else'
 keyword
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
 <20211022135147.70965-2-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211022135147.70965-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22. 10. 21, 15:51, Andy Shevchenko wrote:
> The 'else' keyword is not needed when previous conditional branch returns
> to the upper layer. Get rid of redundant 'else' keyword in such cases.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jiri Slaby <jslaby@kernel.org>

> ---
> v2: avoided changes in Pericom code for now (it makes sense to split support
>      to a separate driver)
>   drivers/tty/serial/8250/8250_pci.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 8a2f42507c18..463b2c71da6f 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -515,7 +515,7 @@ static int pci_siig_init(struct pci_dev *dev)
>   
>   	if (type == 0x1000)
>   		return pci_siig10x_init(dev);
> -	else if (type == 0x2000)
> +	if (type == 0x2000)
>   		return pci_siig20x_init(dev);
>   
>   	moan_device("Unknown SIIG card", dev);
> @@ -792,9 +792,9 @@ static int pci_netmos_9900_setup(struct serial_private *priv,
>   		bar = 3 * idx;
>   
>   		return setup_port(priv, port, bar, 0, board->reg_shift);
> -	} else {
> -		return pci_default_setup(priv, board, port, idx);
>   	}
> +
> +	return pci_default_setup(priv, board, port, idx);
>   }
>   
>   /* the 99xx series comes with a range of device IDs and a variety
> 


-- 
js
suse labs
