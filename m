Return-Path: <SRS0=CP5M=64=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B2EC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 13:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9552065D
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 13:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="by81Rw9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgENNeC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 May 2020 09:34:02 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11712 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726056AbgENNeC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 May 2020 09:34:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589463241; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=8bAbOdw0AFa2LIhAa+y8WqrLFo/3Vw78j+dmVb/3pM0=; b=by81Rw9HL5gkytlvC9uOfP9k05SmPqBf0No1ixMuQqNM2F57dAtTLmdDyH/pnXKpxIkW5b4k
 V/+qV+Kl3oXSXzNEpHb8HGYv7l05Iol/1nK9iMGY9TLcwl0s1CkNdK5RIsJkn+VhwSiliONw
 860sh4reT7aMCeUclY8+fGhq1t0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd48bc.7f386c51f5e0-smtp-out-n01;
 Thu, 14 May 2020 13:33:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9A7AC432C2; Thu, 14 May 2020 13:33:48 +0000 (UTC)
Received: from [192.168.0.4] (unknown [124.123.29.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msavaliy)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7473DC433F2;
        Thu, 14 May 2020 13:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7473DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msavaliy@codeaurora.org
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
To:     Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
 <20200506120237.GA3047211@kroah.com> <20200506124845.GG8043@willie-the-truck>
 <20200506125904.GA3159967@kroah.com>
From:   "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Message-ID: <aa90a22a-03e5-d8d1-cb73-2054fc3845d4@codeaurora.org>
Date:   Thu, 14 May 2020 19:03:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200506125904.GA3159967@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 5/6/2020 6:29 PM, Greg KH wrote:
> On Wed, May 06, 2020 at 01:48:45PM +0100, Will Deacon wrote:
>> On Wed, May 06, 2020 at 02:02:37PM +0200, Greg KH wrote:
>>> On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
>>>> +static void msm_geni_serial_wr_char(struct uart_port *uport, int ch)
>>>> +{
>>>> +	writel_relaxed(ch, uport->membase+SE_GENI_TX_FIFOn);
>>>> +	/*
>>>> +	 * Ensure FIFO write clear goes through before
>>>> +	 * next iteration.
>>>> +	 */
>>>> +	mb();
>>> Can't you just write the above two lines as:
>>> 	writel(ch, uport->membase+SE_GENI_TX_FIFOn);
>>> ?
>>>
>>> Why put a mb() after a _relaxed() call?
>> writel() usually puts the barrier /before/ the I/O write, since it's
>> normally used to signal the readiness of a DMA buffer, e.g.:
>>
>> 	ptr = dma_map(...);
>> 	ptr->data = tx_data;
>> 	writel(dev->ctrl_reg, SEND_DATA); // Device must see tx_data
>>
>> but this driver looks like it only cares about PIO rather than DMA, in which
>> case there's no need for mb() or writel(); writel_relaxed() should do the
>> trick because we just need to ensure ordering of the writes hitting the
>> device. From memory-barriers.txt:
>>
>>    ... they [relaxed accesses] are still guaranteed to be ordered with
>>    respect to other accesses from the same CPU thread to the same
>>    peripheral when operating on __iomem pointers mapped with the default
>>    I/O attributes.
> Ok, that makes more sense, many thanks.
>
> So, as writes are ordered here, Savaliya, I think all of the calls to
> mb() can be dropped from this driver, right?
yes, makes sense. I have removed it, kept *_relaxed() calls and uploaded 
the patch.
>
> thanks,
>
> greg k-h
