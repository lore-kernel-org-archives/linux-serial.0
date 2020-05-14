Return-Path: <SRS0=CP5M=64=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90ADC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76D82065D
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xBeG4wZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgENNdd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 May 2020 09:33:33 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31338 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726056AbgENNdc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 May 2020 09:33:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589463212; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=TZPgL+XkybaeeYUYsbnJMPveHMNejUHVe64o0zrFwys=; b=xBeG4wZxUSGeSJ4Fqc0kSsGI8sOlTi2Z4CGi6ZLuXjEetnCrhBN9dm2cJda1ehJQR4g4zhAf
 e/2Pa38spTX2FH9L3+4VCePsxyXbAxkzPIothY3UIU6nUEr0PMJRvghOk2uzU9ufi1FJpNCq
 kGOUz7IusChxyPguTpcUZ86Or04=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd48a7.7f82d40b3d18-smtp-out-n05;
 Thu, 14 May 2020 13:33:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AE280C43636; Thu, 14 May 2020 13:33:27 +0000 (UTC)
Received: from [192.168.0.4] (unknown [124.123.29.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msavaliy)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88078C432C2;
        Thu, 14 May 2020 13:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88078C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msavaliy@codeaurora.org
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
 <20200506120532.GB3047211@kroah.com>
From:   "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Message-ID: <572765da-6dae-3056-3fc2-188b92291777@codeaurora.org>
Date:   Thu, 14 May 2020 19:03:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200506120532.GB3047211@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 5/6/2020 5:35 PM, Greg KH wrote:
> On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
>> +		/*
>> +		 * If the WM bit never set, then the Tx state machine is not
>> +		 * in a valid state, so break, cancel/abort any existing
>> +		 * command. Unfortunately the current data being written is
>> +		 * lost.
>> +		 */
>> +		while (!msm_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>> +						M_TX_FIFO_WATERMARK_EN, true))
>> +			break;
> Am I reading this correctly in that if the bit is set properly, you will
> just loop for forever?
>
> That feels wrong, are you sure this is correct?

It seems correct to me. The API returns true if function sees the BIT is 
set else returns false.

Mostly it's true and returns true, hence it shouldn't loop.

>
>> +		chars_to_write = min((unsigned int)(count - i),
>> +							avail_fifo_bytes);
>> +		if ((chars_to_write << 1) > avail_fifo_bytes)
>> +			chars_to_write = (avail_fifo_bytes >> 1);
>> +		uart_console_write(uport, (s + i), chars_to_write,
>> +					msm_geni_serial_wr_char);
>> +		writel_relaxed(M_TX_FIFO_WATERMARK_EN,
>> +			uport->membase+SE_GENI_M_IRQ_CLEAR);
>> +		/* Ensure this goes through before polling for WM IRQ again.*/
>> +		mb();
> Again, writel() on its own should be fine here, and elsewhere.
Removed mb() from whole file as _relaxed takes care of it.
>
> thanks,
>
> greg k-h
