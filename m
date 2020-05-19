Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B0C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 12:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BECF20708
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ttUSYJYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgESMH1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 08:07:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:46062 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728286AbgESMH1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 08:07:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589890046; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=pKN8CH54HuTiS5l1bLL1hrtunZpKL8bKdZuG1nXfIhI=; b=ttUSYJYcxNT4iNqXsnz2EjIQvMDmbt8HFystdWEWQ881YUz0RwuCde3DU3RGLUUgVugW86kd
 frER3/1OmmiNFqVV38+Uav1240+dZoLfmaqQakN5+dzcP8yjm3NWxhm3GT27cJdmFGYfCoDx
 SQsH3qSActEDW9k6UBFD1XZdhtM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec3cbe8.7f3ee220eb20-smtp-out-n03;
 Tue, 19 May 2020 12:07:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 943AAC432C2; Tue, 19 May 2020 12:07:04 +0000 (UTC)
Received: from [192.168.0.4] (unknown [124.123.29.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msavaliy)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AA3EC44788;
        Tue, 19 May 2020 12:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AA3EC44788
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msavaliy@codeaurora.org
Subject: Re: [PATCH V3] serial: msm_geni_serial_console : Add Earlycon support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
References: <20200514133429.31245-1-msavaliy@codeaurora.org>
 <20200514140414.GC2581983@kroah.com>
From:   "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Message-ID: <32dd6d57-8856-d861-f2a2-27ab5cde8ad2@codeaurora.org>
Date:   Tue, 19 May 2020 17:36:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514140414.GC2581983@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 5/14/2020 7:34 PM, Greg KH wrote:
> On Thu, May 14, 2020 at 07:04:29PM +0530, Mukesh, Savaliya wrote:
>> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>>
>> This change enables earlyconsole support as static driver for geni
>> based UART. Kernel space UART console driver will be generic for
>> console and other usecases of UART.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>> ---
>> Removed mb() calls as *_relaxed() should take care.
> What about what happened from v1?
>
> ALways keep the full changelog here, otherwise we don't remember what
> happened.
Sure. Added V2,V3,V4 history of changes.
>
>> +static void se_io_set_mode_earlycon(void __iomem *base)
>> +{
>> +	unsigned int io_mode;
>> +
>> +	io_mode = readl_relaxed(base+SE_IRQ_EN);
> 	io_mode = readl_relaxed(base + SE_IRQ_EN);
>
> please.  Use ' ', there is no need to not do so.
Sure, Done
>
> thanks,
>
> greg k-h
