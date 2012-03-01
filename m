From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 0/4 V2] pch_uart: Cleanups, board quirks, and user uartclk
 parameter
Date: Wed, 29 Feb 2012 17:12:08 -0800
Message-ID: <4F4ECCE8.90207@linux.intel.com>
References: <cover.1330539597.git.dvhart@linux.intel.com> <CANKRQnhFVJAUHAg0qTPFJ8L0L_+-_q4ZtfOnV0wSR1Xa6Mn8UQ@mail.gmail.com> <4F4EC73E.40209@linux.intel.com> <CANKRQnjQ4WB-ExmM5G5diw1LyA_HwySzkNyhKmf4fDLn0ZO7wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36989 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756520Ab2CABMo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Feb 2012 20:12:44 -0500
In-Reply-To: <CANKRQnjQ4WB-ExmM5G5diw1LyA_HwySzkNyhKmf4fDLn0ZO7wg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org



On 02/29/2012 05:06 PM, Tomoya MORINAGA wrote:
> 2012年3月1日9:47 Darren Hart <dvhart@linux.intel.com>:
>> how do we force the
>> 192MHz clock setting BEFORE the pch_phub code runs?
> 
> To realize your requirement,
> I think that set by BIOS is only way.

Perhaps a pch_phub.bios_uartclk parameter could be used for setting up
the initial console and once the phub driver is loaded, it can make the
necessary changes and fix things up in the uart port? This would add a
binding between the pch_uart and pch_phub code.

Thoughts?

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
