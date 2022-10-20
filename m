Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601DEC4332F
	for <linux-serial@archiver.kernel.org>; Thu, 20 Oct 2022 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJTNVH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiJTNVF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Oct 2022 09:21:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DAAA52F6
        for <linux-serial@vger.kernel.org>; Thu, 20 Oct 2022 06:20:33 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtSrd4YbWzHtck;
        Thu, 20 Oct 2022 21:20:17 +0800 (CST)
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:20:24 +0800
Message-ID: <74352a7a-2a3a-c26d-9687-c31eed699a4e@huawei.com>
Date:   Thu, 20 Oct 2022 21:20:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] earlycon: Fix compile error when SERIAL_CORE is m
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <jirislaby@kernel.org>,
        <robh@kernel.org>, <ztong0001@gmail.com>,
        <peter@hurleysoftware.com>
References: <20221020032722.3263846-1-zhangxiaoxu5@huawei.com>
 <Y1DW9Q5HLsh4kBnm@kroah.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
In-Reply-To: <Y1DW9Q5HLsh4kBnm@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022/10/20 13:04, Greg KH wrote:
> On Thu, Oct 20, 2022 at 11:27:22AM +0800, Zhang Xiaoxu wrote:
>> When set CONFIG_SERIAL_EARLYCON=y and CONFIG_SERIAL_CORE=m, there is
>> a compile error as below:
>>
>>    ld: vmlinux.o: in function `parse_options.constprop.0':
>>    earlycon.c:(.init.text+0xba5a3): undefined reference to `uart_parse_earlycon'
>>
>> Since the SERIAL_EARLYCON use 'uart_parse_earlycon' which defined in
>> SERIAL_CORE, so should select rather than depends on.
> 
> No, please try to never use "select".
> 
>>
>> Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
> 
> So this has been a problem for a very very long time and never been
> seen until now?  That feels wrong, what changed to cause this to not
> ever be hit before with all of the tens of thousands of random configs
> that have been built since this very old kernel?
> 
Yes, 0fb9342d06b0 ("tty: serial: earlycon dependency") already fix the
same issue with add "depends on SERIAL_CORE".

But there are some other scenarios can trigger the same issue.

Use the config file in the bugzilla can reproduce the problem.
https://bugzilla.kernel.org/show_bug.cgi?id=216611

Bisect with this config, find out the following commit introduce the issue:
   cdcc41a256efe8 ("tty: serial: Kconfig: Allow SERIAL_QCOM_GENI_CONSOLE to be enabled if SERIAL_QCOM_GENI is a module")

  config SERIAL_QCOM_GENI
         tristate "QCOM on-chip GENI based serial port support"
         depends on ARCH_QCOM || COMPILE_TEST
         depends on QCOM_GENI_SE
         select SERIAL_CORE

  config SERIAL_QCOM_GENI_CONSOLE
         bool "QCOM GENI Serial Console support"
-       depends on SERIAL_QCOM_GENI=y
+       depends on SERIAL_QCOM_GENI
         select SERIAL_CORE_CONSOLE
         select SERIAL_EARLYCON
         help
           Serial console driver for Qualcomm Technologies Inc's GENI based
           QUP hardware.

Since 73abaf87f01b ("serial: earlycon: Refactor parse_options into serial core")
use the uart_parse_earlycon() which defined in SERIAL_CORE, so if SERIAL_EARLYCON=y,
should always select SERIAL_CORE=y.

If change to "depends on SERIAL_CORE=y", just WARNING when make olddefconfig, can't
auto select the depends to Y.
> thanks,
> 
> greg k-h
