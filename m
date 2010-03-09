From: James Lamanna <jlamanna@gmail.com>
Subject: Re: SIIG DP CyberSerial 4S PCIe Support
Date: Tue, 9 Mar 2010 07:06:49 -0800
Message-ID: <61FB983A-8BF8-4295-A496-1E5B2136EB36@gmail.com>
References: <aa4c40ff1003081107n78e9f052n2a754680e5491c68@mail.gmail.com> <aa4c40ff1003081313s7492513bk14a48c6097b90407@mail.gmail.com> <4B95B028.3050106@gmail.com> <aa4c40ff1003082115x3e9e1492je90e5afb826b3408@mail.gmail.com> <20100309141552.GD30538@centrinvest.ru>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:54579 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab0CIPHA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Mar 2010 10:07:00 -0500
In-Reply-To: <20100309141552.GD30538@centrinvest.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrey Panin <pazke@centrinvest.ru>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>



--James

On Mar 9, 2010, at 6:15, "Andrey Panin" <pazke@centrinvest.ru> wrote:

> On 067, 03 08, 2010 at 09:15:26PM -0800, James Lamanna wrote:
>
>> That's probably the case.
>> It looks like 8250 doesn't know about this PCIe device at all.
>> The Oxford PCI ID is not in pci_ids.h nor is the SIIG subsystem ID.
>> I'll see if I can maybe work up a patch to support this device,  
>> since I've found
>> the datasheet for the Oxford 4 port UART controller, but I may need  
>> some help.
>> Or if anyone else (who has more experience with this) wants to  
>> formulate one,
>> it would be greatly appreciated.
>
> Looks like you card can use existing code for Oxford Semiconductor  
> UARTs.
> Can you test the attached patch for 2.6.33 ?
> <patch-siig-pcie>
