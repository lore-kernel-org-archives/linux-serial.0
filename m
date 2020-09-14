Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ACBC433E2
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 10:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3312420735
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 10:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="P3wlB8+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgINKAU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 06:00:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19664 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgINKAS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 06:00:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600077617; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RMWWi08qE+zVDjsvs5PNkxLphO7CpEmaJmcY8F/dYqE=; b=P3wlB8+4aiXkFMOpbPqiTZwR/pNDO9LdHhDLtZO7N3HZBPQIs3w88yAapa/cTromRlTHO4NO
 bEKGmoDzIq+xSmzOZMKDC1pTuRenVlQidPA7YlywNHchq9MrhFkAf2iQM2imp0ICyjWEmp4C
 /x/N5XbRRLqBLYoYWQrfnsh4KWA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f5f3f167f21d51b30bc8939 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 09:59:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8173C433FF; Mon, 14 Sep 2020 09:59:49 +0000 (UTC)
Received: from [192.168.43.98] (unknown [47.8.187.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62A9DC433CA;
        Mon, 14 Sep 2020 09:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62A9DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: 115.2 is a better console
 default than 9600
To:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, robdclark@chromium.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        jwerner@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20200911080054.1.I4c00b921c2f17b6988688046fa7be0f729f8d591@changeid>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <981cfc91-035e-57cb-5972-e2a749adae98@codeaurora.org>
Date:   Mon, 14 Sep 2020 15:29:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911080054.1.I4c00b921c2f17b6988688046fa7be0f729f8d591@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 9/11/2020 8:30 PM, Douglas Anderson wrote:
> Commit c5cbc78acf69 ("tty: serial: qcom_geni_serial: Initialize baud
> in qcom_geni_console_setup") fixed a bug by initting a variable that
> was used in some cases without initialization.  However, the "default"
> baud rate picked by that CL was probably not the best choice.  The
> chances that anyone out there is trying to run a system with kernel
> messages piped out over a 9600 baud serial port is just about nil.
> Console messages are printed in a blocking manner.  At 9600 baud we
> print about 1 character per millisecond which means that printing a
> 40-byte message to the console will take ~40 ms.  While it would
> probably work, it's going to make boot _very_ slow and probably cause
> the occasional timeout here and there in drivers (heck, even at 115200
> console delays can wreck havoc).
>
> This has already bit at least two people that I'm aware of that tried
> to enable serial console by just adding "console=ttyMSM0" (instead of
> "console=ttyMSM0,115200n8") to the command line, so it seems like it'd
> be nice to fix.
>
> Let's switch the default to 115200.
Reviewed-by: Akash Asthana <akashast@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

