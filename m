Return-Path: <SRS0=3tiM=ZS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D338C432C0
	for <linux-serial@archiver.kernel.org>; Tue, 26 Nov 2019 12:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C602082F
	for <linux-serial@archiver.kernel.org>; Tue, 26 Nov 2019 12:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oSTAzZaa";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="XsJP4pn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfKZMWA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:22:00 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:54890
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727733AbfKZMWA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Nov 2019 07:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574770919;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=Ttu+6ofExiF/Y4usUuA4r1/+Sh4A1mMo6YxP2R7eeGE=;
        b=oSTAzZaaZhF+/fbFYz4LiFOVfzyLpT/9OqpSmZTeTb6DDMyigaVn1VZZHWA/HSYT
        voOkhKxuO6fwcvaKaGulaKtQCoBtlkgIK32gqnFlPk5XXYJNqAbDKFXY50qFgYVtM2x
        y3OUJy98WRFDeiNckSG16SgSwgCxuv9CkEwqzK9Y=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574770919;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=Ttu+6ofExiF/Y4usUuA4r1/+Sh4A1mMo6YxP2R7eeGE=;
        b=XsJP4pn9e9orEZl6Fjl/lIBlLBQVtXNp4Z4lIJF0/0SNq+bNqFBNfciDZypIpG+Z
        aHIAUNPvKxC4+YRgouBOVlSY18dw7WbMVGY/vLNkROl7RqbFb7jT61kUuV9IYq7vlMs
        G/jierc7gjKFaU9O+VhldgnvnLK+AO+sixsORHcQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42C99C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH V7 1/2] tty: serial: qcom_geni_serial: Wakeup IRQ cleanup
To:     Stephen Boyd <swboyd@chromium.org>, gregkh@linuxfoundation.org
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org
References: <1574694511-31479-1-git-send-email-akashast@codeaurora.org>
 <0101016ea31bae6b-614d45a0-ddb0-4f82-b906-48850f439280-000000@us-west-2.amazonses.com>
 <5ddbfbec.1c69fb81.c6c96.3c18@mx.google.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <0101016ea7a9463f-6363f81f-3b22-4b66-b8c3-23c5bf1cc624-000000@us-west-2.amazonses.com>
Date:   Tue, 26 Nov 2019 12:21:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5ddbfbec.1c69fb81.c6c96.3c18@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SES-Outgoing: 2019.11.26-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 11/25/2019 9:36 PM, Stephen Boyd wrote:
> Quoting Akash Asthana (2019-11-25 07:08:50)
>> This patch is the continuation of below mentioned commits which adds wakeup
>> feature over the UART RX line.
>> 1)commit 3e4aaea7a039 ("tty: serial: qcom_geni_serial: IRQ cleanup")[v2]
>> 2)commit 8b7103f31950 ("tty: serial: qcom_geni_serial: Wakeup over UART
>>    RX")[v2]
>>
>> The following cleanup is done based on upstream comment received on
>> subsequent versions of the above-mentioned commits to simplifying the code.
>>   - Use devm_kasprintf API in place of scnprintf.
>>   - Use dev_pm_set_dedicated_wake_irq API that will take care of
>>     requesting and attaching wakeup irqs for devices. Also, it sets wakeirq
>>     status to WAKE_IRQ_DEDICATED_ALLOCATED as a result enabling/disabling of
>>     wake irq will be managed by suspend/resume framework. We can remove the
>>     code for enabling and disabling of wake irq from the this driver.
>>   - Use platform_get_irq_optional API to get optional wakeup IRQ for
>>     device.
>>   - Move ISR registration later in probe after uart port gets register with
>>     serial core.
>>
>> Patch link:
>>   - https://patchwork.kernel.org/patch/11189717/ (v3)
>>   - https://patchwork.kernel.org/patch/11227435/ (v4)
>>   - https://patchwork.kernel.org/patch/11241669/ (v5)
>>   - https://patchwork.kernel.org/patch/11258045/ (v6)
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Ok sure.
>
>> ---
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index ff63728..55b1d8b 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1302,50 +1294,58 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>          port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
>>          port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
>>   
>> -       scnprintf(port->name, sizeof(port->name), "qcom_geni_serial_%s%d",
>> -               (uart_console(uport) ? "console" : "uart"), uport->line);
>> +       port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
>> +                       "qcom_geni_serial_%s%d",
>> +                       uart_console(uport) ? "console" : "uart", uport->line);
>> +       if (!port->name)
>> +               return -ENOMEM;
>> +
>>          irq = platform_get_irq(pdev, 0);
>>          if (irq < 0)
>>                  return irq;
>>          uport->irq = irq;
>>   
>> +       if (!console)
>> +               port->wakeup_irq = platform_get_irq_optional(pdev, 1);
> Is there a DT binding update for this? It would be nice if the GENI SE
> binding was updated to by YAML.
Yes, there is DT binding update for this. Ok I will update GENI SE 
binding to YAML
>> +
>> +       uport->private_data = drv;
>> +       platform_set_drvdata(pdev, port);
>> +       port->handle_rx = console ? handle_rx_console : handle_rx_uart;
>> +       if (!console)
>> +               device_create_file(uport->dev, &dev_attr_loopback);
>> +

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

