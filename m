Return-Path: <SRS0=cVGZ=DO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD88C47095
	for <linux-serial@archiver.kernel.org>; Wed,  7 Oct 2020 12:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BFD207EA
	for <linux-serial@archiver.kernel.org>; Wed,  7 Oct 2020 12:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgJGMA4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgJGMAz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Oct 2020 08:00:55 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7F920782;
        Wed,  7 Oct 2020 12:00:53 +0000 (UTC)
Subject: Re: [PATCH] serial: mcf: add sysrq capability
To:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        gregkh@linuxfoundation.org
Cc:     linux-m68k@vger.kernel.org, linux-serial@vger.kernel.org
References: <20201002140545.477481-1-angelo.dureghello@timesys.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <5d1e1ebd-93f4-adb7-fb94-57aafd2cca81@linux-m68k.org>
Date:   Wed, 7 Oct 2020 22:00:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002140545.477481-1-angelo.dureghello@timesys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Angelo,

On 3/10/20 12:05 am, Angelo Dureghello wrote:
> After some unsuccessful attempts to use sysrq over console, figured
> out that port->has_sysrq should likely be enabled, as per other
> architectures, this when CONFIG_SERIAL_MCF_CONSOLE is also enabled.
> 
> Tested some magic sysrq commands (h, p, t, b), they works now
> properly. Commands works inside 5 secs after BREAK is sent, as
> expected.
> 
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

I can take this via the m68knommu git tree if no one else wants to pick 
it up?

Regards
Greg


> ---
>   drivers/tty/serial/mcf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> index 7dbfb4cde124..09c88c48fb7b 100644
> --- a/drivers/tty/serial/mcf.c
> +++ b/drivers/tty/serial/mcf.c
> @@ -632,6 +632,7 @@ static int mcf_probe(struct platform_device *pdev)
>   		port->ops = &mcf_uart_ops;
>   		port->flags = UPF_BOOT_AUTOCONF;
>   		port->rs485_config = mcf_config_rs485;
> +		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
>   
>   		uart_add_one_port(&mcf_driver, port);
>   	}
> 
