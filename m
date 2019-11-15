Return-Path: <SRS0=rp3o=ZH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD92C432C3
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4D82072D
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 09:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T40OVsK+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GmuVV/eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKOJ55 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:57:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfKOJ54 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Nov 2019 04:57:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F9416167A; Fri, 15 Nov 2019 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573811875;
        bh=AE5Y7ye/S/PMi8MWphSIKqjpNO94HKcmJAqvFhD+Xvg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T40OVsK+Sxpt2SN++fT9ZWPgaAAWFBP/xEtyVNt0ZX3CFZSved+AJgILg6Vt71/FZ
         Zr6Wdu5ia1Au7C3Gj4J+//m1vfYaSUHnsIuz57SsguDNrI2PAOZ9cgwEr5+kBnVv+0
         7rgjy6uIfGQqqfcSbwp+Nph1qU4b6MvkCQDL5Nrc=
Received: from [192.168.0.8] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECC42611B9;
        Fri, 15 Nov 2019 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573811873;
        bh=AE5Y7ye/S/PMi8MWphSIKqjpNO94HKcmJAqvFhD+Xvg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GmuVV/eFllI6dAlcTl/3aRMBpgowq/7B7iJLvpi77aCiCfiAzBD09Nt+3rC5dFvXb
         /4K/P/6Xhdv62BggcuwREpPnxryThPiD1MvNAmAqdKDg0U5/UFmVUeAY2MBtiDTsgT
         OmTPUjLU1XiRR6F0FPa9NkS+QPClEcUGnuExOdYc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECC42611B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH v5 3/3] tty: serial: qcom_geni_serial: Remove sysfs file
To:     Stephen Boyd <swboyd@chromium.org>, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, msavaliy@codeaurora.org
References: <1573642161-14189-1-git-send-email-akashast@codeaurora.org>
 <5dcd90a4.1c69fb81.757a7.37e8@mx.google.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <04363987-0d4e-645f-87d0-79888913b8c3@codeaurora.org>
Date:   Fri, 15 Nov 2019 15:27:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5dcd90a4.1c69fb81.757a7.37e8@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 11/14/2019 11:06 PM, Stephen Boyd wrote:
> Please update the subject. This patch does more than remove the sysfs
> file. "Move loopback support to TIOCM_LOOP"?
Ok, I will update this in next version.
> Quoting Akash Asthana (2019-11-13 02:49:21)
>> Remove code from the driver that create and maintain loopback sysfs node.
>> Instead use the ioctl TIOCMSET with TIOCM_LOOP argument to set HW to
>> loopback mode.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>> Changes in V5:
>>   - As per Greg's and Stephen's comment on v4 patch, removed loopback sysfs
>>     file related code.
>>
>>   drivers/tty/serial/qcom_geni_serial.c | 30 ++++--------------------------
>>   1 file changed, 4 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 56dad67..52f5ea2 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -238,10 +214,14 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>>                                                          unsigned int mctrl)
>>   {
>>          u32 uart_manual_rfr = 0;
>> +       struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>>   
>>          if (uart_console(uport))
>>                  return;
>>   
>> +       if (mctrl & TIOCM_LOOP)
>> +               port->loopback = MAX_LOOPBACK_CFG;
> How does this work? The loopback is supposed to be the max all the time
> and not match some qup number or something?
port->loopback is unrelated to QUP number. However we have different 
modes to run loopback test, 1(rx-tx sorted), 2(cts-rts sorted),

3 or Max(rx-tx sorted and cts-rts sorted). In our internal testing we 
only use mode 3 hence we are initializing port->loopback variable

to 3 and eventually it will be written to HW register from set_termios 
call.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

