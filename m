From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/2] serial: 8250: Initialize pointer to irq_info
Date: Tue, 17 Aug 2010 10:56:31 +0200
Message-ID: <4C6A4EBF.9060301@monstr.eu>
References: <1282031947-16483-1-git-send-email-monstr@monstr.eu> <20100817091720.56183993@linux.intel.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54540 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab0HQI4f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Aug 2010 04:56:35 -0400
In-Reply-To: <20100817091720.56183993@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: michal.simek@petalogix.com, Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@googlemail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 17 Aug 2010 09:59:06 +0200
> Michal Simek <monstr@monstr.eu> wrote:
> 
>> Initialize "i" irq_info pointer in serial_unlink_irq_chain.
>>
>> Compilation warning:
>>   CC      drivers/serial/8250.o
>> drivers/serial/8250.c: In function 'serial8250_shutdown':
>> drivers/serial/8250.c:1701: warning: 'i' may be used uninitialized in
>> this function
> 
> NAK (again)
> 
> Use a newer compiler - modern ones get this right.

I wasn't sure if is bug or not.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
