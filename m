From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
 er
Date: Wed, 24 Jan 2007 18:25:47 +0300
Message-ID: <45B77A7B.2040504@ru.mvista.com>
References: <5C1FD43E5F1B824E83985A74F396286E03AD7632@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca> <45B51D5C.207@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55518 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750975AbXAXPZv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Jan 2007 10:25:51 -0500
In-Reply-To: <45B51D5C.207@ru.mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Hello, I wrote:

>>>> Here is a serial driver patch for the PMC-Sierra MSP71xx device.

>>>> There are three different fixes:
>>>> 1. Fix for THRE errata
>>>> 2. Fix for Busy Detect on LCR write
>>>> 3. Workaround for interrupt/data concurrency issue

>>>> The first fix is handled cleanly using a UART_BUG_* flag.

>>>    Hm, I wouldn't call it clean...

>> Relative to the other two. Any recommended improvements on this one?

>    I already told: runtime check.

    BTW, I've just came accross 2 patches in the -mm tree related to the 
transmitter bug:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc4/2.6.20-rc4-mm1/broken-out/8250-make-probing-for-txen-bug-a-config-option.patch
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc4/2.6.20-rc4-mm1/broken-out/8250-uart-backup-timer.patch

>>>> Thanks,
>>>> Marc

WBR, Sergei
