Return-Path: <SRS0=NZaJ=55=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A1AC2BA19
	for <linux-serial@archiver.kernel.org>; Mon, 13 Apr 2020 14:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C644B20732
	for <linux-serial@archiver.kernel.org>; Mon, 13 Apr 2020 14:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PbP54Ndq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgDMONd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:13:33 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31079 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730417AbgDMONc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Apr 2020 10:13:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586787211; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=xYDfmi3y4GT8mtW5rchs7Qjl6eBp/KfvShM945Y8we0=; b=PbP54NdqCYgtHoj1adUu4djz4Qb/nDibJFdZLqklkpH0AKz75VZSnW67tPECYoISQdsr6dNe
 os8HHBXVxeGxR9kjUYBOCWRXUnu5wI+UpvOgCoNa7nU3b7sqq/2QKVdkICnlMjMKWIMBUcvo
 8ztEhZkxwQ5GEZXQfR7P67Ozl2E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e947389.7fdcdfcccb90-smtp-out-n03;
 Mon, 13 Apr 2020 14:13:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CACC2C433BA; Mon, 13 Apr 2020 14:13:27 +0000 (UTC)
Received: from [10.111.193.245] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4169AC433F2;
        Mon, 13 Apr 2020 14:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4169AC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 02/21] tty: serial: qcom_geni_serial: Use OPP API to set
 clk/perf state
To:     Akash Asthana <akashast@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-3-git-send-email-rnayak@codeaurora.org>
 <5eb6c05e-893a-ef8a-c53e-a775b2f837d1@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <d9b3ebcb-90b0-c596-3832-2669bdb35b9b@codeaurora.org>
Date:   Mon, 13 Apr 2020 19:43:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5eb6c05e-893a-ef8a-c53e-a775b2f837d1@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[]..

>> @@ -1318,13 +1321,16 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>       if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
>>           port->cts_rts_swap = true;
>> +    port->se.opp = dev_pm_opp_set_clkname(&pdev->dev, "se");
>> +    dev_pm_opp_of_add_table(&pdev->dev);
>> +
>>       uport->private_data = drv;
>>       platform_set_drvdata(pdev, port);
>>       port->handle_rx = console ? handle_rx_console : handle_rx_uart;
>>       ret = uart_add_one_port(drv, uport);
>>       if (ret)
>> -        return ret;
>> +        goto err;
>>       irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
>>       ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
>> @@ -1332,7 +1338,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>       if (ret) {
>>           dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
>>           uart_remove_one_port(drv, uport);
>> -        return ret;
>> +        goto err;
>>       }
>>       /*
>> @@ -1349,11 +1355,14 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>           if (ret) {
>>               device_init_wakeup(&pdev->dev, false);
>>               uart_remove_one_port(drv, uport);
>> -            return ret;
>> +            goto err;
>>           }
>>       }
>>       return 0;
>> +err:
>> +    dev_pm_opp_of_remove_table(&pdev->dev);
> do we need to call "dev_pm_opp_put_clkname" here and in remove to release clk resource grabbed by
> 
> dev_pm_opp_set_clkname(&pdev->dev, "se");?

Thanks for catching this, I did indeed try to call dev_pm_opp_put_clkname() but the way clk_put
is handled in it seems buggy. I need to go back and fix it. Besides I realized dev_pm_opp_of_remove_table()
does go ahead and do a clk_put on the clock.

Viresh, whats the right way to clean up

>> +    port->se.opp = dev_pm_opp_set_clkname(&pdev->dev, "se");
>> +    dev_pm_opp_of_add_table(&pdev->dev);

is it
1. dev_pm_opp_of_remove_table()
    dev_pm_opp_put_clkname()

or
2. dev_pm_opp_put_clkname()
    dev_pm_opp_of_remove_table()

or, what this patch is currently doing, which is just calling dev_pm_opp_of_remove_table()?

Note that both 1. and 2. today result in a crash, since they don't handle clk_put very well.
I can send in a fix if you think dev_pm_opp_put_clkname is needed and in a certain order.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
