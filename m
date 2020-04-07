Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B144FC2BBC7
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891A1206F7
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 09:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xbkfrpkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgDGJzI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:55:08 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:40478 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728178AbgDGJzH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 05:55:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586253307; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=82g7s3h7enEh+MnyvkTIef7YuXwt3pby8b9ZJPdxNEc=; b=xbkfrpklHLG19miAXIdurfwdpJ4BL+gPpkTiRK8swwRMWaroRJtWWn8XMPl4MUBpnHfeWcju
 9lzzSZ2hN5kF/shYaziOqekd/bs5wGutUFdw1rLr8/vZE3UOxTqsP6LXFd8AXQJciT6Tjv2H
 uRANrnxTNPgBy6xgJKmbWFHCd8g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c4dec.7fe852937340-smtp-out-n04;
 Tue, 07 Apr 2020 09:54:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E95CFC43636; Tue,  7 Apr 2020 09:54:50 +0000 (UTC)
Received: from [192.168.0.6] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9E4AC433D2;
        Tue,  7 Apr 2020 09:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9E4AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH V3 7/8] spi: spi-qcom-qspi: Add interconnect support
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de,
        mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@chromium.org
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-8-git-send-email-akashast@codeaurora.org>
 <20200331112352.GB4802@sirena.org.uk>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <f896d6e4-cc86-db46-a9b9-d7c98071b524@codeaurora.org>
Date:   Tue, 7 Apr 2020 15:24:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331112352.GB4802@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Mark,

On 3/31/2020 4:53 PM, Mark Brown wrote:
> On Tue, Mar 31, 2020 at 04:39:35PM +0530, Akash Asthana wrote:
>
>> +	/*
>> +	 * Set BW quota for CPU as driver supports FIFO mode only.
>> +	 * Assume peak bw as twice of avg bw.
>> +	 */
>> +	ctrl->avg_bw_cpu = Bps_to_icc(speed_hz);
>> +	ctrl->peak_bw_cpu = Bps_to_icc(2 * speed_hz);
> I thought you were going to factor this best guess handling of peak
> bandwidth out into the core?

I can centralize this for SPI, I2C and UART  in Common driver(QUP 
wrapper) but still for QSPI I have to keep this piece of code as is 
because It is not child of QUP wrapper(it doesn't use common code).

I am not sure whether I can move this " Assume peak_bw as twice of 
avg_bw if nothing is mentioned explicitly" to ICC core because the 
factor of 2 is chosen randomly by me.

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
