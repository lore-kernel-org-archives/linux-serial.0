Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8CFFA373D
	for <linux-serial@archiver.kernel.org>; Tue,  1 Nov 2022 08:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKAIcH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAIcG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Nov 2022 04:32:06 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701C3B5
        for <linux-serial@vger.kernel.org>; Tue,  1 Nov 2022 01:32:05 -0700 (PDT)
Received: from [192.168.8.20] (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 9382B57E3A;
        Tue,  1 Nov 2022 08:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1667291521; bh=j76fLgLlBKsECzKo+2rHQmcWOJMCLJu1MqNb6QWVwrU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZJV77Z9UHK2deExHk0k6BcLPJrvNMe0GyiEZcDTDYjJeEaxEIvvj/KyQ7+GOp7VQK
         qzJ94P4sXfDM4w9/dcdjodWkMo66rLlfussPSiTnLD8AK19U9RNzK5Kl+5CdkiwOgl
         /i/jz4BpY/fr8PndSZpAi3v/PTmXSj35naIZECciBUSEEKAjwMwHc3jfqaFiO0NFNT
         U/GUZzHQmeH1a+y0tpstIpYZdRj984JnZs7h4xYly4gOWaHeVYC+FSB2q2kH/ZRxBz
         jPIrlSRMMsHrZ/oX72HS/Qra1e6Wt/wk1mbw5+dDgXc9RskB+iKydfpUriBWS4jZ8J
         ktuh3zcDNOlCw==
Message-ID: <9320837b-1b8a-9ddf-7de8-d75816fb209b@geanix.com>
Date:   Tue, 1 Nov 2022 09:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 3/4] serial: 8250: skip platform device registration
 with no runtime ports
Content-Language: en-US-large
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial <linux-serial@vger.kernel.org>
References: <20221025073944.102437-1-martin@geanix.com>
 <20221025073944.102437-3-martin@geanix.com>
 <c1642f35-6270-7155-795d-a3f7324f799c@linux.intel.com>
 <b6619d9-5b91-e06c-f2a0-af92128937d2@linux.intel.com>
 <d27b3f5d-8766-fa1c-c369-31ebe344f87@linux.intel.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
In-Reply-To: <d27b3f5d-8766-fa1c-c369-31ebe344f87@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28/10/2022 11.40, Ilpo Järvinen wrote:
> On Fri, 28 Oct 2022, Ilpo Järvinen wrote:
> 
>> On Wed, 26 Oct 2022, Ilpo Järvinen wrote:
>>
>>> On Tue, 25 Oct 2022, Martin Hundebøll wrote:
>>>
>>>> Skip registration of the platform device used for built-in ports, if no
>>>> such ports are configured/created.
>>>>
>>>> Signed-off-by: Martin Hundebøll <martin@geanix.com>
>>>
>>> For patches 1-3:
>>>
>>> Tested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>
>>> Please include these tags into the next version of your submission.
>>> Thank you.
>>
>> Actually, I just found out that some set of cmdline parameters do no
>> longer work the same. So I'm retracting both of my tags for now.
>>
>> =0 did work as expected due to this change which I tested and some other
>> values >4 but there now seems to be problem of the console not showing up
>> like previously when I don't give nr_uarts at all.
> 
> NAK from me until the problem is resolved adequately.
> 
> Already the patch 1/4 causes an unacceptable reassignment of ttySx
> targets. This is going to break people's cmdline console setups so you
> need to find a better way.
> 
> Before any of these patches:
> 
> [    0.000000] Command line: console=ttyS0,115200n8 8250.nr_uarts=4
> [    0.021031] Kernel command line: console=ttyS0,115200n8 8250.nr_uarts=4
> [    0.441924] printk: console [ttyS0] enabled
> [    2.243165] printk: console [ttyS0] disabled
> [    2.245682] dw-apb-uart.6: ttyS0 at MMIO 0x4010006000 (irq = 33, base_baud = 115200) is a 16550A
> [    4.010237] printk: console [ttyS0] enabled
> [    5.933887] dw-apb-uart.7: ttyS1 at MMIO 0x4010007000 (irq = 16, base_baud = 6250000) is a 16550A
> [    5.952829] dw-apb-uart.8: ttyS2 at MMIO 0x4010008000 (irq = 17, base_baud = 6250000) is a 16550A
> 
> After 1/4 ttyS0 is no longer the same:
> 
> [    0.000000] Command line: console=ttyS0,115200n8 8250.nr_uarts=4
> [    0.021023] Kernel command line: console=ttyS0,115200n8 8250.nr_uarts=4
> [    0.441872] printk: console [ttyS0] enabled
> [    2.233584] dw-apb-uart.6: ttyS4 at MMIO 0x4010006000 (irq = 33, base_baud = 115200) is a 16550A
> [    2.241955] dw-apb-uart.7: ttyS5 at MMIO 0x4010007000 (irq = 16, base_baud = 6250000) is a 16550A
> [    2.249804] dw-apb-uart.8: ttyS6 at MMIO 0x4010008000 (irq = 17, base_baud = 6250000) is a 16550A

Thanks for testing this.

The old behavior is wrong: your designware ports replace the built-in ones (0 to 3) instead of using the unused ones (4 to 31). With these patches, it acts as I'd expect: the built-in ports are kept, and any later discovered ports follow.

Yes, breaking existing systems in this way is unacceptable. I'm not sure how to approach this, but I'm inclined to introduce a new config variable to keep the broken behavior?

// Martin


  

