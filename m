Return-Path: <SRS0=da9C=AL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5795C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 30 Jun 2020 03:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A54E20674
	for <linux-serial@archiver.kernel.org>; Tue, 30 Jun 2020 03:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="g2AJAlqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgF3DBT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:01:19 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:49944 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726746AbgF3DBR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jun 2020 23:01:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593486077; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=TmTHo9sjEwFtDvDXBnSxvr/8LyWkD3WRp2zUg0bfLGM=; b=g2AJAlqN8dMuGpJ4/eNk8TxtDS+jzpy5TskGXBe7gnJLdbQ2OAwPLSMmD+toLl6zuROnVDmC
 bTpot1FIblgxF4SoEG39odRPDpZGMOkovswU2xQa/bSJlpv55WrMPIpl49hvfH9hLGqnfPFs
 7pelSIcKZCDlmOZDeK/4jSNUZ58=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5efaaaf7356bcc26ab438f64 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 03:01:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD401C433AF; Tue, 30 Jun 2020 03:01:10 +0000 (UTC)
Received: from [10.50.61.98] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C142C433CA;
        Tue, 30 Jun 2020 03:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C142C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 1/6] tty: serial: qcom_geni_serial: Use OPP API to set
 clk/perf state
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@chromium.org,
        robdclark@gmail.com, stanimir.varbanov@linaro.org
Cc:     viresh.kumar@linaro.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-2-git-send-email-rnayak@codeaurora.org>
 <159347264530.1987609.11350620235820019545@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <a3d53f82-b29d-97ef-3ba1-ca9bd650d354@codeaurora.org>
Date:   Tue, 30 Jun 2020 08:31:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159347264530.1987609.11350620235820019545@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 6/30/2020 4:47 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2020-06-15 05:02:39)
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 457c0bf..a90f8ec 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pm_wakeirq.h>
>> @@ -962,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>>                  goto out_restart_rx;
>>   
>>          uport->uartclk = clk_rate;
>> -       clk_set_rate(port->se.clk, clk_rate);
>> +       dev_pm_opp_set_rate(uport->dev, clk_rate);
> 
> If there isn't an OPP table for the device because it is optional then
> how can we unconditionally call dev_pm_opp_set_rate()?

because we have 'aca48b6 opp: Manage empty OPP tables with clk handle' to handle this.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
