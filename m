Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD1FC4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B46060F6B
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhGZQBL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 12:01:11 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:57324 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239919AbhGZP66 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 11:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1627317566; x=1658853566;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=88VXrV0v8tlO1oZ2PaNtmPhAb3w578s7ohtI0w7+fs8=;
  b=J7kNuFpz9lj4onrUmYjzQrOqNVS771YNQ/qodnzaOZjazgZxjZrThI0c
   A3YLXfNPA+Rq95kaD4xG+e83Mq9IbY1bKdmvoWcv122NsrnUPglruQZP6
   0v/mtnPxC8OINdjmgMiYHrqSXIBSEL07HIFAsNB4ceb9BtJ/P2EO4Z/Si
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jul 2021 09:39:26 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Jul 2021 09:39:26 -0700
Received: from [10.111.169.79] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 26 Jul
 2021 09:39:25 -0700
Subject: Re: [PATCH v5] arm pl011 serial: support multi-irq request
To:     Bing Fan <hptsfb@gmail.com>, <gregkh@linuxfoundation.org>,
        Bing Fan <tombinfan@tencent.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
 <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
 <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
Date:   Mon, 26 Jul 2021 12:39:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03c.na.qualcomm.com (10.85.0.106) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/26/2021 3:17 AM, Bing Fan wrote:
> Hello,
> 
> I tried to reproduce, but unfortunately, it didn't, and the dmesg log as
> attachment.
> 
> I had enabled CONFIG_KASAN and CONFIG_SLUB_DEBUG_ON configs.
> 
> Can you describe the flow of your operation?
> 
Nothing fancy. Just boot a baremetal ARM server on linux-next could trigger it.
The .config is here.

https://www.lsbug.org/tmp/arm64.conf
