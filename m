Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A47C07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AFE61374
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 07:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhGNIBr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:01:47 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46978 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhGNIBq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 04:01:46 -0400
Received: by mail-wr1-f45.google.com with SMTP id d12so1984265wre.13;
        Wed, 14 Jul 2021 00:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w1b6wrWBKDKa+tZj2BRGOgdt3If+IOv+NClRdPNKcBM=;
        b=i8TEsoj8sokpDLOGUixv3RBwmDnYqp9xviN9mTQUnaPfIzBJIr7giU1BeIDV0PYmam
         g9EjK8yBDymEsmDIAvChYJOB0PX8rBGkKYo7uPXpc0sRokQCV1zi1c/Vk7vg/edVuVH6
         8FZOZyc6Y3Gh1BRDDE/pSWfwRXsY3PswKWsrdBVksn9IVs1iACUBLPPO9v9pw6q0orh1
         +3uQY3kIU7laj2zmlQO3BegrGGYUyUl2/ZvOlqWdrEWVp1MINUwXTlaJElDrSAVjsXl+
         9HqlMyWkQ1F2TuzS6fc3wWxdhuD1jc2LS20slwh680bTBiTkco+YHhL+Fvl+/o+Qui2r
         bG4g==
X-Gm-Message-State: AOAM531Su37pjqoLE2hCEC1C6X1oudHLqzIp7AmE6WWiKc/yIhjUPOa4
        4mAxj8jCCLjan5bYdAFgwoSx/wDtP8nSHQ==
X-Google-Smtp-Source: ABdhPJwPiZtOidE+kXKOB8zP/AitNMoyELHpBDkGKEgZ8xjPkTHgfAPY2I0Fhi98OW30ehHRa+RbxA==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr11844778wrn.62.1626249534391;
        Wed, 14 Jul 2021 00:58:54 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h9sm1265193wmb.35.2021.07.14.00.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 00:58:53 -0700 (PDT)
Subject: Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
Message-ID: <33767cf0-2104-d7aa-2da8-5a3f5f20a654@kernel.org>
Date:   Wed, 14 Jul 2021 09:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14. 07. 21, 8:54, Jiri Slaby wrote:
>> @@ -3994,14 +3982,9 @@ pciserial_init_ports(struct pci_dev *dev, const 
>> struct pciserial_board *board)
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

Forget about this line, I wasn't woken enough. Of course, MSI (writes) 
to bus need bus mastering.

In any case, I'm still not sure what happens to devices which do not 
support MSI if we enable mastering on them?

-- 
js
suse labs
