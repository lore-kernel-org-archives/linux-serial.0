Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F963C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 12:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFEE233E2
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgLGMYr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Dec 2020 07:24:47 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:22232 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgLGMYr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Dec 2020 07:24:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607343867; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+mUTQzvbhSGlGo6aoMkrl/HRw3qNTx/tD8A12F6p1U8=; b=TwYff87JWSFJK2My3vmlUAoH6jBpPtKdZoNRmADYbNm3ZsWQpbAdqfsxQG3GPyspsuHzUxsM
 oZ5I179bZgEgSU2ZeZ3i+it+i3J1YyONK3sce1T5wUJceoAk9fMt0jxQPBkeHEe7jiE/v3a+
 AapykoypV8jJPLD6bOpB5pxcWfo=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fce1edb4afea888935a8be3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 12:23:55
 GMT
Sender: akashast=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A867DC433ED; Mon,  7 Dec 2020 12:23:54 +0000 (UTC)
Received: from [192.168.43.89] (unknown [106.205.31.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 637C9C433CA;
        Mon,  7 Dec 2020 12:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 637C9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH 3/3] Serial: Separate out earlycon support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mka@chromium.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, saravanak@google.com
References: <1607330847-15522-1-git-send-email-akashast@codeaurora.org>
 <1607330847-15522-4-git-send-email-akashast@codeaurora.org>
 <X835NxSOLM7+17T6@kroah.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <7c2e0928-e9ee-fc0d-7a6e-784591adf25a@codeaurora.org>
Date:   Mon, 7 Dec 2020 17:53:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X835NxSOLM7+17T6@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On 12/7/2020 3:13 PM, Greg KH wrote:
> On Mon, Dec 07, 2020 at 02:17:27PM +0530, Akash Asthana wrote:
>> Separate out earlycon support from serial driver and remove it's
>> dependency on QUP wrapper driver.
>>
>> This enable us to manage earlycon independently and we can re-use the
>> same earlycon driver for android project which currently uses
>> downstream version of QUP drivers.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>>   drivers/tty/serial/Kconfig              |   9 +
>>   drivers/tty/serial/Makefile             |   1 +
>>   drivers/tty/serial/qcom_geni_earlycon.c | 649 ++++++++++++++++++++++++++++++++
>>   drivers/tty/serial/qcom_geni_serial.c   |  97 -----
>>   4 files changed, 659 insertions(+), 97 deletions(-)
>>   create mode 100644 drivers/tty/serial/qcom_geni_earlycon.c
> Nit, your subject line shoudl say somewhere that this is the qcom
> earlycon driver/support, not "earlycon in general".
Thanks for feedback, I will take care of it in next post.
>
> thanks,
>
> greg k-h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

