Return-Path: <SRS0=GPH0=AY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2605C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jul 2020 16:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D792065E
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jul 2020 16:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=g-clemson-edu.20150623.gappssmtp.com header.i=@g-clemson-edu.20150623.gappssmtp.com header.b="RCE1Tdvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgGMQ05 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgGMQ05 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jul 2020 12:26:57 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3FAC061755
        for <linux-serial@vger.kernel.org>; Mon, 13 Jul 2020 09:26:57 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h17so6058402qvr.0
        for <linux-serial@vger.kernel.org>; Mon, 13 Jul 2020 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5IwiE3MW39I8Vdq2ru7qR/S54NS/AS9DRHW+hinUxDk=;
        b=RCE1Tdvi4WMnVU+9MCaZDDeE0L22wxMglilTrCx7jC8fWbykrwgtPMonAII+n4awOx
         Z6qBwfwnOKeAiB2kx4ihuffQfImUkhmB1dD+gY3CGnMTDDyikRzRdJhYvDjgPmeraszY
         2EQAc+HEdTImPbhqFbiKFgXYLKbckAbz3X+pSDU7LYYLAIaaAbSPWzsvA7oob1Jtz5T4
         MZmNlb9R23ZGhCNNL6bG2v9Brajmi6+oLQE/hSAp7Dsi3tE2CTRZ/F5T9ni4egumDDQB
         v5Xkru1ohzX39Bq58IQT+Nxc+uLrdHFbXralEMZWcIf1PcRw+OpJcLPczTeQBEP2Z8BX
         IOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5IwiE3MW39I8Vdq2ru7qR/S54NS/AS9DRHW+hinUxDk=;
        b=oWfNiOnD31fuOGr81d8uROUYot0IiLBOdZ9tHfoycGUifxfqodhZ3FiRaTqTu8XTtz
         WAw9ycnTjkHuHPBBP7jqAKCVXX869FFn6HsdeAH3Rg/2BNVCYSuOHspDLE6jRxB+fEFI
         dFKs+ZWBotIPVp0nZAzGT99bwPEmY2G5DoSW/USoLpKVFdehukbTyqVuSVcDHfXRhxnZ
         KzpoJs89wnhg2LpSmJm+3f7THgWKn/EAPKnK7aXv34gWYeLWCshH1Ox+WXcreAm9Xkm+
         nFR+eL9dx7Vp0uT5omBt0aHmSiSNUpnoG61xC8p/vPOzxJP+vvNSFN54ED/kBnlI0A8q
         v/8Q==
X-Gm-Message-State: AOAM530jwLNOYwPhKuu/KwD9A+PZRB6vlwD8O1mvJ9HPWY0aS58Hv1DV
        BxPjvPxu+QgM9j+Rjr7MBmdVUPJgVOmJDw==
X-Google-Smtp-Source: ABdhPJwuTTeJD2w46fewFhNtOplui/KVkMBmi87Wfh/O8pFauQZlYYtVDry1LeCEWG80bvqMs0b1CQ==
X-Received: by 2002:a0c:f214:: with SMTP id h20mr223019qvk.131.1594657616250;
        Mon, 13 Jul 2020 09:26:56 -0700 (PDT)
Received: from [10.0.2.15] ([12.18.222.50])
        by smtp.gmail.com with ESMTPSA id t138sm18563012qka.15.2020.07.13.09.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 09:26:55 -0700 (PDT)
Subject: Re: [PATCH v2] serial: exar: Fix GPIO configuration for Sealevel
 cards based on XR17V35X
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com
References: <156b27a1-82c5-090e-0ae8-86944b849d6d@g.clemson.edu>
 <20200711064014.GA2786431@kroah.com>
From:   Matthew Howell <mrhowel@g.clemson.edu>
Message-ID: <c2c183d1-4a90-199a-23ad-2a736e431b27@g.clemson.edu>
Date:   Mon, 13 Jul 2020 12:26:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200711064014.GA2786431@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 7/11/20 2:40 AM, Greg KH wrote:
> On Fri, Jul 10, 2020 at 04:33:00PM -0400, Matthew Howell wrote:
>>
>> From: Matthew Howell <mrhowel@g.clemson.edu>
>>
>> Sealevel XR17V35X based devices are inoperable on kernel versions
>> 4.11 and above due to a change in the GPIO preconfiguration introduced in commit
>> 7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
>> cards to the value (0x00) used prior to commit 7dea8165f1d
>>
>> Fixes: 7dea8165f1d ("serial: exar: Preconfigure xr17v35x MPIOs as output")
>> Signed-off-by: Matthew Howell <mrhowel@g.clemson.edu>
>> ---
>>
>> This is a revised patch submission based on comments received on
>> the previous submission.
>> See https://www.spinics.net/lists/linux-serial/msg39348.html
>>
>> I am using a different email address to address the email footer issue,
>> and I have attempted to fix the formatting issues.
>
> The footer issues are fixed, but you should probably change the from:
> and signed-off-by to your company address, right?
>

That would be optimal, yes. However, I don't have direct control over
the footer as it is enforced by our email server / group policy. Let
me know if the company email is *required* to be in the from: field
for this patch to be accepted though I will see if there is any way I
can get an exemption in this case.

>>
>> Summary/justification of the patch is below.
>>
>> With GPIOs preconfigured as per commit 7dea8165f1d all ports on Sealevel
>> XR17V35X based devices become stuck in high impedance mode, regardless of
>> dip-switch or software configuration. This causes the device to become
>> effectively unusable. This patch (in various forms) has been distributed
>> to our customers and no issues related to it have been reported.
>
> Why not put that paragraph in the changelog as well?

It is my understanding that the message above signed-off-by is
included as the commit message and should be as short as possible,
while additional information and justification is provided below the
sign-off-by line. Is that not the case? If it is preferable to be
above signed-off-by line I can move it to there.

>
>>
>> Let me know if any changes need to be made.
>>
>> --- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
>> +++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-09 11:05:25.275891627 -0400
>> @@ -326,7 +326,7 @@ static void setup_gpio(struct pci_dev *p
>>       * devices will export them as GPIOs, so we pre-configure them safely
>>       * as inputs.
>>       */
>> -    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
>> +    u8 dir = (pcidev->vendor == PCI_VENDOR_ID_EXAR && pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL) ? 0xff : 0x00;
>
> That's a horrible line to try to read now, right?
>
> Why not turn it into a real if statement so we can make more sense of it
> over time:
>
>     u8 dir = 0x00;
>
>     if ((pcidev->vendor == PCI_VENDOR_ID_EXAR) &&
>         (pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL))
>         dir = 0xff;
>
> Looks better, right?
>
> thanks,
>
> greg k-h

Thanks for that feedback. It must have been unclear since the value of
dir in your if statement has the wrong value. Revised patch diff with
added comments is below.

--- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
+++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-13 11:54:44.386718167 -0400
@@ -326,7 +326,20 @@ static void setup_gpio(struct pci_dev *p
      * devices will export them as GPIOs, so we pre-configure them safely
      * as inputs.
      */
-    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
+
+    u8 dir = 0x00;
+
+    if  ((pcidev->vendor == PCI_VENDOR_ID_EXAR) &&
+        (pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL))
+    {
+       // Configure GPIO as inputs for Commtech adapters
+       dir = 0xff;
+    }
+    else
+    {
+       // Configure GPIO as outputs for SeaLevel adapters
+       dir = 0x00;
+    }
 
     writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
     writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);

--

Thanks,
Matthew Howell

