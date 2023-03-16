Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59797C7618A
	for <linux-serial@archiver.kernel.org>; Thu, 16 Mar 2023 20:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCPUnz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCPUnz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 16:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2257E1CF47
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678999383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKC2wHI2hRxrykJ/AFQW1T9+73c/MAC1oJX/+nj01Es=;
        b=OCga4+a/IJ4dO6MCi0nS1M+l6155juwRcHyHn4upfB18UlS/AiyaggUWL1aQP88f9X874Y
        sAP+IuW43hDMudK7aOzFIN9LnTtaBc01TO7hRdr/aiNG7iREDFXVRHkqJ+zZ0Z4F1NfnjT
        AyDwM9vI5nUcWAqBSfTccZ51JT6GDDA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-MidK6HJBMQiF6lp1pOoVeA-1; Thu, 16 Mar 2023 16:43:02 -0400
X-MC-Unique: MidK6HJBMQiF6lp1pOoVeA-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a0564020e8b00b004e59d4722a3so4658467eda.6
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 13:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678999381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKC2wHI2hRxrykJ/AFQW1T9+73c/MAC1oJX/+nj01Es=;
        b=lgfL3CMFadh87Vbl+XVLGSa7jYgDKz/kqc1t3msAF9Wc14tOo5E8ila9J2w2c9xV30
         JDWciO3po0jy4v3YwFDLv08qlMYXwNlMaK5W07oW5kHEbc98WGKhGZIhuhIM6AXKrI3o
         2bzHd1oItI5iK0UFmrzp7uAW9EOPwqP+BQz6qLAClMJ/UiWQU9rfecjilkHLNIcUt+ZJ
         UUEDGhIvVzP5fJPYvOZ3ShLZAK3ppQhL8pz4rQyoN00+NH7vr3iSFpesBngetHQO5nj4
         /UXzi0jZiRRw8aFB8ajJuJry/BeTHkPy1YcD2O4/Bz/MAtwWUvaHFq8x+10MGP9tQDjm
         mxtQ==
X-Gm-Message-State: AO0yUKU6A0wVruva/c3PK4uqkelzFyntDaNl42A3DSewwl/FzwaYBmB8
        ep8PpQSqVLBaKpm771GL03E8pvr0jG+XDY7MxIP/laK8IzpXEoXD3eZ7JoKiRkgq8AO1nl0dPhA
        OipKa4MTEJP8tY17SDNhYW/fv
X-Received: by 2002:a17:907:3f8d:b0:92f:924b:e8f4 with SMTP id hr13-20020a1709073f8d00b0092f924be8f4mr7656500ejc.4.1678999381048;
        Thu, 16 Mar 2023 13:43:01 -0700 (PDT)
X-Google-Smtp-Source: AK7set+PJxB76kDLr97BygWa62yM1UTw4Mr1/9AwoC1NioiGdkeJ4qe/pz0wdKAd+k3Ym99PpfAPtQ==
X-Received: by 2002:a17:907:3f8d:b0:92f:924b:e8f4 with SMTP id hr13-20020a1709073f8d00b0092f924be8f4mr7656489ejc.4.1678999380703;
        Thu, 16 Mar 2023 13:43:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id de16-20020a1709069bd000b0092b422c9d37sm71117ejc.110.2023.03.16.13.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 13:43:00 -0700 (PDT)
Message-ID: <7ef0037f-c049-b783-b019-c8453801555e@redhat.com>
Date:   Thu, 16 Mar 2023 21:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com>
 <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com>
 <316ab583-d217-a332-d161-8225b0cee227@redhat.com>
 <1d7c80cf-cf79-ef1-58ba-e3b99294bb6@linux.intel.com>
 <9e1e207f-a74f-cedb-6811-993d6b0a26cf@redhat.com>
 <f729bfb4-cde1-9859-f1ff-58716772dfc4@linux.intel.com>
 <00de13b2-0ed9-efe2-e8d8-c9370c04e80b@redhat.com>
 <322489-e120-dcbf-fffc-d9df31d8c499@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <322489-e120-dcbf-fffc-d9df31d8c499@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 3/15/23 15:47, Ilpo Järvinen wrote:
> On Tue, 14 Mar 2023, Hans de Goede wrote:
>> On 3/14/23 17:55, Ilpo Järvinen wrote:
>>> On Tue, 14 Mar 2023, Hans de Goede wrote:
>>>> On 3/14/23 12:48, Ilpo Järvinen wrote:
>>>>> On Tue, 14 Mar 2023, Hans de Goede wrote:
>>>>>> On 3/14/23 11:55, Ilpo Järvinen wrote:
>>>>>>> On Tue, 14 Mar 2023, Hans de Goede wrote:
>>>>>>>
>>>>>>>> I have spend the last couple of days debugging a problem with Bluetooth
>>>>>>>> adapters (HCIs) connected over an UART connection on Intel Bay Trail
>>>>>>>> and Cherry Trail devices.
>>>>>>>>
>>>>>>>> After much debugging I found out that sometimes the first byte of
>>>>>>>> a received packet (data[0]) would be overwritten with a 0 byte.
>>>>>>>>
>>>>>>>> E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:
>>>>>>>>
>>>>>>>> 04 0e 0a 01 79 fc 00 54 fe ff ff 00 00
>>>>>>>>
>>>>>>>> would sometimes turn into:
>>>>>>>>
>>>>>>>> 00 0e 0a 01 79 fc 00 54 fe ff ff 00 00
>>>>>>>>
>>>>>>>> Further investigation revealed that this goes away if I stop
>>>>>>>> the dw_dmac module from loading, leading to:
>>>>>>>> "dw-apb-uart 80860F0A:00: failed to request DMA"
>>>>>>>> and the UART working without DMA support.
>>>>>>>>
>>>>>>>> Testing various kernels showed that this problem was introduced
>>>>>>>> in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:
>>>>>>>>
>>>>>>>> e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
>>>>>>>>
>>>>>>>> And reverting that on top of v6.3-rc2 indeed solves the problem.
>>>>>>>
>>>>>>>> So it seems that that commit somehow interferes with DMA based
>>>>>>
>>>>>>> Maybe the the extra interrupt that the tx side change will trigger somehow 
>>>>>>> causes the confusion on the rx side. So that would be an extra call into 
>>>>>>> handle_rx_dma() that could either do an extra flush or start DMA Rx that 
>>>>>>> would not occur w/o that tx side change.
>>>>>>
>>>>>> That sounds like a likely candidate for causing this yes, as said
>>>>>> I'm unfamiliar with the serial-port code, but I did already suspect
>>>>>> that the change was causing some extra interrupt which somehow
>>>>>> interfered with the rx side.
>>>>>>
>>>>>>>> The issue has been seen on and the revert has been tested on
>>>>>>>> the following HW:
>>>>>>>>
>>>>>>>> Asus T100TA
>>>>>>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
>>>>>>>>
>>>>>>>> Lenovo Yoga Tablet 2 1051L
>>>>>>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
>>>>>>>>
>>>>>>>> Lenovo Yoga Book X91F
>>>>>>>> Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2
>>>>>>>>
>>>>>>>> I have more hw which I believe is affected but these are the models
>>>>>>>> where I have done detailed testing.
>>>>>>>>
>>>>>>>> I would be happy to test any patches, or run a kernel with some extra
>>>>>>>> debugging added, just let me know what you need to help fixing this.
> 
>>> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> Subject: [PATCH] serial: 8250: Prevent starting up DMA Rx on THRI interrupt
>>>
>>> Hans de Goede reported Bluetooth adapters (HCIs) connected over an UART
>>> connection failed due corrupted Rx payload. The problem was narrowed
>>> down to DMA Rx starting on UART_IIR_THRI interrupt. The problem occurs 
>>> despite LSR having DR bit set, which is precondition for attempting to 
>>> start DMA Rx.
>>>
>>> This problem became apparent after e8ffbb71f783 ("serial: 8250: use
>>> THRE & __stop_tx also with DMA") changed Tx stopping to get triggered
>>> using THRI interrupt.
>>>
>>> Don't setup DMA Rx on UART_IIR_THRI but leave it to a subsequent
>>> interrupt which has Rx related IIR value.
>>>
>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> I can confirm that this fixes things for me:
>>
>> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> Okay, thanks for testing.
> 
> Here's is a slightly improved debug patch which will count how many 
> characters are received by DMA and non-DMA rx. It should be tested 
> WITHOUT the fix.
> 
> I'm mostly interested in knowing if it's purely DMA Rx issue or whether 
> the non-DMA rx is muddling the waters too. While investigating other 
> issues I've seen UART_IIR_TIMEOUT (inter-character timeout) to often come 
> so early from UART that the tail of characters is left there to be handled 
> by the non-DMA path.

Ok, here is a new log:

https://fedorapeople.org/~jwrdegoede/dmesg-8250-dma-issue-2

With one successful hci_uart probe and one failed. The failed one looks interesting:

[  576.808776] 8250irq: iir=cc lsr+saved=60 received=1/12 ier=0d dma_t/rx/err=0/1/0 cnt=-4
[  576.808870] Bluetooth: hci0: Frame reassembly failed (-84)

This is the only time that debug message shows anything but 0 for data received over dma. It looks like for all these small packets dma simply never kicks in and the extra IRQ from the THRI interrupt somehow starts a DMA transfer for the one byte and for some reason that DMA transfer always reads the byte as 0.

Note that the amount of received bytes is still correct, so the 1 byte transfer by DMA replaces one byte which would be otherwise read from MMIO (I guess its MMIO?), but it has the wrong (all bits 0) content.

Regards,

Hans


