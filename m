Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6900BC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4264B206F1
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="U+R7YMx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgFVJ5z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:57:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:23001 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726644AbgFVJ5z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jun 2020 05:57:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592819875; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=3R5w2KEWT/yYAx9+GKzCOwZ8GTTxDaMVhNRD10JDpdI=; b=U+R7YMx4JauQtNLgpzU8+6mb+bJpo1JFSvl9rEBQk9Gi4+I4kB7ElpGJFuORg+hDdTihzHt9
 JUYITVk+2OcufEjtXQeJ3a1dH/ISJ7IGtEz0GFkXk7iCT4qY4uwlLMah8DL7EoIpl+SIfv2z
 TE+B+Ybi0Rzsr7hyXnSvs7bCNuw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ef080a08fe116ddd97f2679 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 09:57:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA3A7C43391; Mon, 22 Jun 2020 09:57:51 +0000 (UTC)
Received: from [192.168.43.8] (unknown [106.213.171.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msavaliy)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1BF8C433C6;
        Mon, 22 Jun 2020 09:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1BF8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msavaliy@codeaurora.org
Subject: Re: [PATCH V5] serial: msm_geni_serial_console : Add Earlycon support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
References: <20200522124306.17859-1-msavaliy@codeaurora.org>
 <20200522131308.GB1629195@kroah.com>
From:   "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Message-ID: <8aa2b407-f128-a679-defe-f66885e0ccee@codeaurora.org>
Date:   Mon, 22 Jun 2020 15:27:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200522131308.GB1629195@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 5/22/2020 6:43 PM, Greg KH wrote:
> On Fri, May 22, 2020 at 06:13:06PM +0530, Mukesh, Savaliya wrote:
>> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>>
>> This change enables earlyconsole support as static driver for geni
>> based UART. Kernel space UART console driver will be generic for
>> console and other usecases of UART.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>> ---
>> Changes In V2:
>>   - Fixed Makefile Typo issue.
>>
>> Changes In V3:
>>   - Removed mb() calls as *_relaxed() should take care.
>>
>> Changes In V4:
>>   - Minor change: space between offset and base addition.
>>
>> Changes In V5:
>>   - Removed unlikely() macro.
>>   - root_freq() array taken as static.
>>   - Removed extra readback of the register having no meaning.
>>
>>   drivers/tty/serial/Kconfig                   |  15 +
>>   drivers/tty/serial/Makefile                  |   1 +
>>   drivers/tty/serial/msm_geni_serial_console.c | 476 +++++++++++++++++++
>>   3 files changed, 492 insertions(+)
>>   create mode 100644 drivers/tty/serial/msm_geni_serial_console.c
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 0aea76cd67ff..ded19d80e696 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -956,6 +956,21 @@ config SERIAL_MSM_CONSOLE
>>   	select SERIAL_CORE_CONSOLE
>>   	select SERIAL_EARLYCON
>>   
>> +config SERIAL_MSM_GENI_HALF_SAMPLING
>> +	bool "Changes clock divider which impacts sampling rate for QUP HW ver greater than 2.5.0"
>> +	help
>> +	  Clock divider value should be doubled for QUP hardware version
>> +	  greater than 2.5.0.
>> +	  As earlycon can't have HW version awareness, decision is taken
>> +	  based on the configuration.
> Can you split this option out into a separate file so we don't have to
> keep arguing about it, preventing the "real" early console code from
> being merged?

Sure, patch is uploaded. We are removing this CONFIG and considering  no 
such config needed for now for

latest chipsets.

> I really think someone needs to go yell at some hardware engineers for
> this issue.  How is this going to work for a "generic" arm64 kernel
> image?  Your hardware always has to be self-describing for crazy stuff
> like this.  Or you pass it in from the bootloader.  You can't hard-code
> this thing, it defeats the whole idea of dynamic systems...
I agree with the generic image change, we will work out on this later.
> thanks,
>
> greg k-h
