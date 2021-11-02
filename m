Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26539C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008B360E08
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKBHVl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 03:21:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47310 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhKBHVk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 03:21:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635837546; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=y6Sz6xkt/HSEuNS0flTXHuzKjPeOjD94Xhcr7nenToU=;
 b=S5lSnoZa0VrENqPxzaTyYk5IFGMK+ZCAEOHmZXavKSw2orC1G/v0TWNaAGuIGty0XcGZmX5H
 4BJSjnY/Zsd0FH8DXgrGmWYOLoDsr/Bt+IL7mVmmhF0FWW2rBf0f9UJnry8xEK9dqLO4lK6a
 myWB3rYcrjlNUMvKIWxLfRAqDjM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6180e65caeb239055603ddb9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Nov 2021 07:18:52
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56A90C4338F; Tue,  2 Nov 2021 07:18:52 +0000 (UTC)
Received: from [192.168.0.104] (unknown [183.195.15.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28A10C4360C;
        Tue,  2 Nov 2021 07:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 28A10C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
Subject: Re: [PATCH v1] serdev: Add interface serdev_device_ioctl
To:     Greg KH <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Zijun Hu <quic_zijuhu@quicinc.com>
References: <1635753048-5289-1-git-send-email-zijuhu@codeaurora.org>
 <YX+eRgCrUs2Y5iaX@kroah.com>
 <fe5a8bec-b186-c719-5f02-a0a67eb8862f@codeaurora.org>
 <YX+mDGr8tDzVT4Hr@kroah.com>
 <573d3640-2e8b-9266-4205-755ac0951abd@codeaurora.org>
 <YX/M/MZL8jbu7p7I@kroah.com>
 <DC399B43-DB1E-42AC-8A31-3A2C9407EE6D@holtmann.org>
 <YX/VYUC3ngOf5bX5@kroah.com>
Message-ID: <787fa2b6-146a-16b1-e304-c7e3b26dbf99@codeaurora.org>
Date:   Tue, 2 Nov 2021 15:18:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YX/VYUC3ngOf5bX5@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/1/2021 7:54 PM, Greg KH wrote:
> On Mon, Nov 01, 2021 at 12:45:36PM +0100, Marcel Holtmann wrote:
>> Hi Greg,
>>
>>>>>>>> For serdev_device which is mounted at virtual tty port, tty ioctl()
>>>>>>>> maybe be used to make serdev_device ready to talk with tty port, so
>>>>>>>> add interface serdev_device_ioctl().
>>>>>>>>
>>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>>> ---
>>>>>>>> drivers/tty/serdev/core.c           | 11 +++++++++++
>>>>>>>> drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
>>>>>>>> include/linux/serdev.h              |  9 +++++++++
>>>>>>>> 3 files changed, 32 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>>>>>>>> index f1324fe99378..c0f6cd64716b 100644
>>>>>>>> --- a/drivers/tty/serdev/core.c
>>>>>>>> +++ b/drivers/tty/serdev/core.c
>>>>>>>> @@ -405,6 +405,17 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
>>>>>>>> }
>>>>>>>> EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>>>>>>>>
>>>>>>>> +int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg)
>>>>>>>> +{
>>>>>>>> +	struct serdev_controller *ctrl = serdev->ctrl;
>>>>>>>> +
>>>>>>>> +	if (!ctrl || !ctrl->ops->ioctl)
>>>>>>>> +		return -EOPNOTSUPP;
>>>>>>>
>>>>>>> Wrong error for returning that an ioctl is not handled :(
>>>>>> checkpatch.pl always reports below WARNING when i use ENOTSUPP as present interfaces
>>>>>> do. so i change error code to EOPNOTSUPP.
>>>>>>
>>>>>> #28: FILE: drivers/tty/serdev/core.c:412:
>>>>>> +               return -ENOTSUPP;
>>>>>>
>>>>>> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
>>>>>
>>>>> Both of them are not the correct error to return when an ioctl is not
>>>>> supported.
>>>>>
>>>> is ENODEV okay?
>>>
>>> No, -ENOTTY is the correct one as per the documentation, right?
>>>
>>>>>>> Anyway, what in-tree driver needs this functionality?  Why does serdev
>>>>>>> need any ioctl commands?
>>>>>>>
>>>>>> i am developing driver for a special bluetooth controller which is integrated within SOC,
>>>>>> and it does not connect with the BT HOST with UART as normal controller do, but it has very
>>>>>> similar features as the BT controller with UART I/F. it is mounted on a virtual serial port
>>>>>> driven by a tty driver developed. but it need to call tty ioctl to make the 
>>>>>> special BT controller ready to talk with tty port. so i add this interface.
>>>>>
>>>>> Please submit this change when you submit your driver that uses it at
>>>>> the same time so we can review them all at once.  We do not add apis
>>>>> that are not used in the kernel tree.
>>>>>
>>>> okay
>>>>>> as you known, the main purpose of ioctl is to achieve MISC and irregular control. so it is useful
>>>>>> for these irregular devices.
>>>>>
>>>>> For tty devices, "custom" ioctls are not ok, use the standard tty
>>>>> commands and you should be fine for everything you need to do.
>>>>>
>>>>> If not, then perhaps your design is incorrect?
>>>>>
>>>> i just want to refer bt_ioctl within https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/tree/drivers/soc/qcom/bt_tty.c?h=NHSS.QSDK.11.5.0.5.r2
>>>> by serdev. so add this interface.
>>>
>>> The 5.4 kernel is not relevant here, so I do not understand.
>>>
>>>> are there any other good solution to advise?
>>>
>>> Why not work with the bluetooth developers on this?
>>
>> if this is just to have some hackish Bluetooth driver, then NAK from my side. Since we have serdev, we have no need for, or requirements for any ioctl anymore. If such thing is needed, it is a bad design.
> 
> Thanks for the confirmation, seems sane to me!
> 
> Zijun, please fix up your driver and submit it to be merged and all
> should be fine, no need for any custom ioctls.
> 
 thank you Greg, i have submitted all changes to support the special BT controller, certainly, it includes this serdev change.
> thanks,
> 
> greg k-h
> 
