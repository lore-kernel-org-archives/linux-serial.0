From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH] pch_uart: Change default UART clock setting 192MHz
Date: Tue, 21 Feb 2012 16:20:52 -0800
Message-ID: <4F4434E4.7040703@linux.intel.com>
References: <1329800140-4279-1-git-send-email-tomoya.rohm@gmail.com> <4F43C15D.6080401@linux.intel.com> <CANKRQnjMAVBf2wn01eFD1CKTgtWyhzk2_epz-YprZp3eS1wmMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50674 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab2BVAVh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Feb 2012 19:21:37 -0500
In-Reply-To: <CANKRQnjMAVBf2wn01eFD1CKTgtWyhzk2_epz-YprZp3eS1wmMg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, feng.tang@intel.com

On 02/21/2012 03:43 PM, Tomoya MORINAGA wrote:
> 2012年2月22日1:07 Darren Hart <dvhart@linux.intel.com>:
>>  When does the phub driver update the clock registers?
> 
> I've already posted pch_phub patch for 192MHz setting.
> You can see the patch form below.

Yes, I applied the patch. The problem seems to be this:

DVHART: parse_options (8250_early.c)
DVHART: pch_console_setup                                                           
DVHART: pch_console_setup                                                           
DVHART: pch_phub_probe: set CLKCFG UART to 192MHz      

As you can see, the pch_phub_probe happens much too late.

I can get it to work with a boot command line like this:
earlycon=uart8250,io,0x2050,115200n8 console=ttyPCH1,115200n8

And hacking all the BASE_BAUD references to be 48000000
(my current hardware sets the clock to 48MHz in firmware).
This gets things working until pch_phub gets around to setting
the CLKCFG register for the UART clock.

I'd prefer to not have to use the earlycon parameter/code,
but we need a way for the pch_uart to understand the difference
between early boot and post-phub setup. Can we read the CLKCFG
register in pch_console_setup to dynamically configure the
port->uartclk? (not sure that's even the right place to do it).

--
Darren

>>> Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
>>> ---
>>> Related patch is
>>> http://marc.info/?l=linux-kernel&m=132979974907774&w=2
> 
> ---
> ROHM Co., Ltd.
> tomoya

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
