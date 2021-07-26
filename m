Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A328C4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6760F57
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 20:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhGZUQV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 16:16:21 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27441 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232597AbhGZUQU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 16:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1627333009; x=1658869009;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MBzzh+VDetRwP7MsYla8sy4iPCZFUAACM3mTYrjZQ70=;
  b=jpfFSa/4usKi7oJB3qFXXWXMXIEyI2WYUcQDkOEOldLarlh8UimBoTrP
   +R+uU8QDKqQBhiQuFYJwCtjWGf456qWm3BrE235l+zLFpNFEhpiznnWBh
   NUt24vTbT8R/8pctWnM02CwmukFQPL9EdhhnwMNRqnFQg1pNpJOAYfyfH
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jul 2021 13:56:49 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Jul 2021 13:56:49 -0700
Received: from [10.111.169.79] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 26 Jul
 2021 13:56:47 -0700
Subject: Re: [PATCH v5] arm pl011 serial: support multi-irq request
To:     Robin Murphy <robin.murphy@arm.com>, Bing Fan <hptsfb@gmail.com>,
        <gregkh@linuxfoundation.org>, Bing Fan <tombinfan@tencent.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
 <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
 <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
 <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
 <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
Date:   Mon, 26 Jul 2021 16:56:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03c.na.qualcomm.com (10.85.0.106) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/26/2021 4:36 PM, Robin Murphy wrote:
> The important point you're missing, but which the KASAN dump does hint at, is
> that that is a machine with SBSA generic UARTs booting via ACPI - I know it
> doesn't do DT at all because I have one too. What matters there is that pl011
> binds as a platform driver, *not* an amba driver.

Thanks for pointing out, Robin. I just yet to see an ARM server booting from DT
those days.
