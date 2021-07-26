Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1512C4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D281860F6E
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhGZT4A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:56:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhGZT4A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 15:56:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94EBF31B;
        Mon, 26 Jul 2021 13:36:28 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81FEF3F70D;
        Mon, 26 Jul 2021 13:36:27 -0700 (PDT)
Subject: Re: [PATCH v5] arm pl011 serial: support multi-irq request
To:     Qian Cai <quic_qiancai@quicinc.com>, Bing Fan <hptsfb@gmail.com>,
        gregkh@linuxfoundation.org, Bing Fan <tombinfan@tencent.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
 <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
 <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
 <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
Date:   Mon, 26 Jul 2021 21:36:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-07-26 17:39, Qian Cai wrote:
> 
> 
> On 7/26/2021 3:17 AM, Bing Fan wrote:
>> Hello,
>>
>> I tried to reproduce, but unfortunately, it didn't, and the dmesg log as
>> attachment.
>>
>> I had enabled CONFIG_KASAN and CONFIG_SLUB_DEBUG_ON configs.
>>
>> Can you describe the flow of your operation?
>>
> Nothing fancy. Just boot a baremetal ARM server on linux-next could trigger it.
> The .config is here.

The important point you're missing, but which the KASAN dump does hint 
at, is that that is a machine with SBSA generic UARTs booting via ACPI - 
I know it doesn't do DT at all because I have one too. What matters 
there is that pl011 binds as a platform driver, *not* an amba driver.

Robin.
