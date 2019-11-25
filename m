Return-Path: <SRS0=Up7l=ZR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC2C432C0
	for <linux-serial@archiver.kernel.org>; Mon, 25 Nov 2019 12:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804DE2075C
	for <linux-serial@archiver.kernel.org>; Mon, 25 Nov 2019 12:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EnMzBT2s";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BX7xUC+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfKYMGC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:06:02 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:33808
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfKYMGC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Nov 2019 07:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574683561;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=bFad5IkiyhfJQZbYiPRh9XpbsKyN32VFp/MCrxsY9JM=;
        b=EnMzBT2s2VMd0LcEFLfSWy8chvfitOD+eWr0QCGJG10Wm6arYvaeDKl1BClYzRxw
        Z0wBU3eHppISR1QUf5fDBd7JrTrl5R3EcjhnjLvWa2cw715ld7J7aVga/92DzxDrPBQ
        vcxGS6KbnI3lUiDq3CJ0b3dmUriWSQCHE4ecK7x4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574683561;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=bFad5IkiyhfJQZbYiPRh9XpbsKyN32VFp/MCrxsY9JM=;
        b=BX7xUC+Nj/Ut/d325C6gkqI42MNLAvpaAI/BdMUjpK8bvxn5CaVe4g3lgdJKjKgF
        OebY2GzHb8oT4Wsp+XOCMiRdKdCZv+LcneoDIRpYYz+EJVTqfrWc+RZGmXzMy6KYlzC
        3Dp65rXutXxg46DWwGfBt74EDRO3RWzG4YhoeBmU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF8F8C447B1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH v6 4/5] tty: serial: qcom_geni_serial: Wakeup over UART RX
To:     Stephen Boyd <swboyd@chromium.org>, gregkh@linuxfoundation.org
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <1574432266-20732-1-git-send-email-akashast@codeaurora.org>
 <0101016e937a5b83-1c5c4e0e-ae63-447a-8724-52477b11dff4-000000@us-west-2.amazonses.com>
 <5dd82779.1c69fb81.c1de1.90e5@mx.google.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <0101016ea2744c4a-7adfad72-f828-4de1-b16f-e70970b3a343-000000@us-west-2.amazonses.com>
Date:   Mon, 25 Nov 2019 12:06:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5dd82779.1c69fb81.c1de1.90e5@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SES-Outgoing: 2019.11.25-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 11/22/2019 11:52 PM, Stephen Boyd wrote:
> Quoting Akash Asthana (2019-11-22 06:18:19)
>> Add system wakeup capability over UART RX line for wakeup capable UART.
>> When system is suspended, RX line act as an interrupt to wakeup system
>> for any communication requests from peer.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> One question below.
>
>> @@ -1330,6 +1354,10 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
>>          struct uart_driver *drv = port->uport.private_data;
>>   
>>          uart_remove_one_port(drv, &port->uport);
>> +
>> +       device_init_wakeup(&pdev->dev, false);
>> +       dev_pm_clear_wake_irq(&pdev->dev);
> Should this order be swapped? Usually remove is done in reverse of probe
> order, so clear_wake_irq, init wakeup, and remove uart port. I'm not
> convinced it will actually matter though so maybe this isn't a problem.
Ok, I will update the order here.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

