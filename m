From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 30 Aug 2006 15:59:57 +0400
Message-ID: <44F57DBD.9020700@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608222227.20181.thomas.koeller@baslerweb.com> <44F459DD.8060902@ru.mvista.com> <200608300105.26921.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45772 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1750844AbWH3L64 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Aug 2006 07:58:56 -0400
In-Reply-To: <200608300105.26921.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, =?ISO-8859-1?Q?Thomas_?= =?ISO-8859-1?Q?K=F6ller?= <thomas@koeller.dyndns.org>

Hello.

Thomas Koeller wrote:

>>>Also, it seems to me that the whole register-mapping stuff conflicts with
>>>autodetection, because autoconfig() uses serial_inp() and serial_outp()
>>>before the port types, and hence the mapping requirements, are known.

>>    Port types have nothing to do with this. Or at least they hadn't until
>>your recent patch. :-)
>>    iotype was used to identify the addressing scheme, and it's alsready
>>known beforehand.

> How so? If I do not yet know which hardware I am dealing with, how can I know
> the iotype?

    The iotype is passed to driver when registering the platform device or 
calling early_serial_setup().
There's absolutely no way for 8250.c to figure it out yourself. Please, review 
the driver's code more carefully. It was not at all that complex task to copy 
from the existing Alchemy code...

> Thomas 

WBR, Sergei
