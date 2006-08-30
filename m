From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 30 Aug 2006 20:50:03 +0400
Message-ID: <44F5C1BB.7010205@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <200608300100.32836.thomas.koeller@baslerweb.com> <20060830121216.GA25699@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3538 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1751155AbWH3QtB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Aug 2006 12:49:01 -0400
In-Reply-To: <20060830121216.GA25699@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Thomas K?ller <thomas@koeller.dyndns.org>

Hello.

Russell King wrote:

>>I would like to return to the port type vs. iotype  stuff once again.
>>From what you wrote I seem to understand that the iotype is not just
>>a method of accessing device registers, but also the primary means of
>>discrimination between different h/w implementations, and hence every
>>code to support a nonstandard device must define an iotype of its own,
>>even though one of the existing iotypes would work just fine?

> iotype is all about the access method used to access the registers of
> the device, be it by byte or word, and it also takes account of any
> variance in the addressing of the registers.

> It does not refer to features or bugs in any particular implementation.

    Well, the introduction of the UPIO_TSI case seems to contradict this --
it's exactly about the bugs in the particular UART implementation (otherwise
well described by UPIO_MEM). Its only function was to mask 2 hardware issues.
And the UUE bit workaround seems like an abuse to me. The driver could just 
skip the UUE test altogether based on iotype == UPIO_TSI (or at least not to 
ignore writes with UUE set completely like it does but just mask off UUE bit).
    With no provision to pass the implicit UART type for platform devices (and 
skip the autoconfiguation), the introduction of UPIO_TSI seems again the 
necessary evil. Otherwise, we could have this handled with a distinct TSI UART 
type...

WBR, Sergei

