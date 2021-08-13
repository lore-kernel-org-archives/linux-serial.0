Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54104C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AD56109D
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 13:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbhHMNoy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 09:44:54 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:45481 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240654AbhHMNn3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 09:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628862182; x=1660398182;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bOvhMYYM/9/bZhaOKUzBARsH5nstcvz2xXOwb+iD0Ss=;
  b=w63ZOozMgs5tNv/uD9buPxLz8kAF9XCb/gQ/q7/Los3jllOwvape20pO
   bbOH+AQSF9790AVxZVZi8odSunfR5/uAdt/a9dDJ4MaWhAkAibW36mUYW
   GV7X8/H/q0+dhpTe9HYA15/p9vS83ZwFDgCf609q3yDF7W1Uw/IFq7uMY
   0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Aug 2021 06:42:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 06:42:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.15; Fri, 13 Aug 2021 06:42:55 -0700
Received: from [10.111.172.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.15; Fri, 13 Aug
 2021 06:42:53 -0700
Subject: Re: [Internet]Re: [PATCH v5] arm pl011 serial: support multi-irq
 request
To:     =?UTF-8?B?dG9tYmluZmFuKOiMg+WFtSk=?= <tombinfan@tencent.com>,
        Bing Fan <hptsfb@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        gregkh <gregkh@linuxfoundation.org>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
 <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
 <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
 <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
 <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
 <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
 <e98962f3-9232-4abf-ec27-a7524a9e786d@arm.com>
 <bddf2712-72f4-2e20-da17-33b3de08f769@gmail.com>
 <0819592c-1baa-e98d-9118-5abde8b8c562@quicinc.com>
 <67cd6c830e33491e99ea4d2480f4a89d@tencent.com>
 <09918b566884413898f63b92ddd037a0@tencent.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <0206c94d-c91b-b7da-8132-d06e23c9d964@quicinc.com>
Date:   Fri, 13 Aug 2021 09:42:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <09918b566884413898f63b92ddd037a0@tencent.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03g.na.qualcomm.com (10.85.0.49) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 8/12/2021 11:32 PM, tombinfan(范兵) wrote:
> hello,
> 
> I have sent the modified patch to the following mailboxes. THX
> 
> gregkh@linuxfoundation.org
> linux-serial@vger.kernel.org
> linux-kernel@vger.kernel.org

Thanks for the pointer. It is good to get some reviews from Arm
people in the first place, so we don't break Arm like this.

Anyway, for anyone who might be watching, here is the new patch,

https://lore.kernel.org/linux-serial/1628825490-18937-1-git-send-email-hptsfb@gmail.com/

Unfortunately, I saw Greg mentioned that it was not based on
tty-next, so not something I can apply easily on linux-next here
as well.
