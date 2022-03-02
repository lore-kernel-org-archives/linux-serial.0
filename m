Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16589C433FE
	for <linux-serial@archiver.kernel.org>; Wed,  2 Mar 2022 11:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiCBLO6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Mar 2022 06:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbiCBLOv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Mar 2022 06:14:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F463606F8
        for <linux-serial@vger.kernel.org>; Wed,  2 Mar 2022 03:14:07 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1F9DD3F601
        for <linux-serial@vger.kernel.org>; Wed,  2 Mar 2022 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646219646;
        bh=c/HrBEq7VXD/vzB2plWQqXVKzKIhpuLhlwaapBvCoq4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZZvYRDF/TkkrYLNl3TiNcu+DN92urcmu0P7BgYyvNvSRA/KAQuj0+hbSgwOakKROo
         O1F0AbDAy6rsHiBpJL2UPgxo2ILfehkBEzPZFZSlhSdKGbc72dV1+/gCl5frakWkpY
         uyZDAt86+K4VaKSZHLty4FtVShq5tmihkIWPsr0s4vKYbYtj/XgSdf8fU0VBFn7f6l
         4cP9lD4XKZPWakf1WJMr2ldMA1DtZ3QTaNbz5Ek3EtHBCkgacI1eYg8nK8i7RwORoB
         v5QnDLow7gVyZNbZSSGOetk6GdIpxLCrVnCiQZ4lq7EQJy2QIDmLgTawkmzznz1p6a
         RiCrgHLE4Rr/Q==
Received: by mail-ej1-f72.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so813753ejk.16
        for <linux-serial@vger.kernel.org>; Wed, 02 Mar 2022 03:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c/HrBEq7VXD/vzB2plWQqXVKzKIhpuLhlwaapBvCoq4=;
        b=1skHK9DFbCt+DpWUNNdZnpJVdT1b0tpoan/+PJBjJTLFahhLw0nN+j97XPnD3mXMn0
         F+ggt/QImHWJ9lBcVpBqT4gHzgNVxCE2U6gWy7Ih8P3wJiV1bVu7CCRx2e5+pO6eXrM9
         mELkdJHtZecjQh4Sdzb1kQMWj+VV4KQ3UdJPfNJ3o+UwsgryjGRGhaQvbDyqIkoq8z0H
         J6nm6qyUobktP0hBxD/HXQkYrtdqQi7jaXlex8FJ25TsbBfkWXH2qYSrv35tHfpdczup
         UauDjsujnO80YVD7lsiAVC2BMxoPdBEoRkQRBXv2sc7Z3MZxiN1HZKL8zH57AJXiRIY5
         +bLg==
X-Gm-Message-State: AOAM530o9pHFuPmHNT5DXmQY5rp7WAOGdogKF7/bDOlv/qFlUkMhDSVP
        gDIELiWfMkEDHPWbk/ef3SYiNQPUo3fNMoMbjNnYbPJwicGk4nsICvxFOyQfBYvnZbqaoqpZ33z
        nDmxgr1cPNuEtieyEiglGi4nGPjKI8NxUP9YYr5Rlfg==
X-Received: by 2002:a17:907:a41f:b0:6d6:f925:1696 with SMTP id sg31-20020a170907a41f00b006d6f9251696mr4947750ejc.62.1646219645737;
        Wed, 02 Mar 2022 03:14:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4eItwRYHbFhHJecp/z62mEUFQa+5CGvwbfF4FEcKbfj5pKDOx0k/F7sIT5mVv7fPze2379A==
X-Received: by 2002:a17:907:a41f:b0:6d6:f925:1696 with SMTP id sg31-20020a170907a41f00b006d6f9251696mr4947744ejc.62.1646219645563;
        Wed, 02 Mar 2022 03:14:05 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id vl11-20020a17090730cb00b006d8121d0fc4sm857414ejb.138.2022.03.02.03.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 03:14:04 -0800 (PST)
Message-ID: <c13930a5-85ab-5a2c-54e5-15fc5bc87b17@canonical.com>
Date:   Wed, 2 Mar 2022 12:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] serial: samsung: Add samsung_early_read to support early
 kgdboc
Content-Language: en-US
To:     Woody Lin <woodylin@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, markcheng@google.com
References: <20220302101925.210810-1-woodylin@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220302101925.210810-1-woodylin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02/03/2022 11:19, Woody Lin wrote:
> The 'kgdboc_earlycon_init' looks for boot console that has both .read
> and .write callbacks. Adds 'samsung_early_read' to samsung_tty.c's early
> console to support kgdboc.
> 
> Signed-off-by: Woody Lin <woodylin@google.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d002a4e48ed9..eeb30d016ff1 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2949,6 +2949,7 @@ static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
>  
>  struct samsung_early_console_data {
>  	u32 txfull_mask;
> +	u32 rxfifo_mask;
>  };
>  
>  static void samsung_early_busyuart(struct uart_port *port)
> @@ -2983,6 +2984,26 @@ static void samsung_early_write(struct console *con, const char *s,
>  	uart_console_write(&dev->port, s, n, samsung_early_putc);
>  }
>  
> +static int samsung_early_read(struct console *con, char *s, unsigned int n)
> +{
> +	struct earlycon_device *dev = con->data;
> +	struct samsung_early_console_data *data = dev->port.private_data;

This can be const.

Rest looks ok.


Best regards,
Krzysztof
