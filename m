Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3717CC6FD1F
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 16:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCGQw6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCGQwk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 11:52:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D9696F0B
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 08:48:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k37so8258414wms.0
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 08:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678207708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80Y0cuJ9iz5XmFa4pR2hxDaox/dZrrCFfXs87VRlzo8=;
        b=sbgLUZSUGcIj6Z9snoz0pPlFnAXVGWVaQXuQgOTbN0cfao+NvOjOJwgyj9aDFnqNMx
         ZJVQUgh0HjoaqvqNbtJR7WGfo4xidNaDisonw6d706CvAvnaaphEWle0R+l8IJ/Npv4v
         dooSruLWTwttqeDBaZFA360vwFYFe5f2tSbSRU0+8uZnPO1QC6r1HjGVTYAz6ILYKMU6
         R5lAvM0MoTRKtj03I9tJpvB+dKKLval5zyq1o0Z4I/uWQ0OS5TqTwxs3nu4y5ZAvcuh0
         MSrXtNkOkw+qEyLSIhbv+NP9oyyG2Jgv6enl+6AEJvVKWhreANuu7lRE3qpq59xvwqXp
         sqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80Y0cuJ9iz5XmFa4pR2hxDaox/dZrrCFfXs87VRlzo8=;
        b=7t++SliVrZKwqTJh9gl7CJm7wB6Jt853UCPnBCxsnCMrnbQcpQ9vTQ6uz2CTJwxQ+w
         lyZLdPsk8hso4NIhDUW/JCZZZwqddXEqx8qY8hDL41oP5+MmBURmtoFHdnFaBLw5pduR
         jo7MQ/asxLVfV0E+CK6xdGN5m2LgTXDmGPQOG6ADlKEpAY3k3fNfeMPiGQiUUgfxFws3
         ewjOqAEYhNP5UzABgws6Ko24R/w3EZef0S1lGNl4hIR+6F8mli9ieSmsCAGn0WE6ZIlV
         TRiM3nvo/IOlTGaXNdbGEkv1sbXkb9RWL0Rs/RwmHSX+axQFz7IcJ9YTnA0UE+XlDpNo
         cU3Q==
X-Gm-Message-State: AO0yUKUcUKQzZN6aFvamDrTV5ikX4zgJxXpSQKav8u9ioUTCrdWILf3D
        kGnzG7WuCEDzc7lFEAS7cLXyuiLd8WwnAatz/W8=
X-Google-Smtp-Source: AK7set/YqWZVYs3gaQ5vga3bWWCfW7nayHNhZmi0Qr1jmqzAOJvDCjKWDPPHAJkGN+xGCpho9N7PlQ==
X-Received: by 2002:a05:600c:3591:b0:3eb:3998:8c05 with SMTP id p17-20020a05600c359100b003eb39988c05mr10600494wmq.6.1678207708244;
        Tue, 07 Mar 2023 08:48:28 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e18-20020adffc52000000b002ca864b807csm12952085wrs.0.2023.03.07.08.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:48:27 -0800 (PST)
Message-ID: <696004ca-ff21-cc74-7952-424244244dda@linaro.org>
Date:   Tue, 7 Mar 2023 16:48:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] tty: serial: qcom-geni-serial: check for valid size
 before starting dma
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
 <20230307155543.31021-2-srinivas.kandagatla@linaro.org>
 <c7830eaa-f4b9-dac9-93b2-c3cc032ed4fb@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <c7830eaa-f4b9-dac9-93b2-c3cc032ed4fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 07/03/2023 16:20, Konrad Dybcio wrote:
> 
> 
> On 7.03.2023 16:55, Srinivas Kandagatla wrote:
>> Check if there are valid length of bytes to transfer before starting dma.
>>
>> without this check we can see below kernel warning when we try to map a zero size buffers.
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 0 at drivers/iommu/dma-iommu.c:1046 iommu_dma_unmap_page+0xe0/0xfc
>> Modules linked in:
>> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.3.0-rc1-dirty #347
>> Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>> pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : iommu_dma_unmap_page+0xe0/0xfc
>> lr : iommu_dma_unmap_page+0x38/0xfc
>> ...
>> Call trace:
>>   iommu_dma_unmap_page+0xe0/0xfc
>>   dma_unmap_page_attrs+0x30/0x1ec
>>   geni_se_tx_dma_unprep+0x58/0x80
>>   qcom_geni_serial_isr+0x350/0x750
>>   __handle_irq_event_percpu+0x58/0x148
>>   handle_irq_event_percpu+0x18/0x4c
>>   handle_irq_event+0x48/0x88
>>   handle_fasteoi_irq+0xb0/0x130
>>   generic_handle_domain_irq+0x2c/0x44
>>   gic_handle_irq+0xd4/0x140
>>   call_on_irq_stack+0x24/0x4c
>>   do_interrupt_handler+0x80/0x84
>>   el1_interrupt+0x38/0x6c
>>   el1h_64_irq_handler+0x18/0x24
>>   el1h_64_irq+0x64/0x68
>>   cpuidle_enter_state+0x1e4/0x310
>>   cpuidle_enter+0x3c/0x54
>>   call_cpuidle+0x1c/0x40
>>   do_idle+0x204/0x260
>>   cpu_startup_entry+0x28/0x2c
>>   kernel_init+0x0/0x12c
>>   arch_post_acpi_subsys_init+0x0/0x8
>>   start_kernel+0x3cc/0x74c
>>   __primary_switched+0xbc/0xc4
>>
>> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> S-o-b but no C-d-b? Weird..
> 
Yes, I did mess up this part.
thanks for spotting this, Will fix this in next spin!

--srini
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
> Anyway, the change is good!
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>>   drivers/tty/serial/qcom_geni_serial.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 5972b5c317d3..bb63a00f4c07 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -637,6 +637,9 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
>>   
>>   	xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>>   
>> +	if (!xmit_size)
>> +		return;
>> +
>>   	qcom_geni_serial_setup_tx(uport, xmit_size);
>>   
>>   	ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
