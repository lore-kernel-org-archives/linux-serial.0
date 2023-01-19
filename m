Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4495FC004D4
	for <linux-serial@archiver.kernel.org>; Thu, 19 Jan 2023 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjASSIG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASSIF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Jan 2023 13:08:05 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DA8C93F
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 10:08:04 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A550484FB4;
        Thu, 19 Jan 2023 19:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674151681;
        bh=Ii12jcDAK7YD6O3XO2bgMykCgwoWVXC+eJf3L5b/ufQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rT03gg7qmKF4tgoVCxoZ0mMHIwBS9kKCM4ZWmMcU5Is06LmNkeeNTJa2cG2ZUAMLr
         19+yiqg6p+aTUAI98UQ4QgVBLn0ZK82jWb4jnOp3KotWBalKXRr8qkRlHF+0fb+3a6
         BirKgYsMr4MrhRvYaKurqisfvSe+272p/ZNgkJpOAzA2G7LyIPOOqWHXFpN+jlgBxd
         49xSa3J+w+cwu6KXcrH4rYwikwUwksBpGKAo8dSv5Wirn/aTGFi/iZ+csktb5gfS69
         YhJuoPScJ2M5pYiHzzToD4/b8MU7R0JLYjOrgOnunDQFLv7DV4moNZTIODhsihsVIP
         xv880izBaeWGQ==
Message-ID: <f5f4b504-8e58-2844-fa26-c8896a625794@denx.de>
Date:   Thu, 19 Jan 2023 19:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [tty:tty-linus 4/7] drivers/tty/serial/stm32-usart.c:804:62:
 error: 'flags' undeclared
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johan Hovold <johan@kernel.org>
References: <202301200130.ttBiTzfO-lkp@intel.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <202301200130.ttBiTzfO-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/19/23 18:33, kernel test robot wrote:

[...]

> cc58d0a3f0a475 Erwan Le Ray     2021-10-20  800  	/* Receiver timeout irq for DMA RX */
> f24771b62a8323 Marek Vasut      2023-01-12  801  	if (stm32_usart_rx_dma_enabled(port) && !stm32_port->throttled) {
> f24771b62a8323 Marek Vasut      2023-01-12  802  		spin_lock(&port->lock);
> 6333a485062172 Erwan Le Ray     2021-10-25  803  		size = stm32_usart_receive_chars(port, false);
> 6333a485062172 Erwan Le Ray     2021-10-25 @804  		uart_unlock_and_check_sysrq_irqrestore(port, flags);

+CC Johan

This one should be uart_unlock_and_check_sysrq(port); I think . If 
that's correct, then I'll send a patch.

> 6333a485062172 Erwan Le Ray     2021-10-25  805  		if (size)
> 6333a485062172 Erwan Le Ray     2021-10-25  806  			tty_flip_buffer_push(tport);
> 6333a485062172 Erwan Le Ray     2021-10-25  807  	}

[...]
