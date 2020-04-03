Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D27C43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE4B2073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 15:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDCPtP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:49:15 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:48468 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728140AbgDCPtO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 11:49:14 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.11 beta 1) with ESMTPA;
        Fri, 3 Apr 2020 17:48:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Apr 2020 17:48:42 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, johan@kernel.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: uartps: Revert dynamic port allocation
In-Reply-To: <2983dbe2-16e6-4b7b-73a6-49d8c3d70510@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
 <20200403093216.GA3746303@kroah.com>
 <d9598635-a8ef-eff2-22e8-4fa37f8390b3@xilinx.com>
 <20200403094427.GA3754220@kroah.com>
 <2983dbe2-16e6-4b7b-73a6-49d8c3d70510@xilinx.com>
Message-ID: <211f564d5594994fc677d3fea4222997@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-04-03 11:51, Michal Simek wrote:
> 
> Thanks. I am definitely interested to hear more how this could be done
> differently because that hardcoded limits are painful.
> On FPGAs you can have a lot of uarts for whatever reason and users are
> using DT aliases to have consistent naming.
> Specifically on Xilinx devices we are using uartps which is ttyPS,
> uartlite which is ttyUL, ns16500 which is ttyS and also pl011 which is
> ttyAMA.
> Only ttyAMA or ttyPS on one chip are possible.
> 
> And right now you can't have serial0 alias pointed ttyPS0 and another
> serial0 pointed to ttyUL0 or ttyS0. That's why others are shifted and 
> we
> can reach that hardcoded NR_UART limit easily.
> And this was the reason why I have done these patches in past to remove
> any limit from these drivers and if user asks for serial100 alias you
> simply get ttyPS100 node.

I would argue that the trouble originates from every uart driver using
its own naming scheme and thereby creating separate namespaces. If all
uarts would register as /dev/ttySnn then the serialN alias method would
work. These non-overlapping namespaces is something the linux kernel
driver community has allowed to happen.

If the namespaces are not abandoned and disallowed, then the serialN
alias method must no longer be used for any driver that does not create
/dev/ttySnn devices. Every namespace will require its own alias base.
Or forget about deriving the number from an alias and set the number in
a property in the device tree node itself. The latter has my preference.

Maarten

