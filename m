From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 0/4] pch_uart: Cleanups, board quirks, and user uartclk
 parameter
Date: Tue, 21 Feb 2012 22:39:38 -0800
Message-ID: <4F448DAA.6000207@linux.intel.com>
References: <cover.1329875301.git.dvhart@linux.intel.com> <CANKRQni9E6NO39MFSak6MjQ0DtmQeviGo966Ex9ZUvai56wCjg@mail.gmail.com> <4F4462B8.6030607@linux.intel.com> <CANKRQnhckD5Dt+0PbD3h=Ggz+U8RoDs0qUn5CgVnsYcH08tRkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5140 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab2BVGkO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 01:40:14 -0500
In-Reply-To: <CANKRQnhckD5Dt+0PbD3h=Ggz+U8RoDs0qUn5CgVnsYcH08tRkw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org



On 02/21/2012 08:26 PM, Tomoya MORINAGA wrote:
> 2012年2月22日12:36 Darren Hart <dvhart@linux.intel.com>:
>> This patch series allows for a functional early serial console as well
>> as using the UART after boot. It leaves the CM-iTC board alone. So this
>> seems to enable all use cases, while forcing 192MHz breaks the FRI2
>> early serial console. I don't see an advantage to that approach other
>> than the obviously simpler code (which is nice, but should not trump
>> functionality).
> 
> Your quark "Fish River Island II" is OK.
> My concern is default uart_clock remains 1.8432 MHz.
> Like I said the advantage before, I think this should be 192MHz not 1.8432 MHz.
> 
> Or do you have any reason 1.8432 MHz should be set as PCH_UART default  clock.

Ah, that's a good point. We can add a patch to this series that sets the
default to 192MHz, drops the CM-iTC quirk, and does nothing in pch_phub
probe for the FRI2. Would you care to Ack this series and then follow-up
with a patch set the default clock to 192MHz?

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
