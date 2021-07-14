Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5047C07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 06:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3893613B2
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 06:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbhGNG5f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 02:57:35 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41780 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbhGNG5e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 02:57:34 -0400
Received: by mail-wr1-f45.google.com with SMTP id k4so1809975wrc.8;
        Tue, 13 Jul 2021 23:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=krbJiHzO9v7NiomaRq+vI2Zouy+TLw2zKDa7Ig1bng0=;
        b=ICKdiKx0Uo3z5XWzvsX9d2kOsYbzyh9YWED+Dp3CG2gGGN8jQ50a+fsMhFLNTMPkhx
         1l3oFvVt5B19WGcJjIo559vuww5ZV/j+0NkHj25+PLM46Tx+5RBQSwdrfi1M4tVU45sN
         2Tl4AwXh5kkBP1q6h9JX6t8B6msSA8TrhIVzYTIssg6UOzCxp8Ae2KuBgUNvo7WmPZAv
         4OQVynroNZmaw8qNT7U/TaFw9bsY+7KFtrYCVWq7u2O/pbXWWtQ2mGBJTx/h1tiZvPJI
         KYUe9A3KtxoQJEgC/Kh9ORlMggp5ae//C1bBywBAwq4VlAFlieV+kOFA3oE/zetbSJn7
         jTAw==
X-Gm-Message-State: AOAM532Tt6ef/uPBusGRR9ce8YtUhXniXsqgP9WvdyCkgUePnVqeR5Rn
        1ggG7ihGL1dRF+bUrg5wNdQ=
X-Google-Smtp-Source: ABdhPJzJ1pu7xDxgzV2No4aaHhVSpHGm2+EaKL+TXWjLPszrmlvx6Mt1de12V59EYRDe/0tQatOhQA==
X-Received: by 2002:a5d:6dd2:: with SMTP id d18mr11005264wrz.94.1626245681918;
        Tue, 13 Jul 2021 23:54:41 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o3sm1359925wrm.5.2021.07.13.23.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 23:54:41 -0700 (PDT)
Subject: Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
Date:   Wed, 14 Jul 2021 08:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13. 07. 21, 12:40, Andy Shevchenko wrote:
> There is no need to try MSI/MSI-X only on selected devices.
> If MSI is not supported while neing advertised it means device

being

> is broken and we rather introduce a list of such devices which
> hopefully will be small or never appear.

Hmm, have you checked the commit which introduced the whitelist?

     Nevertheless, this needs to handled with care: while many 8250 devices
     actually claim to support MSI(-X) interrupts it should not be 
enabled be
     default. I had at least one device in my hands with broken MSI
     implementation.

     So better introduce a whitelist with devices that are known to support
     MSI(-X) interrupts. I tested all devices mentioned in the patch.


You should have at least CCed the author for an input.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 28 ++++++++--------------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 937861327aca..02825c8c5f84 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -58,18 +58,6 @@ struct serial_private {
>   
>   #define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
>   
> -static const struct pci_device_id pci_use_msi[] = {
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
> -			 0xA000, 0x1000) },
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
> -			 0xA000, 0x1000) },
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
> -			 0xA000, 0x1000) },
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
> -			 PCI_ANY_ID, PCI_ANY_ID) },
> -	{ }
> -};
> -
>   static int pci_default_setup(struct serial_private*,
>   	  const struct pciserial_board*, struct uart_8250_port *, int);
>   
> @@ -3994,14 +3982,9 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
>   	if (board->flags & FL_NOIRQ) {
>   		uart.port.irq = 0;
>   	} else {
> -		if (pci_match_id(pci_use_msi, dev)) {
> -			dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
> -			pci_set_master(dev);
> -			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
> -		} else {
> -			dev_dbg(&dev->dev, "Using legacy interrupts\n");
> -			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
> -		}
> +		pci_set_master(dev);

But bus mastering is not about MSIs. I *think* it's still OK, but you 
need to document that in the commit log too.

Actually, why the commit which added this code turns on bus mastering?

> +
> +		rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
>   		if (rc < 0) {
>   			kfree(priv);
>   			priv = ERR_PTR(rc);
> @@ -4009,6 +3992,11 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
>   		}
>   
>   		uart.port.irq = pci_irq_vector(dev, 0);
> +
> +		if (pci_dev_msi_enabled(dev))
> +			dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
> +		else
> +			dev_dbg(&dev->dev, "Using legacy interrupts\n");
>   	}
>   
>   	uart.port.dev = &dev->dev;
> 

thanks,
-- 
js
suse labs
