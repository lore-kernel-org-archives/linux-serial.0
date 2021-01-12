Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB35C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498912085B
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392903AbhALKDk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:03:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60656 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbhALKDk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 05:03:40 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C9wVex011901;
        Tue, 12 Jan 2021 11:02:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=E546pFVq1ta2uBxokyZK/xre7E5ZXuq5jUCSw1MfC58=;
 b=Y6hRWkg+NBgd9p/YBnc5aYcGBj8SOazNom2XLz6UjT5dZsCRpML6xGkCKcR7uxyikqCt
 0gEczWtKdLTpnUTV7Rc/gY+YnCQ1IY0bCGoedHt+CeoQlr6kh4x5Uj057yPjhO+lOcyz
 txdAEejI3mMUo6fdP4eLMxYMimOcksWU+O5PIHQv2TxzXtlLCHqjQ6+9UqCa9eE9K5ko
 V7cxz7MkPp4dUcOVgYrLZgtfudRn69OVx7bElHz4VCuUm56zYjXSHg2Q7mNW7FmEiOHK
 N38FqA5hTo4NK45u7FSz2a/mU6S8eoJjmk7+oywUeeTSl5+qCwXxmb+Pu8LjwTpQx7W4 Ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35y5kyfpxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 11:02:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 607BF100034;
        Tue, 12 Jan 2021 11:02:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4E0F323770C;
        Tue, 12 Jan 2021 11:02:45 +0100 (CET)
Received: from lmecxl0566.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 11:02:44 +0100
Subject: Re: [PATCH v2 2/8] serial: stm32: fix code cleaning warnings and
 checks
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
References: <20210106162203.28854-1-erwan.leray@foss.st.com>
 <20210106162203.28854-3-erwan.leray@foss.st.com>
 <72c81157-4bd1-6a3e-2415-92a2fb29ab6d@kernel.org>
From:   Erwan LE RAY <erwan.leray@foss.st.com>
Message-ID: <667eb6bd-b612-fd78-0b09-d61eff72d139@foss.st.com>
Date:   Tue, 12 Jan 2021 11:02:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72c81157-4bd1-6a3e-2415-92a2fb29ab6d@kernel.org>
Content-Type: text/plain; charset="iso-8859-2"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_06:2021-01-11,2021-01-12 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Greg,

As the V2 is already in your tty-next branch, how do want me to proceed 
to deliver the fix for Jiri remark ?
Do you expect a V3 or a new fix ?

Best Regards, Erwan.


On 1/11/21 10:58 AM, Jiri Slaby wrote:
> On 06. 01. 21, 17:21, Erwan Le Ray wrote:
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
> ...
>> @@ -973,18 +971,17 @@ static int stm32_init_port(struct stm32_port 
>> *stm32port,
>>       struct resource *res;
>>       int ret;
>> +    ret = platform_get_irq(pdev, 0);
>> +    if (ret <= 0)
>> +        return ret ? : -ENODEV;
>> +
>>       port->iotype    = UPIO_MEM;
>>       port->flags    = UPF_BOOT_AUTOCONF;
>>       port->ops    = &stm32_uart_ops;
>>       port->dev    = &pdev->dev;
>>       port->fifosize    = stm32port->info->cfg.fifosize;
>>       port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_STM32_CONSOLE);
>> -
>> -    ret = platform_get_irq(pdev, 0);
>> -    if (ret <= 0)
>> -        return ret ? : -ENODEV;
>>       port->irq = ret;
> 
> I would move this set from ret above too. Or introduce a new variable, 
> e.g. "irq".
> 
> thanks,
