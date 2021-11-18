Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0485C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 14:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D797A613D0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 14:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhKROst (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 09:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhKROss (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 09:48:48 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEF9C061574
        for <linux-serial@vger.kernel.org>; Thu, 18 Nov 2021 06:45:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n85so6221125pfd.10
        for <linux-serial@vger.kernel.org>; Thu, 18 Nov 2021 06:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B7hIaWZDJSqH7ZBKx51wYV/GWlEC3ywkcW+qADgYkvg=;
        b=dwoQNt3Jff5uTYpDvrDpEMhncekuP4IdCvez5HTvKbWwUnX2o33eeQbAxaOovIBeOA
         sUd5YNXqK0pe0p7Mt8aeFe19S6s7+Cm9x4bTtXfUZ4+R8irv8OrfL/Q14X5kJmSn8+am
         /bCX8kUusvnC6+MnU79ZfBfZZG+OOkuC11DkYQCcUZfG6b5eV9AIGdB/CI+CvtRvd2/y
         HvqUrXlmkn+g5K0180q26/NbNzIPdPfuA4w3LJRxJ6nOYZnQ2TN1eLq1uq5Fx6FJ2PPp
         ibGB9fK+ARRAidQ03sKqugVFgax2WRGwKBSIwc1nABJg57qCrxUiEl0ztupiEcpvXmwU
         g0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B7hIaWZDJSqH7ZBKx51wYV/GWlEC3ywkcW+qADgYkvg=;
        b=q6tSZVRnAAUtLHsfex1BkZrKNGV0n2kJwmesNyBbG3bm0qdvgNvq3MFHzeYy8YDQO4
         KYkG9i0iTU4gYbt1tGQeO1dN318PoJ1PuvkuVDyUugT+680Cc3Z9tFXZoVuOpNIw/cid
         UJW838c0FxhQtG4wOWEZ5RoHVtTlFWrutQT1MDMhdkkm+aP1/Jmqz/6fG8bDK3p0An2o
         ZOmCpSHmjd8nMdg1ZvG5qqWcoGIcOx5eCiUs5FXHhHFbLtn0tqJZ7KArVyHgKCquox91
         19wKxkEzv5vpQ0UC/fm1VYc2bo7GScvuV0/2QhplJWr1k/zZH6fbZBD0u5KRElIB/99h
         1AIw==
X-Gm-Message-State: AOAM532kBIwbJWDF/svcJnAchxpb6vdg3dp1Z2kZcVm0+3PLVTFN6uup
        HrVBbC7zl5K4TwtgxjXUsvrg
X-Google-Smtp-Source: ABdhPJxq8gmwavKfvux/U/MN1E2smM3lGLnJjd9vJM85cjy4lh+fyuA9/gHkkS8Ep/+fCvvWZHFNlQ==
X-Received: by 2002:a63:91c2:: with SMTP id l185mr11505340pge.57.1637246747985;
        Thu, 18 Nov 2021 06:45:47 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id m127sm2545416pgm.64.2021.11.18.06.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 06:45:47 -0800 (PST)
Subject: Re: [PATCH v1 1/2] serial: 8250_pci: Split out Pericom driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <20211117145750.43911-2-andriy.shevchenko@linux.intel.com>
 <36a3c24a-59c1-2537-14ef-c750aaa55ea9@accesio.com>
 <CAHp75VfDPuPbvRsfKX2+0NT0K36-+xzDA2QscXD5Wcta1Q5zuQ@mail.gmail.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <9fcd2bbf-069b-aae5-07e2-e1faa9aa6428@accesio.com>
Date:   Thu, 18 Nov 2021 06:45:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfDPuPbvRsfKX2+0NT0K36-+xzDA2QscXD5Wcta1Q5zuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/18/21 1:50 AM, Andy Shevchenko wrote:
> On Thu, Nov 18, 2021 at 4:39 AM Jay Dolan <jay.dolan@accesio.com> wrote:
>> On 11/17/21 6:57 AM, Andy Shevchenko wrote:
> 
> Thanks for looking into it. My answer below.
> 
> ...
> 
>>> +     for (i = 0; i < nr && i < maxnr; i++) {
>>> +             unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
>> I'm told this works for PCIe ACCES PIDS, but the PCI PIDs don't have the
>> fourth port at the wrong address. I didn't know this until just now.
> 
> For the sake of context I left below PCI IDs, all of them have PCIE
> prefix. Moreover, the patch should not change this logic (see
> different setup functions in the original code). So if it wasn't
> working it is not working anyway. Besides that, what does the above
> mean? The ID can't be the same for two different hardware.You're right. I think I was confused first. I sent the list of PIDs to 
someone who knows all the products to verify. Either way I will get this 
tested tonight.
> 
>> I've never had reason to try and tell if a pci_dev is PCI or PCIe. Can
>> we query capabilities?
> 
> This is confusing me. What does all this imply?
> 
>> It may also be possible to tell by the size of
>> one of the BARs.
> 
> This is already done by calculating maxnr.
> 
>> I've requested a four port PCI card and should have it
>> tomorrow.
> 
> I'm looking forward to seeing any test results.
> 
>> I'm currently building the previous patch set for testing.
> 
> Noted, thanks!
> 
> ...
> 
>>> +     { PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7951) },
>>> +     { PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7952) },
>>> +     { PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7954) },
>>> +     { PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7958) },
>>> +
>>> +     /*
>>> +      * ACCES I/O Products quad
>>> +      * (Only 7954 has an offset jump for port 4)
>>> +      */
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_2SDB) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_2S) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM422_4) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM485_4) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SDB) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_4S) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM422_8) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM485_8) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_2DB) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM232_2) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_4) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_4DB) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM232_4) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_8) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_2SMDB) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_2SM) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SM) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SMDB) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_4SM) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_8SM) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_1) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM422_2) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_2) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM422_4) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_4) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_2S) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_4S) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM232_2) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM232_2) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM232_4) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM232_4) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_2SM) },
>>> +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_4SM) },
> 
