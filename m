Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A832C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 11:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676EB206DD
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 11:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="W15lSHMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgEFLc0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 07:32:26 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:40431 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgEFLcZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 07:32:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588764744; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=1Osez+41ks31AcBRTOjfPN3dF/fybakc5Vy4/PXfkdU=; b=W15lSHMs8nZQJuGstRD5X8obUxHlNfhbOGBm1KvbgPp6PIko4D+QqggqvbogXtITnIc8+XQN
 McqepKjFkr1+SQPULFzicSpIjCAUrcwTmf8YJLAK5mk+mdMLdVVZem2aNAMqa6pu8mwTk/W3
 G1/y5ymmPe1VkxfN0CLSOzW/tG0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2a038.7f9c7058d7a0-smtp-out-n05;
 Wed, 06 May 2020 11:32:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96876C433D2; Wed,  6 May 2020 11:32:07 +0000 (UTC)
Received: from [192.168.0.4] (unknown [124.123.29.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msavaliy)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8EB4C433F2;
        Wed,  6 May 2020 11:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8EB4C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msavaliy@codeaurora.org
Subject: Re: [PATCH] serial: msm_geni_serial_console : Add Earlycon support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
References: <20200429171934.17376-1-msavaliy@codeaurora.org>
 <20200429173826.GB2332435@kroah.com>
From:   "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Message-ID: <9dd11375-7f6e-8e3d-6243-89089a938f01@codeaurora.org>
Date:   Wed, 6 May 2020 17:01:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429173826.GB2332435@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 4/29/2020 11:08 PM, Greg KH wrote:
> On Wed, Apr 29, 2020 at 10:49:34PM +0530, Mukesh, Savaliya wrote:
>> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>>
>> This change enables earlyconsole support as static driver for geni
>> based UART. Kernel space UART console driver will be generic for
>> console and other usecases of UART.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>> ---
>>   drivers/tty/serial/Kconfig                   |  15 +
>>   drivers/tty/serial/Makefile                  |   1 +
>>   drivers/tty/serial/msm_geni_serial_console.c | 525 +++++++++++++++++++
>>   3 files changed, 541 insertions(+)
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
> How do we know this?  Can't this be dynamically determined at runtime?
> What about kernels that want to be built for both types of hardware at
> the same time?

This will vary for different hardware only if QUP version is lower than 
this.

We can not determine this dynamically because register address space to 
read QUP version is in QUP wrapper space and that also keep varying per 
target.

we only  get internal SE address base in cmdline arg.

>
>> +	  As earlycon can't have HW version awareness, decision is taken
>> +	  based on the configuration.
>> +
>> +config SERIAL_MSM_GENI_EARLY_CONSOLE
>> +	bool "MSM on-chip GENI HW based early console support"
>> +	select SERIAL_MSM_GENI_HALF_SAMPLING
>> +	help
>> +	  Serial early console driver for Qualcomm Technologies Inc's GENI
>> +	  based QUP hardware.
> Why can't we have early console without SERIAL_MSM_GENI_HALF_SAMPLING?
>
> Why are these tied directly to each other?  Do you really need 2
> options?
HALF_SAMPLING controlls the sampling rate of UART HW, if not then logs 
come garbled due to wrong sampling.
>
>> +
>>   config SERIAL_QCOM_GENI
>>   	tristate "QCOM on-chip GENI based serial port support"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
>> index d056ee6cca33..9790ef2d802c 100644
>> --- a/drivers/tty/serial/Makefile
>> +++ b/drivers/tty/serial/Makefile
>> @@ -55,6 +55,7 @@ obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
>>   obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
>>   obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
>>   obj-$(CONFIG_SERIAL_MSM) += msm_serial.o
>> +obj-$(SERIAL_MSM_GENI_EARLY_CONSOLE) += msm_geni_serial_console.o
> I don't think you tested this at all :(
>
> I've stopped here in the review for this obvious reason...

Done the changes. Sorry, i compiled with the static config but missed to 
add back when compiled with  config change.

Uploaded new change.

>
> thanks,
>
> greg k-h
