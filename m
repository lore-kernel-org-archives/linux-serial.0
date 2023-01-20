Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201A0C05027
	for <linux-serial@archiver.kernel.org>; Fri, 20 Jan 2023 16:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjATQEg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjATQEf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Jan 2023 11:04:35 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE524707F7
        for <linux-serial@vger.kernel.org>; Fri, 20 Jan 2023 08:04:34 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 466948543D;
        Fri, 20 Jan 2023 17:04:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674230673;
        bh=ChEFTyvP1yoNSN5rPCf8s5E4q+z4hqiovucKLUipOBA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dpNpICU3MaINFIQjL+wTLSoVUJovvHaFaYyGSpnziNZRpoLjlaNmmdvR2Dz5FIDOK
         M1f+jMXjQAPXcmA1gPDaPfO2gJBO6LvJqpt5ZbwFgFXjvX3N78ekEP2zxFk64YaVQk
         eFCZNIiKJq2TJr7PAy8mtzhwY4G/UiAuHKM/KvLMWxdAXDKiE4f/7gk3IUD4PXsqIX
         cDIRTVSimORRYcdBZi73H3KM5ejDVb+wdep0ivxf0n+bpob8FF9cYa/L1vl6YjsZrd
         L4HQwWdu4kOuz5gAl3tCDer4BjbtyYG7M6stnBpxpUb5qDHStTZH5ymB8zdJUpR1fy
         BTCKIxFwd4RDA==
Message-ID: <7369bb81-782f-0c2e-8eee-c4b7dd8e13ae@denx.de>
Date:   Fri, 20 Jan 2023 17:04:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [tty:tty-linus 4/7] drivers/tty/serial/stm32-usart.c:804:62:
 error: 'flags' undeclared
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <202301200130.ttBiTzfO-lkp@intel.com>
 <f5f4b504-8e58-2844-fa26-c8896a625794@denx.de>
 <Y8pJNKb103VZvEpD@hovoldconsulting.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y8pJNKb103VZvEpD@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/20/23 08:56, Johan Hovold wrote:
> On Thu, Jan 19, 2023 at 07:08:00PM +0100, Marek Vasut wrote:
>> On 1/19/23 18:33, kernel test robot wrote:
>>
>> [...]
>>
>>> cc58d0a3f0a475 Erwan Le Ray     2021-10-20  800  	/* Receiver timeout irq for DMA RX */
>>> f24771b62a8323 Marek Vasut      2023-01-12  801  	if (stm32_usart_rx_dma_enabled(port) && !stm32_port->throttled) {
>>> f24771b62a8323 Marek Vasut      2023-01-12  802  		spin_lock(&port->lock);
>>> 6333a485062172 Erwan Le Ray     2021-10-25  803  		size = stm32_usart_receive_chars(port, false);
>>> 6333a485062172 Erwan Le Ray     2021-10-25 @804  		uart_unlock_and_check_sysrq_irqrestore(port, flags);
>>
>> +CC Johan
>>
>> This one should be uart_unlock_and_check_sysrq(port); I think . If
>> that's correct, then I'll send a patch.
> 
> That should be it. Next time, please compile-test your patches...

Sorry about that. I did a rebuild, retest on the hardware itself, and 
sent V6. I wonder why the bot didn't detect the build failure however.
