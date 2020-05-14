Return-Path: <SRS0=CP5M=64=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99103C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1A520728
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EQu0JqYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgENNdH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 May 2020 09:33:07 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31338 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgENNdG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 May 2020 09:33:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589463186; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=aFjVryK896eVzAcWVmd4eM1/wbF53lfmtGTdogx1Uo4=; b=EQu0JqYpXTQE4kZ/kqkpduovkpxiKpfkCYncst5KWVFOMlj/++njMTP6XbDyA2nMc6vJdFvq
 HW+Ko5eTjaZ0uirnX7X8WEc4G12X8yDcurjvW0RUd8LJYGkLXYPoMm/UFNISbHE5sf9PjpwJ
 syIVadjMQHwQImmpG0eMQnSnfVw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd4891.7f708570db20-smtp-out-n01;
 Thu, 14 May 2020 13:33:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15BF5C43636; Thu, 14 May 2020 13:33:05 +0000 (UTC)
Received: from [192.168.0.4] (unknown [124.123.29.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msavaliy)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E1B9C433D2;
        Thu, 14 May 2020 13:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E1B9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msavaliy@codeaurora.org
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
To:     Greg KH <gregkh@linuxfoundation.org>, will@kernel.org
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
 <20200506120237.GA3047211@kroah.com>
From:   "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Message-ID: <a66f2bdc-57e6-e155-26ce-5643bbc045ad@codeaurora.org>
Date:   Thu, 14 May 2020 19:02:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200506120237.GA3047211@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 5/6/2020 5:32 PM, Greg KH wrote:
> On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
>> +static void msm_geni_serial_wr_char(struct uart_port *uport, int ch)
>> +{
>> +	writel_relaxed(ch, uport->membase+SE_GENI_TX_FIFOn);
>> +	/*
>> +	 * Ensure FIFO write clear goes through before
>> +	 * next iteration.
>> +	 */
>> +	mb();
> Can't you just write the above two lines as:
> 	writel(ch, uport->membase+SE_GENI_TX_FIFOn);
> ?
>
> Why put a mb() after a _relaxed() call?
>
> Will, I know I asked you about this on irc a while ago, is the above
> really correct?
>
> This happens other places in the driver.
Removed mb() calls due to _relaxed() APIs taking care of the same.
>
> Also, Savaliya, please use checkpatch on your patch, you need some
> whitespace fixes in this code before I could accept it at the very
> least.

I ran the script now also on same patch, didn't any warning/error. Do 
you see the error ? Below is the output:

./scripts/checkpatch.pl 
0001-serial-msm_geni_serial_console-Add-Earlycon-support.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#58:
new file mode 100644

total: 0 errors, 1 warnings, 511 lines checked

>
> thanks,
>
> greg k-h
