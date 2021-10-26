Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C258C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 05:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FAC60EFE
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 05:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhJZF2q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:28:46 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42730 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhJZF2o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 01:28:44 -0400
Received: by mail-wr1-f44.google.com with SMTP id v17so15589668wrv.9;
        Mon, 25 Oct 2021 22:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QCOpNWMQHq0JP7LTqMksUMzAWXQ2KfRvHx6KBsoATiI=;
        b=wNZF8Qlw31fRWd3uC6l9wjQcJ/NKFwMHWJ2JGaW7bvKR8m6lY/FLEIfeTlLWDsEBby
         y3jrh2v6xxwqeVdAeGUJRqKNB/dIWRL9ppkC8n4c1Zpb0l0gAl53vnnBnc4i8HJ69wnN
         pqw0HP48xd2dizByI2bIbBWOvSjVGkJVwFq8ioBmU6NFj/mGEJIjnJb8Mcn70vjHLtzV
         WsbZ0ZvnLmJoB8NEf5II7s+onaPCPX9c3APD2lqLQyL8bCqUao7gJpwTS9IoorWOTXjs
         MrbBcudtfoGwY6SuBKg9wtEEPlbj8omGTRsVLtu7mNpPrVo1WtG8CgLy5zKbXpqisnov
         RlFA==
X-Gm-Message-State: AOAM530xMmRD3VhJYNDPkUBEHamHuI53KcWvttg6T6A8reQfjIGA6aZP
        HDfqI+G2v94oeh85GNR+9Y8=
X-Google-Smtp-Source: ABdhPJzJ5wQ7oG3EwiF14DN7IM6zr1+ZRI9gG7Y02OCMN9wBfJELfoBigrDxKVxUceX+VlyPgplqZg==
X-Received: by 2002:adf:ba0d:: with SMTP id o13mr28409228wrg.339.1635225980321;
        Mon, 25 Oct 2021 22:26:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id g77sm199675wmg.31.2021.10.25.22.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 22:26:19 -0700 (PDT)
Message-ID: <db3f31f4-46ed-0b6b-89a5-b3cb447e0fa7@kernel.org>
Date:   Tue, 26 Oct 2021 07:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/3] serial: 8250_pci: Refactor the loop in
 pci_ite887x_init()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22. 10. 21, 15:51, Andy Shevchenko wrote:
> The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
> This reduces code base and makes it easier to read and understand.

Why don't we have array_for_each() BTW?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jiri Slaby <jslaby@kernel.org>

> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -897,18 +897,16 @@ static int pci_netmos_init(struct pci_dev *dev)
>   /* enable IO_Space bit */
>   #define ITE_887x_POSIO_ENABLE		(1 << 31)
>   
> +/* inta_addr are the configuration addresses of the ITE */
> +static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0, 0x200, 0x280 };

/me thinks about 'unsigned'.

-- 
js
suse labs
