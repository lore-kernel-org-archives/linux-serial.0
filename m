Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47115C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2910B60EFE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 15:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbhHMP3E (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:29:04 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:7611 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241408AbhHMP3D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 11:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628868516; x=1660404516;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SqazGllWDPr0Qlv37WVWkdOkuMsFftvHhqgfFk44AX0=;
  b=Nymb5HbsotOrcrKKnIpckB042SiyQkUV+v79GKDDkrjARESNsu5PDYPH
   YbxS+KJRkF09zxZx5JTYkjut+LDhXprHWsBGnSJsVotNQN0OEY7wNQxeg
   5UJ4aUVGVKpnHYSjQy30bqM4964kIErQQmIu99D0sz+hpvHKGanf8Xn/k
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Aug 2021 08:28:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 08:28:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.15; Fri, 13 Aug 2021 08:28:34 -0700
Received: from [10.111.172.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.15; Fri, 13 Aug
 2021 08:28:33 -0700
Subject: Re: [Internet]Re: [PATCH v5] arm pl011 serial: support multi-irq
 request
To:     gregkh <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     =?UTF-8?B?dG9tYmluZmFuKOiMg+WFtSk=?= <tombinfan@tencent.com>,
        Bing Fan <hptsfb@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
 <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
 <e98962f3-9232-4abf-ec27-a7524a9e786d@arm.com>
 <bddf2712-72f4-2e20-da17-33b3de08f769@gmail.com>
 <0819592c-1baa-e98d-9118-5abde8b8c562@quicinc.com>
 <67cd6c830e33491e99ea4d2480f4a89d@tencent.com>
 <09918b566884413898f63b92ddd037a0@tencent.com>
 <0206c94d-c91b-b7da-8132-d06e23c9d964@quicinc.com>
 <YRaJVZOJMKtAM8Sl@kroah.com> <0f77be70-08fd-6fdd-227d-611c01c54788@arm.com>
 <YRaMQL+YOaky+x9Q@kroah.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <4cc762c8-ba6f-12ba-35f0-3367be8c1fb5@quicinc.com>
Date:   Fri, 13 Aug 2021 11:28:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRaMQL+YOaky+x9Q@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03g.na.qualcomm.com (10.85.0.49) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 8/13/2021 11:14 AM, gregkh wrote:
>> AFAICS commit b0819465be8b in linux-next still results in
>> amba_device-specific code being called from sbsa_uart_startup() and
>> sbsa_uart_shutdown(), which is what blows up.
> 
> Ick,  ok, can someone send me a revert with this information in it
> please?

I guess Bin won't be around to response in his timezone on Friday, so
I'll send a revert shortly.
