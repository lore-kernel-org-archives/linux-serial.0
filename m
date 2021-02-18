Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A464DC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 12:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBDB64DEC
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 12:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBRMQd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:16:33 -0500
Received: from fieber.vanmierlo.com ([84.243.197.177]:40423 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230283AbhBRL60 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Feb 2021 06:58:26 -0500
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.3.1) with ESMTPA;
        Thu, 18 Feb 2021 11:49:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 18 Feb 2021 11:49:42 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     =?UTF-8?Q?M=C3=A5ns_Rullg=C3=A5rd?= <mans@mansr.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: add option to disable registration of
 legacy ISA ports
In-Reply-To: <yw1xwnvtcki0.fsf@mansr.com>
References: <20210128172244.22859-1-mans@mansr.com>
 <YBam2m2VMowH5Yth@kroah.com> <yw1xwnvtcki0.fsf@mansr.com>
Message-ID: <e0ac606ecc9f116f41fe4fccbf67a6bb@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-01-31 14:18, Måns Rullgård wrote:
>> What userspace visable change will be caused by this?
> 
> There won't be /dev/ttyS devices for ports that don't exist.

Oh yes, please!

That would mean I can create ttyS2 and upward while keeping ttyPS0 and 
ttyPS1 (which invaded the serial<N> alias namespace) at the lower 
numbers.

>> Will ports get renumbered?
> 
> Not if they had predictable numbers to begin with.

It is hard to make predictable numbers with the backward operating 
serial<N> aliases in the device tree. It makes relations in the wrong 
direction.

If a system has two ttyPS<N> uarts (xilinx_uartps) and needs them at 
ttyPS0 and ttyPS1 (or at least <=ttyPS9, due to another bug in 
start_getty) and 10 ttyS<N> (8250) you can configure the kernel for 10 
8250 devices and give 8 of them the predictable ttyS2 to ttyS9. The last 
two will get the remaining ttyS0 and ttyS1. You cannot assign them their 
number, because the serial0 and serial1 alias are required for the 
ttyPS0 and ttyPS1.

However with this option it would be possible to configure for 12 8250 
devices and not use nor see ttyS0 and ttyS1.

The best option would of course be to not even instantiate kernel 
drivers for non-existing devices.

Maarten

