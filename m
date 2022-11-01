Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792AC433FE
	for <linux-serial@archiver.kernel.org>; Tue,  1 Nov 2022 08:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKAIdv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiKAIdu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Nov 2022 04:33:50 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89811A1E
        for <linux-serial@vger.kernel.org>; Tue,  1 Nov 2022 01:33:50 -0700 (PDT)
Received: from [192.168.8.20] (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 7A5B957E3A;
        Tue,  1 Nov 2022 08:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1667291627; bh=CeWVSSvSC5AsWI3CFrPfXx5FtefIU1wKNCV9c79zciQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FJaXn9/MHqB1zNWV0b3Pvh06TkvUyHcD8ElYsM34ahHfdPSMJqU5sWvSpXXPRNrWG
         ZKttg7P5zrpdo0OuTRhxw6MbfVBSicB7PwFmZQ4ol6sqoebfkB46UXC8Vr4jKtR9ou
         kneQUl91tYpeZ/66CgL0AdIqgC13osNrhi8Lx7f8QJkL3rhHlPhhJ48VmD0xjU6Egc
         Mk9/2lxwGCRUcrqR6APWYTt1R4e7TO7ZOLilmxb6la+cI2tMiV0bIEMqwL04yyGJ0V
         QikUUrRfGt37gZuNkWt+S8igOJhYHivpEvBOeshaQ4qj9rjK0D9KcKI634KjPXPGFc
         exucwnbaWAxPw==
Message-ID: <c1e62b6b-d004-5768-2d75-8a94d41487db@geanix.com>
Date:   Tue, 1 Nov 2022 09:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 4/4] tty: 8250: update description of RUNTIME_PORTS /
 nr_uarts
Content-Language: en-US-large
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221025073944.102437-1-martin@geanix.com>
 <20221025073944.102437-4-martin@geanix.com>
 <f29eb4e-7ed5-ab81-6924-d599dea8a08d@linux.intel.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
In-Reply-To: <f29eb4e-7ed5-ab81-6924-d599dea8a08d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 26/10/2022 13.25, Ilpo Järvinen wrote:
> On Tue, 25 Oct 2022, Martin Hundebøll wrote:
> 
>> The 8250 module has been updated allow configurations with zero builtin
>> UART ports, so change the description of the parameter to reflect that.
>>
>> Signed-off-by: Martin Hundebøll<martin@geanix.com>
>> ---
>>
>> Change since v2:
>>   * new patch
>>
>>   drivers/tty/serial/8250/8250_core.c |  3 ++-
>>   drivers/tty/serial/8250/Kconfig     | 10 +++++-----
>>   2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index a8fbc2325244..3d8bf0296080 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -1257,7 +1257,8 @@ module_param_hw(share_irqs, uint, other, 0644);
>>   MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
>>   
>>   module_param(nr_uarts, uint, 0644);
>> -MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
>> +MODULE_PARM_DESC(nr_uarts, "Number of built-in (non-discoverable) UARTs to initialize. (1-"
>> +		_MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
> This fails to build. You have dropped the second underscore for some
> reason.

Running checkpatch after make is dangerous...

> Shouldn't that 1- be also changed to 0- ?

Correct. In fact, it should be 0 - ARRAY_SIZE(old_serial_port) - 1.

// Martin
