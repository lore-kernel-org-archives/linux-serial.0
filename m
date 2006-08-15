From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 16 Aug 2006 01:35:57 +0400
Message-ID: <44E23E3D.3030403@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <44DCDCED.7000404@ru.mvista.com> <200608152315.55104.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:41314 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1750726AbWHOVer
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Aug 2006 17:34:47 -0400
In-Reply-To: <200608152315.55104.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, =?ISO-8859-1?Q?Thomas_K=F6ller?= <thomas@koeller.dyndns.org>

Hello.

Thomas Koeller wrote:
> On Friday 11 August 2006 21:39, Sergei Shtylyov wrote:
> 
>>    I highly doubt this is how it should be done. Look at the Alchemy code
>>as an example how the "partly-compatible" UART support should be written.
>>Alchemy also has 32-bit MMIO and some registers mapped differently.

>>WBR, Sergei

> Seems I cannot find the code you are referring to - could you point me at
> the particular file(s) to look at?

    8250.c and 8250-au1x00.c in drivers/serial/...

> Thanks,
> Thomas

WBR, Sergei
