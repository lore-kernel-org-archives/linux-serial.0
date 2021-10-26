Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668BC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 05:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B932C6103C
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 05:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhJZFXL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:23:11 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36444 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhJZFXK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 01:23:10 -0400
Received: by mail-wr1-f42.google.com with SMTP id i9so1040985wrc.3;
        Mon, 25 Oct 2021 22:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yFlVmKQBJo/sWgYMQgtWUvO8IA3BCGM6PavVxO/iPFE=;
        b=yGm350lhoLJh+aBGvxZYnv4lMRwr+j5cw1ePzkDZubJC230lWkI/WoAsFFd4wmcEbC
         oPdSTOZR3gNfPUEHIa3oIecT0Hf2ohoQlp3rtYHqF2JQhJCm3rSyh8OEiU1miVV35eT1
         Y8IlZh4vzjR5zKev/PjIsp1iMfmU6SviL7p54Uz8e4RmoXKGR0b7rCFRjn4dpVONfvul
         9meiT0T9DdA1rubLkDJWTCKH0fKP4EZmDZmdQYJ8+tVp7xKTJEEuIcX7Z1TCFLkf+6Ap
         DVQynGOnoAga+IEJOAip4TODAkNM9VD5Ksb3562wdufT+95BmAgNOfYQEI2SF9snj/g9
         EEhg==
X-Gm-Message-State: AOAM531qAtVY+kAtrtUOapkfGKqOF40phZ569RjXvM3gj3npD+EjAvwH
        qhs1mX/L3xurd3QaFllPXMdhoiysIxk=
X-Google-Smtp-Source: ABdhPJwrOyp2LQVlD5zlBYVgV4F7qCPpD/BDxzIk0ebgtDMjaf22QQGxbqPeiSCVDTOWV17bV26tdQ==
X-Received: by 2002:a05:6000:144e:: with SMTP id v14mr23853450wrx.9.1635225646606;
        Mon, 25 Oct 2021 22:20:46 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c7sm14906547wrp.51.2021.10.25.22.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 22:20:46 -0700 (PDT)
Message-ID: <9f7e1a82-7afc-b4e6-77b8-699607d5c994@kernel.org>
Date:   Tue, 26 Oct 2021 07:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] serial: 8250_pci: Replace dev_*() by pci_*()
 macros
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
 <20211022135147.70965-3-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211022135147.70965-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22. 10. 21, 15:51, Andy Shevchenko wrote:
> PCI subsystem provides convenient shortcut macros for message printing.
> Use those macros instead of dev_*().

Hopefully they are preferred by the PCI maintainer too :)...

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jiri Slaby <jslaby@kernel.org>

> ---
> v2: dropped unrelated change (Joe)
>   drivers/tty/serial/8250/8250_pci.c | 52 +++++++++++++-----------------
>   1 file changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 463b2c71da6f..aea12263a1ff 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -75,13 +75,12 @@ static int pci_default_setup(struct serial_private*,
>   
>   static void moan_device(const char *str, struct pci_dev *dev)
>   {
> -	dev_err(&dev->dev,
> -	       "%s: %s\n"
> +	pci_err(dev, "%s\n"
>   	       "Please send the output of lspci -vv, this\n"
>   	       "message (0x%04x,0x%04x,0x%04x,0x%04x), the\n"
>   	       "manufacturer and name of serial board or\n"
>   	       "modem board to <linux-serial@vger.kernel.org>.\n",
> -	       pci_name(dev), str, dev->vendor, dev->device,
> +	       str, dev->vendor, dev->device,
>   	       dev->subsystem_vendor, dev->subsystem_device);
>   }
>   
...

-- 
js
suse labs
