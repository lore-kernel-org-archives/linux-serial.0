Return-Path: <SRS0=oIqV=4B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292E5C2BA83
	for <linux-serial@archiver.kernel.org>; Thu, 13 Feb 2020 11:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FB3222C2
	for <linux-serial@archiver.kernel.org>; Thu, 13 Feb 2020 11:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KJWXfYPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgBMLzd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:55:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:58211 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMLzd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Feb 2020 06:55:33 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48JFM44nsvz9vC11;
        Thu, 13 Feb 2020 12:55:28 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=KJWXfYPu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wAM0AcDhPoiW; Thu, 13 Feb 2020 12:55:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48JFM43T1Qz9vC10;
        Thu, 13 Feb 2020 12:55:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581594928; bh=Rrbw8RVt/xSUKxa7Q0zKFqi6LP7mXV3jDI44d43PGuA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KJWXfYPuarHKovP9WzhGQjgpCzoGk0NZtnunr96zCcG0tIm4aC70u27tLnrfoqIIl
         ZVLTktzaHpTVXLBrGoYCQ8wU6Dzowxs+jBXlG8+cTU/Cgxpc/9WRlPaiIn31H8XwtV
         b/Jw5mDFUdWEqvhfmeWoyQc6/yilYcmI1ECXbxqc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B47338B845;
        Thu, 13 Feb 2020 12:55:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4iZciwIiPN-4; Thu, 13 Feb 2020 12:55:29 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CD85D8B842;
        Thu, 13 Feb 2020 12:55:28 +0100 (CET)
Subject: Re: [PATCH] serial: cpm_uart: call cpm_muram_init before registering
 console
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200213114342.21712-1-linux@rasmusvillemoes.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d8d006d1-dff9-251e-acde-f02f66205d7d@c-s.fr>
Date:   Thu, 13 Feb 2020 12:55:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200213114342.21712-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Le 13/02/2020 à 12:43, Rasmus Villemoes a écrit :
> Christophe reports that powerpc 8xx silently fails to 5.6-rc1. It turns
> out I was wrong about nobody relying on the lazy initialization of the
> cpm/qe muram in commit b6231ea2b3c6 (soc: fsl: qe: drop broken lazy
> call of cpm_muram_init()).
> 
> Rather than reinstating the somewhat dubious lazy call (initializing a
> currently held spinlock, and implicitly doing a GFP_KERNEL under that
> spinlock), make sure that cpm_muram_init() is called early enough - I
> thought the calls from the subsys_initcalls were good enough, but when
> used by console drivers, that's obviously not the
> case. cpm_muram_init() is safe to call twice (there's an early return
> if it is already initialized), so keep the call from cpm_init() - in
> case SERIAL_CPM_CONSOLE=n.
> 
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: b6231ea2b3c6 (soc: fsl: qe: drop broken lazy call of cpm_muram_init())
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> 
> Christophe, can I get you to add a formal Tested-by?
> 
> I'm not sure which tree this should go through.
> 
>   drivers/tty/serial/cpm_uart/cpm_uart_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> index 19d5a4cf29a6..d4b81b06e0cb 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> @@ -1373,6 +1373,7 @@ static struct console cpm_scc_uart_console = {
>   
>   static int __init cpm_uart_console_init(void)
>   {
> +	cpm_muram_init();
>   	register_console(&cpm_scc_uart_console);
>   	return 0;
>   }
> 
