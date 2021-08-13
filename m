Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07686C432BE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 15:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DDB6113E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 15:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbhHMPKr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:10:47 -0400
Received: from foss.arm.com ([217.140.110.172]:54548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241665AbhHMPKY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 11:10:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 898FE1042;
        Fri, 13 Aug 2021 08:09:57 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75D233F718;
        Fri, 13 Aug 2021 08:09:56 -0700 (PDT)
Subject: Re: [Internet]Re: [PATCH v5] arm pl011 serial: support multi-irq
 request
To:     gregkh <gregkh@linuxfoundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     =?UTF-8?B?dG9tYmluZmFuKOiMg+WFtSk=?= <tombinfan@tencent.com>,
        Bing Fan <hptsfb@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
 <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
 <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
 <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
 <e98962f3-9232-4abf-ec27-a7524a9e786d@arm.com>
 <bddf2712-72f4-2e20-da17-33b3de08f769@gmail.com>
 <0819592c-1baa-e98d-9118-5abde8b8c562@quicinc.com>
 <67cd6c830e33491e99ea4d2480f4a89d@tencent.com>
 <09918b566884413898f63b92ddd037a0@tencent.com>
 <0206c94d-c91b-b7da-8132-d06e23c9d964@quicinc.com>
 <YRaJVZOJMKtAM8Sl@kroah.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0f77be70-08fd-6fdd-227d-611c01c54788@arm.com>
Date:   Fri, 13 Aug 2021 16:09:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRaJVZOJMKtAM8Sl@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-08-13 16:01, gregkh wrote:
> On Fri, Aug 13, 2021 at 09:42:52AM -0400, Qian Cai wrote:
>>
>>
>> On 8/12/2021 11:32 PM, tombinfan(范兵) wrote:
>>> hello,
>>>
>>> I have sent the modified patch to the following mailboxes. THX
>>>
>>> gregkh@linuxfoundation.org
>>> linux-serial@vger.kernel.org
>>> linux-kernel@vger.kernel.org
>>
>> Thanks for the pointer. It is good to get some reviews from Arm
>> people in the first place, so we don't break Arm like this.
>>
>> Anyway, for anyone who might be watching, here is the new patch,
>>
>> https://lore.kernel.org/linux-serial/1628825490-18937-1-git-send-email-hptsfb@gmail.com/
>>
>> Unfortunately, I saw Greg mentioned that it was not based on
>> tty-next, so not something I can apply easily on linux-next here
>> as well.
> 
> That is because the code in tty-next (and linux-next), looks to already
> do exactly what you submitted, right?
> 
> So is this working now for everyone in linux-next?

AFAICS commit b0819465be8b in linux-next still results in 
amba_device-specific code being called from sbsa_uart_startup() and 
sbsa_uart_shutdown(), which is what blows up.

Robin.
