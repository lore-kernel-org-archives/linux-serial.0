Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE829C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  7 Jan 2022 08:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbiAGIXU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Jan 2022 03:23:20 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52054 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiAGIXU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Jan 2022 03:23:20 -0500
Received: by mail-wm1-f44.google.com with SMTP id e5so3388436wmq.1
        for <linux-serial@vger.kernel.org>; Fri, 07 Jan 2022 00:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0P9RI3wph960b+6CGRLRmsYi4Dmj1J9+YMyqOgH1634=;
        b=cXqj5Ahu/a9mZ+oB9N+z889W+S+8Omi+YNg3SEEZQI8aNWZqwUG4r4sCCDzDugVvH5
         ntN2ZlYCZE8MHooDhLb/n9e2zetkA/WFpCMhFkXn5NKXiHu9jADdaWCuiKzD+Rc3tlTh
         QefLt3LNIh9QsGbxAAoPbosKecQ9TFYem5DIJ0kBArN7enhW13huBsHWdw/02axfqYh6
         P6AAmyP6k2nEOmuLrDJvBDJe/azsihXkSqPUjDK0fn2F40flbyC3Wb79UTYQyyvM481A
         qKXCqCpY0OiZUYil9PD0wSHGTfRhGnn/2wLscnLam/clz7u/j88HpVQpKN8cB159Hz2O
         huJw==
X-Gm-Message-State: AOAM533q8dVwrdR5PTG2ohdeLD5OouWIMGowAgDNSTtGgSzLk+6Jy6Zo
        A+bvjyEdljGUtxiHtVXkBg0=
X-Google-Smtp-Source: ABdhPJxCto+lF1sANdDJCTlzqkVxK1z7J4WzQjHrpCiLszBBagVdsWQaJzzsITf/m6btKS5o/vYJPw==
X-Received: by 2002:a05:600c:1c9f:: with SMTP id k31mr10029928wms.159.1641543798876;
        Fri, 07 Jan 2022 00:23:18 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id o8sm4946963wry.20.2022.01.07.00.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 00:23:18 -0800 (PST)
Message-ID: <f3848788-822c-2125-0f2e-10f9962d11ba@kernel.org>
Date:   Fri, 7 Jan 2022 09:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] serial: core: Keep mctrl register state and cached copy
 in sync
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Jochen Mades <jochen@mades.net>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>, linux-serial@vger.kernel.org
References: <bceeaba030b028ed810272d55d5fc6f3656ddddb.1641129752.git.lukas@wunner.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <bceeaba030b028ed810272d55d5fc6f3656ddddb.1641129752.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02. 01. 22, 18:52, Lukas Wunner wrote:
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2389,7 +2389,8 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>   		 * We probably don't need a spinlock around this, but

One line above, it states:
--- keep the DTR setting that is set in uart_set_options()

>   		 */
>   		spin_lock_irqsave(&port->lock, flags);
> -		port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
> +		port->mctrl &= TIOCM_DTR;
> +		port->ops->set_mctrl(port, port->mctrl);

So I don't think this is correct -- either the comment is wrong now or 
the code...

thanks,
-- 
js
suse labs
