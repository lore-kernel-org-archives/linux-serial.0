Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1DAC432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4C120674
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 06:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iCGbnvxg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="N3+KVRU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVGqd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:46:33 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:52690
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbfKVGqd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 01:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574405191;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=JrcQb26bQD8aXnLDjGjpR7I6syd5ZdTxSg0vhd40Grw=;
        b=iCGbnvxgS+yRFLSQngZH/IBzDgMz+UwXe7YZkbfMmyZ2UGBzg7fb0iLJsYFYpw0N
        CrZwhZfEmLp/7WQXiaPmUHc+ReEnwiw/k+J1RetY7ts2LXaFgnG35+lXANlo1ae+4d4
        VG4o87Do1Dtc4zNpCzK8uFUAEkSjSiKqCkcDN7Y8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574405191;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=JrcQb26bQD8aXnLDjGjpR7I6syd5ZdTxSg0vhd40Grw=;
        b=N3+KVRU71ankh4zcvj9bUZLxP1QGVVXuPVr+CkkNxfnan71holpiYwyhwL3XhfvD
        BwDuq/r2+9oSKBF4XsyjzVJx6RRY0Rq5co46rTK2R1OuVhHcP4EIML8HLm5Mfht9Gyt
        /hwhTjN7yBw8tBdTeToJN1pE0YHOtXtGEuAvBimQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7944C93000
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH v5 2/3] tty: serial: qcom_geni_serial: Wakeup over UART RX
To:     Stephen Boyd <swboyd@chromium.org>, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, msavaliy@codeaurora.org
References: <1573642136-30488-1-git-send-email-akashast@codeaurora.org>
 <5dcd919d.1c69fb81.1c304.2dc5@mx.google.com>
 <55a02d0f-2dec-2ba7-82e6-f21a8c86792a@codeaurora.org>
 <5dceff73.1c69fb81.e286f.aa4e@mx.google.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <0101016e91dcb840-ea129918-4ba7-4382-8a2c-2ae5dea6b3e6-000000@us-west-2.amazonses.com>
Date:   Fri, 22 Nov 2019 06:46:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5dceff73.1c69fb81.e286f.aa4e@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-SES-Outgoing: 2019.11.22-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 11/16/2019 1:11 AM, Stephen Boyd wrote:
> Quoting Akash Asthana (2019-11-15 02:00:44)
>> On 11/14/2019 11:10 PM, Stephen Boyd wrote:
>>> Quoting Akash Asthana (2019-11-13 02:48:56)
>>>> Add system wakeup capability over UART RX line for wakeup capable UART.
>>>> When system is suspended, RX line act as an interrupt to wakeup system
>>>> for any communication requests from peer.
>>> How does the RX line get remuxed as a GPIO interrupt here? Is that
>>> through some pinctrl magic in DT or just via enabling/disabling the
>>> interrupt?
>> Yes, For wakeup capable UART node, we have registered UART RX line with
>> TLMM interrupt controller in DT file . Example: if GPIO48 is UART RX line
>>
>> interrupts-extended =  <&intc GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>,  <&tlmm
>> 48 IRQ_TYPE_EDGE_FALLING>;
> Right. So is gpio48 muxed as 'uart' function forever and the interrupt
> logic in tlmm is connected to that pad regardless of the function
> selected? I thought that gpios through TLMM had to be muxed as function
> 0, i.e. gpio function, so that interrupts worked. But maybe that's wrong
> and it can work without that.

Yes, gpio48 is muxed as "uart' function function forever. There is no 
need to mux gpio48 to

gpio function, interrupts can work without that.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

