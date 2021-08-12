Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE40C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD396109D
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 14:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhHLOcP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 10:32:15 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:18937 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbhHLOcP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 10:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628778710; x=1660314710;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hbf9rLHrArmbSu+dloBsDKqhL1YiXbeSamoElFGATd4=;
  b=y4kcADqoKjs84cOL8j7hgm62GboSFmKvA87MtAoIvH1KHmltkI62qxzM
   ZDFiVBTCoBvzhkVD3vJzBReojFEN2pJsTdpnJAuvoWay0MVyShxsXuqco
   2bpTMzxhB7ejB4Ki8lLx1SY0IdfCZ8wYLE34CDDtbb81uH3TBEGfjA338
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 12 Aug 2021 07:31:49 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 07:31:49 -0700
Received: from nasanex01c.na.qualcomm.com (10.47.97.222) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.15; Thu, 12 Aug 2021 07:31:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.15; Thu, 12 Aug 2021 07:31:48 -0700
Received: from [10.111.167.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.15; Thu, 12 Aug
 2021 07:31:47 -0700
Subject: Re: [PATCH v5] arm pl011 serial: support multi-irq request
To:     Bing Fan <hptsfb@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
        <gregkh@linuxfoundation.org>, Bing Fan <tombinfan@tencent.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
 <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
 <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
 <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
 <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
 <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
 <e98962f3-9232-4abf-ec27-a7524a9e786d@arm.com>
 <bddf2712-72f4-2e20-da17-33b3de08f769@gmail.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <0819592c-1baa-e98d-9118-5abde8b8c562@quicinc.com>
Date:   Thu, 12 Aug 2021 10:31:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <bddf2712-72f4-2e20-da17-33b3de08f769@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03f.na.qualcomm.com (10.85.0.47) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/26/2021 10:57 PM, Bing Fan wrote:
> hello,
> 
> Thanks very much for analysis. And i have get the cause of the problem.
> 
> I will add pl011_allocate_multi_irqs/pl011_release_multi_irqs functions for amba drivers,
> 
> and call them in pl011_startup/pl011_shutdown respectively.
> 
> 
> Reserved pl011_allocate_irq/pl011_release_irq functions for platform drivers.
> 
> Please help to confirm, is this ok?

Bing, are you still working on this? It is getting annoying that this commit will also
cause the whole serial console useless and the system unable to login. I am happy to
help if needed.

