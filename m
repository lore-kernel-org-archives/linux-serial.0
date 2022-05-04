Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE22BC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  4 May 2022 15:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbiEDP54 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 May 2022 11:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352884AbiEDP5z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 May 2022 11:57:55 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4AF46155
        for <linux-serial@vger.kernel.org>; Wed,  4 May 2022 08:54:18 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244Ed56B018222;
        Wed, 4 May 2022 17:54:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=gDQ7kfKMayqT8+pKB/dp+vaUxlVpEafeO+qiPe95/JQ=;
 b=4FS98Ko4lxTUPN4sBxNEQL9LF+w33ecIKRbcMPeU0e6SZZL0JNkV/qPSvya95vhiazi3
 SzTEKjmdp2dLRT/wchaR4lLzL6dDffWe9ys36ceV/nB67rSWCvzl9Aqemp9Gt32kdcmq
 bxcQfzlCBcxttC7WGob45SmFMsy7IjI8uT+qivO3I7FaluGP9Fa9su7hbaFmoJBrDNez
 Y9lurpiSM3+BBPQYRsLGWrEH90oT+tkyoYCpNmbD13oWr0iIlGwNrgVwlkSBhT1zYWTP
 paFlg0GrbvpPyIJ+NFqey/XiRvRBefQko5Eren6QfD1VyHQUj0me9PBrGsYK7UV0uSLp Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjwegr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 17:54:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AA7910002A;
        Wed,  4 May 2022 17:54:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC62322A6E5;
        Wed,  4 May 2022 17:54:05 +0200 (CEST)
Received: from [10.201.21.169] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May
 2022 17:54:04 +0200
Message-ID: <57896136-5e08-b9fe-2e3e-0eff4388e064@foss.st.com>
Date:   Wed, 4 May 2022 17:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] serial: stm32: Use TC interrupt to deassert GPIO RTS
 in RS485 mode
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, <linux-serial@vger.kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220430162845.244655-1-marex@denx.de>
 <20220430162845.244655-2-marex@denx.de>
 <702dcede-ff97-b074-20bf-7c695f988d40@foss.st.com>
 <18f886d9-924b-e32b-e298-90e998b30662@denx.de>
From:   Erwan LE RAY <erwan.leray@foss.st.com>
In-Reply-To: <18f886d9-924b-e32b-e298-90e998b30662@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Marek,

On 5/2/22 13:13, Marek Vasut wrote:
> On 5/2/22 10:44, Erwan LE RAY wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On 4/30/22 18:28, Marek Vasut wrote:
>>> In case the RS485 mode is emulated using GPIO RTS, use the TC interrupt
>>> to deassert the GPIO RTS, otherwise the GPIO RTS stays asserted after a
>>> transmission ended and the RS485 cannot work.
>>>
>> Could you please add a cover letter to explain the rational of the 
>> first patch ? I understood the goal of the first by reading the commit 
>> message of this second patch.
> 
> The rationale is trivial -- make sure we don't have five copies of the 
> same block of code in the driver.
> Agree but factorization is needed only because of your second patch, 
reason why I suggested a cover letter for the series.

>>> diff --git a/drivers/tty/serial/stm32-usart.c 
>>> b/drivers/tty/serial/stm32-usart.c
>>> index 224f359c6051e..764415b8e8f03 100644
>>> --- a/drivers/tty/serial/stm32-usart.c
>>> +++ b/drivers/tty/serial/stm32-usart.c
>>> @@ -417,6 +417,14 @@ static void 
>>> stm32_usart_tx_interrupt_enable(struct uart_port *port)
>>>           stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
>>>   }
>>> +static void stm32_usart_tc_interrupt_enable(struct uart_port *port)
>>> +{
>>> +    struct stm32_port *stm32_port = to_stm32_port(port);
>>> +    const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
>>> +
>>> +    stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TCIE);
>>> +}
>>> +
>> I don't see the added value of this helper (only 1 instruction used 1 
>> time), and other Interrupt Enabled bits are already set/unset in 
>> others functions of this driver.
>> To keep an homogeneous code in the driver, could you please remove 
>> this helper and set TCIE directly when you need it ?
> 
> Should I also remove stm32_usart_tx_interrupt_enable() / 
> stm32_usart_tx_interrupt_disable() , which does the same thing for other 
> bits in the interrupt register ?
> 
In stm32_usart_tx_interrupt_enable() / 
stm32_usart_tx_interrupt_disable() case, 2 bits are configured 
differently under a condition, and stm32_usart_tx_interrupt_disable() is 
called 4 times in the driver. The factorization is triggered by the 
multiple calls to this code.
In your proposal, the helper is executing a single instruction, and is 
called only once, reason why I suggested to enable / disable the TCIE 
directly in your new functions stm32_usart_tc_interrupt_enable() / 
stm32_usart_tc_interrupt_disable().

> That sounds to me like making the code harder to read, not easier.
> 
> [...]

Regards, Erwan.
