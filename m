From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 0/4] pch_uart: Cleanups, board quirks, and user uartclk
 parameter
Date: Wed, 22 Feb 2012 00:59:03 -0800
Message-ID: <4F44AE57.10302@linux.intel.com>
References: <cover.1329875301.git.dvhart@linux.intel.com> <CANKRQni9E6NO39MFSak6MjQ0DtmQeviGo966Ex9ZUvai56wCjg@mail.gmail.com> <4F4462B8.6030607@linux.intel.com> <CANKRQnhckD5Dt+0PbD3h=Ggz+U8RoDs0qUn5CgVnsYcH08tRkw@mail.gmail.com> <4F448DAA.6000207@linux.intel.com> <CANKRQngnFhTY3-YxhDH3oufbqUu5pe36Fi58DjKWm=9uTigr-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8236 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab2BVI7j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 03:59:39 -0500
In-Reply-To: <CANKRQngnFhTY3-YxhDH3oufbqUu5pe36Fi58DjKWm=9uTigr-A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org



On 02/22/2012 12:16 AM, Tomoya MORINAGA wrote:
> 2012年2月22日15:39 Darren Hart <dvhart@linux.intel.com>:
>> We can add a patch to this series that sets the
>> default to 192MHz, drops the CM-iTC quirk, and does nothing in pch_phub
>> probe for the FRI2.
> 
> If you set  the clock of pch_uart as 64MHz,
> do you need to add quirk for FRI2 to pch_phub so as to provide 64MHz clock?

I admit the value of pch_phub eludes me a bit. In my case, the firmware
sets up the CLKCFG register, so there is no need to set it manually
after boot. Instead, I'm making sure the pch_uart driver defaults to
what the firmware sets up.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
