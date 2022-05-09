Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC68C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  9 May 2022 10:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiEIKtQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 May 2022 06:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiEIKsf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 May 2022 06:48:35 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C72D571B
        for <linux-serial@vger.kernel.org>; Mon,  9 May 2022 03:42:36 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id v12so18785712wrv.10
        for <linux-serial@vger.kernel.org>; Mon, 09 May 2022 03:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8KhRVPiyyzmtYvvR6LQQ/69Rt4J42pVkG553wbRLSPk=;
        b=y+KU5GTvdv6g7W72iqbXdzAH5R6U0l2bJclS0Vxw1fH+UolJ8gXsx4TOXTB/DsXlE0
         qh0+JhWnzGv33gkbqVdyHrWW5kXR2QC7AwLlyLxKxgPvobsdsmdMWjhewYseI4V4mn97
         N+hACwhw5Dv6t0ANiboho64PgPKqdoWbN55fTBCphVnIAnL8DtTkUiJDqtPuwcX8Ylu4
         X6+ZE//tj3oaS19evfpyyb3KOfoUhDVx/xlMHPYxjEUmLSPbqbHpq1ASw34/UNLshQUN
         g66myic9eVsNNm+PpXZzQr68IGtMdrnKljA+BQPFY97IBWF8PBeHKZn+s7BOzS2hAtm5
         T5zQ==
X-Gm-Message-State: AOAM530JIybsf99ENtXI/33ddTpiRQwzJVfCJ046HVn+VZwAWxtbxEG3
        4/nXex/lNvcP14RUchPnJN7wj/glS6pn3g==
X-Google-Smtp-Source: ABdhPJxNyPh08WG1JsCJXDG7vbbMiQsXv4fzTiNcAaBqHbXf0QPgwBGKs00HSwZLUgfwK9F6ROcENA==
X-Received: by 2002:a5d:4dd1:0:b0:20a:d74d:e33b with SMTP id f17-20020a5d4dd1000000b0020ad74de33bmr13183553wru.222.1652092926968;
        Mon, 09 May 2022 03:42:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c069200b003942a244f3bsm15961819wmn.20.2022.05.09.03.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:42:06 -0700 (PDT)
Message-ID: <907f41dd-aa3b-1456-6fac-b7014c791641@kernel.org>
Date:   Mon, 9 May 2022 12:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RESEND] serial: men_z135_uart: Drop duplicated iotype
 assignment
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
References: <14b71e1-2396-3d83-3a97-9582765d453@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <14b71e1-2396-3d83-3a97-9582765d453@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04. 05. 22, 9:28, Ilpo Järvinen wrote:
> The driver assigns same iotype twice. Drop one of them.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> 
> Resending with correct linux-serial address.
> 
>   drivers/tty/serial/men_z135_uart.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
> index 9acae5f8fc32..12117b596e73 100644
> --- a/drivers/tty/serial/men_z135_uart.c
> +++ b/drivers/tty/serial/men_z135_uart.c
> @@ -833,7 +833,6 @@ static int men_z135_probe(struct mcb_device *mdev,
>   	uart->port.iotype = UPIO_MEM;
>   	uart->port.ops = &men_z135_ops;
>   	uart->port.irq = mcb_get_irq(mdev);
> -	uart->port.iotype = UPIO_MEM;
>   	uart->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP;
>   	uart->port.line = line++;
>   	uart->port.dev = dev;
> 


-- 
js
suse labs
