Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939CCC433F5
	for <linux-serial@archiver.kernel.org>; Thu,  6 Oct 2022 07:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJFHRN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJFHRM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Oct 2022 03:17:12 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CEA3FD58
        for <linux-serial@vger.kernel.org>; Thu,  6 Oct 2022 00:17:11 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2967GrQx086955;
        Thu, 6 Oct 2022 02:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665040613;
        bh=T1thl0GA8nPqhsWaCYD+k/EqMgPOjWuceXoJCMTfLr8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Xf1iPU4SeYWPnt1vDgAJm2YxlI7QfyokeYd3ujKkPOjKVB3yLg5poD5ntNy6hmUMF
         T24z0y/24C1dgFNzu3c0jtIzgP5nqfd3KdOW5KtJkWFkb4ObKIZwE6T5fCMWpxCo7T
         VX65B9ArmGuXUah8gpEA7XZGziX/D7bnD5xw33Hg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2967GrOS038675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Oct 2022 02:16:53 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 6 Oct
 2022 02:16:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 6 Oct 2022 02:16:52 -0500
Received: from [10.250.233.127] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2967GmaQ021304;
        Thu, 6 Oct 2022 02:16:48 -0500
Message-ID: <dd621f4e-f79b-d9ea-7335-49dba0c4074a@ti.com>
Date:   Thu, 6 Oct 2022 12:46:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] serial: 8250: 8250_omap: Support native RS485
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
 <42986e92-d12e-bfde-2f5c-f580c113c3b@linux.intel.com>
 <20221003195459.GA11858@wunner.de>
 <89a1308-d325-ba17-7e8c-5a7f4a38f58d@linux.intel.com>
 <20221006062126.GA26272@wunner.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221006062126.GA26272@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 06/10/22 11:51 am, Lukas Wunner wrote:
> On Tue, Oct 04, 2022 at 12:06:21PM +0300, Ilpo Järvinen wrote:
>> On Mon, 3 Oct 2022, Lukas Wunner wrote:
>>> On Wed, Sep 28, 2022 at 02:38:40PM +0300, Ilpo Järvinen wrote:
>>>> On Tue, 27 Sep 2022, Lukas Wunner wrote:
>>>>> @@ -1377,6 +1426,14 @@ static int omap8250_probe(struct platform_device *pdev)
>>>>>  			 DEFAULT_CLK_SPEED);
>>>>>  	}
>>>>>  
>>>>> +	if (priv->habit & UART_HAS_NATIVE_RS485) {
>>>>> +		up.port.rs485_config = omap8250_rs485_config;
>>>>> +	} else {
>>>>> +		up.port.rs485_config = serial8250_em485_config;
>>>>> +		up.rs485_start_tx = serial8250_em485_start_tx;
>>>>> +		up.rs485_stop_tx = serial8250_em485_stop_tx;
>>>>> +	}
>>>>
>>>> I guess .rs485_supported shouldn't be equal in both cases?
>>>
>>> I contemplated whether it should be different for hardware-assisted
>>> RS485 but came to the conclusion that it shouldn't:
> [...]
>> Core is not handling just flags but also delay_rts_before_send and 
>> delay_rts_after_send sanitization. See 
>> uart_sanitize_serial_rs485_delays().
>>
>> Btw, you can also get rid of this line once you provide separate 
>> rs485_supported:
>> 	rs485->delay_rts_before_send = 0;
>>
>> What to do with delay_rts_after_send seems bit trickier though. Looking 
>> the code, it cannot be configured to arbitrary values by the user but it 
>> might not be zero either after the driver touches it. Maybe it safer to 
>> have it supported (set to 1) to avoid spuriously triggering the warning in 
>> uart_sanitize_serial_rs485_delays() (e.g., during init if non-zero delay 
>> is provided).
> 
> If I understand Figure 12-276 on page 8783 of the AM65 TRM correctly,
> there appears to be a 1 bit clock delay between writing to the THR register
> and transmission of the start bit:
> 
>   https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> I intend to respin the patch with the following addition:
> 
>   fixed_delay_rts_before_send = 1 * MSEC_PER_SEC / baud;
> 
> As a result, both delay_rts_before_send and delay_rts_after_send should be
> set to 1 in the rs485_supported struct for hardware-controlled RTS.
> 

12.1.5.4.8.2.1 RS-485 External Transceiver Direction Control

The direction is determined by the hardware monitoring the TX FIFO and

the TX shift register. When both are empty the transceiver is set to RX.
There is a guard band delay

counter of **3 bit clock cycles** after the TX shift register is going
empty to allow time for the stop bit to

transition through the transceiver before a direction change to receive
might be applied.

So, RTS deasserts 3 cycle after stop bit. Shouldn't this be 3 baud cycles?


Really appreciate working on this feature, thanks!

Regards
Vignesh
