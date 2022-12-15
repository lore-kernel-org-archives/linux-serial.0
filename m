Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3646C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 15 Dec 2022 16:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiLOQxx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiLOQxg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Dec 2022 11:53:36 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8540C3B9F0
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 08:53:11 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFG69VR001434;
        Thu, 15 Dec 2022 17:52:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=foOTUizzoOwUhkqSNmKNIsjRp5o7VWjfsP3BMaaG1Ps=;
 b=p0giefhsz1cwfIgBu8ehm5f4vLroq6ZE32VbFy889Cv6yVHCKLqevG3CHENwTZXwQr/i
 OLzIq640gmjejFUtEfovN5HMgK1AhAI/Pjm5wDdek6SNHtoSHeWb8XE9heH/GbraKcxX
 /nJdEheuhcPo5BaZwb2trQxY3pOSOVBLNWONnAkCgYhQKkFHvFuWTzEToAfBkucLEJKa
 XGxYeC+WlohpV5Zm0XY3ZnwJibVmFonzbZEWl41bkIQYmO15edpCECKrFXOOyhJvqQKg
 5R7Uc3hjysGkpPUm3ZkkmQm4hlx5mfUS8YC4Ha2lGBCAVoQkAb84S8w87N0YzOk6LLXy aQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mf6uww1kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 17:52:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC23F100039;
        Thu, 15 Dec 2022 17:52:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 724E223152E;
        Thu, 15 Dec 2022 17:52:34 +0100 (CET)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 15 Dec
 2022 17:52:33 +0100
Message-ID: <f2373a2b-8229-8af3-116c-7f3b8ccf8062@foss.st.com>
Date:   Thu, 15 Dec 2022 17:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] serial: stm32: Move hard IRQ handling to threaded
 interrupt context
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-serial@vger.kernel.org>
References: <20221207195929.160267-1-marex@denx.de>
 <34ec91a2-2089-65ba-d5bb-fed03cda63b7@foss.st.com>
 <a984e2aa-1fbf-4b6b-9326-d926221740d8@denx.de>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <a984e2aa-1fbf-4b6b-9326-d926221740d8@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_10,2022-12-15_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Marek,

I test your patch with a loop-back test between usart3 and uart7 on 
STM32MP157C-DK2. It
shows a speed transfer diminution (about -1,5%), some locks during 
transfer, RT throttling etc...
(I use lszrz tool).

But finally, I think your patch is the best solution that we have.
Other solutions always throws an RT exception on a spin_lock.

Thanks,
Valentin

On 12/8/22 14:19, Marek Vasut wrote:
> On 12/8/22 11:18, Valentin CARON wrote:
>> Hi Marek,
>
> Hi,
>
>> I've got a patch in the same spirit in downstream.
>> The test campaign reveals performance issues with this patch.
>>
>> In fact, hard IRQ have been introduced in stm32-usart driver to solve 
>> performance issues due to short FIFO size (16 bytes).
>>
>> We are currently testing another patch, similar as your RFC 
>> proposition, for RT context.
>> But results are not ready yet. We can wait them before merging this 
>> big change into driver ?
>
> Can you post your patch as an RFC so others can test as well ?
