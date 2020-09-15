Return-Path: <SRS0=fl1Y=CY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A461C433E2
	for <linux-serial@archiver.kernel.org>; Tue, 15 Sep 2020 12:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F49820936
	for <linux-serial@archiver.kernel.org>; Tue, 15 Sep 2020 12:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jdyT1mdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIOMkr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Sep 2020 08:40:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33230 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbgIOMje (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Sep 2020 08:39:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600173574; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=q83tXlqY1YChLzPyWawlyehR7bL/8FKHR0ivbfmuZug=; b=jdyT1mdikY1bNCY4vvSxAaH20230rbpu3lQSKYN+kkjIvGB8qrMG5Sf2ZghUXqiKWJQcBpI5
 fh2Okcn04MDtk2neMIsXxzIRKNmwNjbEG8a4UVSC0vNM8znlzSjlsxZZ7vo326hlb98e+vmg
 hD7vZoL19a6G67hnBMTjTl18o8I=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f60b5f9252c522440b1afb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 12:39:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 00CB2C433FE; Tue, 15 Sep 2020 12:39:21 +0000 (UTC)
Received: from [192.168.43.98] (unknown [47.8.185.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4B44C433CA;
        Tue, 15 Sep 2020 12:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4B44C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH V4] serial: qcom_geni_serial: To correct QUP Version
 detection logic
To:     Paras Sharma <parashar@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1600067957-8216-1-git-send-email-parashar@codeaurora.org>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <6662d92f-5b68-527a-cfb1-9c407c338953@codeaurora.org>
Date:   Tue, 15 Sep 2020 18:09:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600067957-8216-1-git-send-email-parashar@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Paras,

On 9/14/2020 12:49 PM, Paras Sharma wrote:
> The current implementation reduces the sampling rate by half
> if qup HW version is  greater is than 2.5 by checking if the
> geni SE major version is greater than 2 and geni SE minor version
> is greater than 5.This implementation fails when the version is
> greater than or equal to 3.
>
> Hence, a new macro QUP_SE_VERSION_2_5 is defined having value
> for major number 2 and minor number 5 as 0x20050000.Hence,if
> ver is greater than this value,sampling rate is halved.
> This logic would work for any future qup version.

Can we rewrite commit message something like below:

For QUP IP versions 2.5 and above the oversampling rate is halved from 
32 to 16.

Commit ce734600545f ("tty: serial: qcom_geni_serial: Update the 
oversampling rate") is pushed to handle this scenario.

But the existing logic is failing to classify QUP 3.0 to correct group ( 
2.5 and above).

As result SE clocks are not configured properly for baud rate and 
garbage data is sampled to FIFOs from the line.


So, fix the logic to detect QUP with versions 2.5 and above.

>
> Fixes: ce734600545f ("tty: serial: qcom_geni_serial: Update the oversampling rate")
> Signed-off-by: Paras Sharma <parashar@codeaurora.org>
> ---
> Changes in V4:
> Created a new macro QUP_SE_VERSION_2_5 for Qup se version 2.5

You can mention changes in V3 and V2 here.

>
>   drivers/tty/serial/qcom_geni_serial.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index f0b1b47..9b74b1e 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -106,6 +106,9 @@
>   /* We always configure 4 bytes per FIFO word */
>   #define BYTES_PER_FIFO_WORD		4
>   
> +/* QUP SE VERSION value for major number 2 and minor number 5 */
> +#define QUP_SE_VERSION_2_5                  0x20050000
> +

How about moving this Macro to common header, qcom-geni-se.h so that if 
needed other QUP driver also can use it.

Regards,

Akash

>   struct qcom_geni_private_data {
>   	/* NOTE: earlycon port will have NULL here */
>   	struct uart_driver *drv;
> @@ -1000,7 +1003,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>   	sampling_rate = UART_OVERSAMPLING;
>   	/* Sampling rate is halved for IP versions >= 2.5 */
>   	ver = geni_se_get_qup_hw_version(&port->se);
> -	if (GENI_SE_VERSION_MAJOR(ver) >= 2 && GENI_SE_VERSION_MINOR(ver) >= 5)
> +	if (ver >= QUP_SE_VERSION_2_5)
>   		sampling_rate /= 2;
>   
>   	clk_rate = get_clk_div_rate(baud, sampling_rate, &clk_div);

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

