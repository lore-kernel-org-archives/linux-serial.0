Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66579C432BE
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 21:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEA560F9E
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 21:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhGZUdp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 16:33:45 -0400
Received: from foss.arm.com ([217.140.110.172]:59196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232922AbhGZUdn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 16:33:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A693631B;
        Mon, 26 Jul 2021 14:14:11 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 930203F70D;
        Mon, 26 Jul 2021 14:14:10 -0700 (PDT)
Subject: Re: [PATCH v5] arm pl011 serial: support multi-irq request
To:     Qian Cai <quic_qiancai@quicinc.com>, Bing Fan <hptsfb@gmail.com>,
        gregkh@linuxfoundation.org, Bing Fan <tombinfan@tencent.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
 <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
 <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
 <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
 <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
 <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e98962f3-9232-4abf-ec27-a7524a9e786d@arm.com>
Date:   Mon, 26 Jul 2021 22:14:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-07-26 21:56, Qian Cai wrote:
> 
> 
> On 7/26/2021 4:36 PM, Robin Murphy wrote:
>> The important point you're missing, but which the KASAN dump does hint at, is
>> that that is a machine with SBSA generic UARTs booting via ACPI - I know it
>> doesn't do DT at all because I have one too. What matters there is that pl011
>> binds as a platform driver, *not* an amba driver.
> 
> Thanks for pointing out, Robin. I just yet to see an ARM server booting from DT
> those days.

Unlikely in production datacentre/cloud environments, indeed, although 
some of the mid-range kit like LX2160 does start to blur the line of 
what might be considered "server", and that's one example which *does* 
have full-featured DT support (even if it also aspires to ACPI...)

What I thought was worth clarifying for the general audience is that the 
relevant aspects of "server" here should in fact still be possible to 
reproduce on something like a Raspberry Pi or a tiny QEMU VM, if one can 
figure out the ACPI runes :)

Thanks,
Robin.
