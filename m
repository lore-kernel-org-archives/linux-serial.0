Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DFCC07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2F2613B7
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 12:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhGNM63 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:58:29 -0400
Received: from mta02.hs-regensburg.de ([194.95.104.12]:57498 "EHLO
        mta02.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGNM63 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 08:58:29 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jul 2021 08:58:28 EDT
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S03", Issuer "E16S03" (not verified))
        by mta02.hs-regensburg.de (Postfix) with ESMTPS id 4GPy5D0TgKzyKv;
        Wed, 14 Jul 2021 14:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1626266992;
        bh=0CtFi6kf50KzSJTbgdjhxL+nHslBoWYbSgQkNnXWe48=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=twUaIoDXiGsfy4Hi2vPBV4v2dKleUXUGQoE1ndXp5yCESnUW3hJ8Zp/EKgiWoxiA/
         uapj2Nvc1wyJ9H7HCfrF1YcxQVT8gqUo20NW0tpu4X/NMf2itNXxHtyxUI2G1fAx9E
         o6qVkhB+COr7mbIvEnwQpk1qI2ukmykhOb5hw3Z2U/usotCJeKUYtrnUeaK85niKAu
         jPg/SpcmdtLlC3kio/glzALlpA69GVI9eaM9m5ml17afwvvFi9s98eVRUvrKyQrNjK
         5bDnUhHd4BRv0H/4Rxf0r2vbCp8ZdxJhyuC+fTGPXDidNfagUJYrZAp3ZjttOX64+r
         gGHvGbOH8Si7w==
Received: from [IPv6:2001:638:a01:8061:5c51:6883:5436:5db]
 (2001:638:a01:8013::138) by E16S03.hs-regensburg.de (2001:638:a01:8013::93)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.10; Wed, 14 Jul
 2021 14:49:51 +0200
Subject: Re: [EXT] Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
To:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Message-ID: <784629f9-677e-ee53-aceb-89397ce0951a@oth-regensburg.de>
Date:   Wed, 14 Jul 2021 14:49:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2001:638:a01:8013::138]
X-ClientProxiedBy: E16S04.hs-regensburg.de (2001:638:a01:8013::94) To
 E16S03.hs-regensburg.de (2001:638:a01:8013::93)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 14/07/2021 08:54, Jiri Slaby wrote:
> On 13. 07. 21, 12:40, Andy Shevchenko wrote:
>> There is no need to try MSI/MSI-X only on selected devices.
>> If MSI is not supported while neing advertised it means device
> 
> being
> 
>> is broken and we rather introduce a list of such devices which
>> hopefully will be small or never appear.
> 
> Hmm, have you checked the commit which introduced the whitelist?
> 
>     Nevertheless, this needs to handled with care: while many 8250 devices
>     actually claim to support MSI(-X) interrupts it should not be
> enabled be
>     default. I had at least one device in my hands with broken MSI
>     implementation.
> 
>     So better introduce a whitelist with devices that are known to support
>     MSI(-X) interrupts. I tested all devices mentioned in the patch.
> 
> 
> You should have at least CCed the author for an input.

Yep, back then I was testing three different 8250 pci cards. All of them
claimed to support MSI, while one really worked with MSI, the one that I
whitelisted. So I thought it would be better to use legacy IRQs as long
as no one tested a specific card to work with MSI.

> 
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/tty/serial/8250/8250_pci.c | 28 ++++++++--------------------
>>   1 file changed, 8 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_pci.c
>> b/drivers/tty/serial/8250/8250_pci.c
>> index 937861327aca..02825c8c5f84 100644
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -58,18 +58,6 @@ struct serial_private {
>>     #define PCI_DEVICE_ID_HPE_PCI_SERIAL    0x37e
>>   -static const struct pci_device_id pci_use_msi[] = {
>> -    { PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
>> -             0xA000, 0x1000) },
>> -    { PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
>> -             0xA000, 0x1000) },
>> -    { PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
>> -             0xA000, 0x1000) },
>> -    { PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR,
>> PCI_DEVICE_ID_HPE_PCI_SERIAL,
>> -             PCI_ANY_ID, PCI_ANY_ID) },
>> -    { }
>> -};
>> -

Don't do that… And don't convert it to a blacklist. A blacklist will
break users until they report that something doesn't work.

  Ralf

>>   static int pci_default_setup(struct serial_private*,
>>         const struct pciserial_board*, struct uart_8250_port *, int);
>>   @@ -3994,14 +3982,9 @@ pciserial_init_ports(struct pci_dev *dev,
>> const struct pciserial_board *board)
>>       if (board->flags & FL_NOIRQ) {
>>           uart.port.irq = 0;
>>       } else {
>> -        if (pci_match_id(pci_use_msi, dev)) {
>> -            dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
>> -            pci_set_master(dev);
>> -            rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
>> -        } else {
>> -            dev_dbg(&dev->dev, "Using legacy interrupts\n");
>> -            rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
>> -        }
>> +        pci_set_master(dev);
> 
> But bus mastering is not about MSIs. I *think* it's still OK, but you
> need to document that in the commit log too.
> 
> Actually, why the commit which added this code turns on bus mastering?
> 
>> +
>> +        rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
>>           if (rc < 0) {
>>               kfree(priv);
>>               priv = ERR_PTR(rc);
>> @@ -4009,6 +3992,11 @@ pciserial_init_ports(struct pci_dev *dev, const
>> struct pciserial_board *board)
>>           }
>>             uart.port.irq = pci_irq_vector(dev, 0);
>> +
>> +        if (pci_dev_msi_enabled(dev))
>> +            dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
>> +        else
>> +            dev_dbg(&dev->dev, "Using legacy interrupts\n");
>>       }
>>         uart.port.dev = &dev->dev;
>>
> 
> thanks,
