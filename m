Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9A4C07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 06:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5FD613AF
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 06:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhGNG77 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 02:59:59 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36594 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbhGNG77 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 02:59:59 -0400
Received: by mail-wr1-f42.google.com with SMTP id v5so1846382wrt.3;
        Tue, 13 Jul 2021 23:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VhK975TeGNNyvZ4Fkw5/IuH4eLLeWHK0uf+OS1Uzh0M=;
        b=f7ZY739VsT7y8UaTnSqPUtXjWWnmTEE77aZFYga5yv05hoYrnU2ObWjVpMW93WbaJJ
         VZllACxH5NfZnIpL68+n5sCNSfPEj1dMk+LBnRTnD1DIRnI9Nl7u/zvcT5psDG4ndSAB
         PbqeGADxl0PX7x0Uv5gvpqeWi5yPXo63TDQAhMV9ZTvPffMT/sFYNaRzmG5YbMhNk7+X
         iWlVU8X6O1n8nrI4HNksZ2huV3uEjNCEw7vmDRqA3n92t+lkSoELQIeOK4wjvea0Og83
         Q29hHD+ME4tdNZGbyPXOr3r/32unL81lmHm7qLNcn1xEY5xIHci35Sf730Auvc61SG85
         P6lQ==
X-Gm-Message-State: AOAM530m/c9nm8MEDSFKIl1fsgiGR9lXaG3YcfyxkpH40Fx1zdih6//o
        ziHcnttItyB7d37k1jgluLw=
X-Google-Smtp-Source: ABdhPJyL9/9bP39IyZtaVdQS+RhLxXtpjFjcNa/dxj/xvBzmRdG+TFCw+mfAfK7cTqEsjH7ckD0N1Q==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr10532450wrw.81.1626245827528;
        Tue, 13 Jul 2021 23:57:07 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id u12sm1388132wrt.50.2021.07.13.23.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 23:57:06 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] serial: 8250_pci: Refactor the loop in
 pci_ite887x_init()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <136e3881-bff4-d1f0-e146-b5c0a58f2e80@kernel.org>
Date:   Wed, 14 Jul 2021 08:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13. 07. 21, 12:40, Andy Shevchenko wrote:
> The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
> This reduces code base and makes it easier to read and understand.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 02985cf90ef2..b9138bd08b7f 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -897,37 +897,31 @@ static int pci_netmos_init(struct pci_dev *dev)
>   /* enable IO_Space bit */
>   #define ITE_887x_POSIO_ENABLE		(1 << 31)
>   
> +/* inta_addr are the configuration addresses of the ITE */
> +static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0, 0x200, 0x280, };
>   static int pci_ite887x_init(struct pci_dev *dev)
>   {
> -	/* inta_addr are the configuration addresses of the ITE */
> -	static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0,
> -							0x200, 0x280, 0 };
>   	int ret, i, type;
>   	struct resource *iobase = NULL;
>   	u32 miscr, uartbar, ioport;
>   
>   	/* search for the base-ioport */
> -	i = 0;
> -	while (inta_addr[i] && iobase == NULL) {
> -		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE,
> -								"ite887x");
> +	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
> +		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE, "ite887x");

Irrelevant whitespace change.

>   		if (iobase != NULL) {
>   			/* write POSIO0R - speed | size | ioport */
>   			pci_write_config_dword(dev, ITE_887x_POSIO0,
>   				ITE_887x_POSIO_ENABLE | ITE_887x_POSIO_SPEED |
>   				ITE_887x_POSIO_IOSIZE_32 | inta_addr[i]);
>   			/* write INTCBAR - ioport */
> -			pci_write_config_dword(dev, ITE_887x_INTCBAR,
> -								inta_addr[i]);
> +			pci_write_config_dword(dev, ITE_887x_INTCBAR, inta_addr[i]);

detto

>   			ret = inb(inta_addr[i]);
>   			if (ret != 0xff) {
>   				/* ioport connected */
>   				break;
>   			}
>   			release_region(iobase->start, ITE_887x_IOSIZE);
> -			iobase = NULL;
>   		}
> -		i++;
>   	}
>   
>   	if (!inta_addr[i]) {

OOB access?

regards,
-- 
js
suse labs
