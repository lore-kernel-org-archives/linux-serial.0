From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Date: Wed, 19 Jun 2013 12:12:09 -0700
Message-ID: <51C20289.1060303@caviumnetworks.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <2302882.NVjP8DdXWY@wuerfel> <51C1E028.2040700@caviumnetworks.com> <201306192052.09575.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-by2lp0236.outbound.protection.outlook.com ([207.46.163.236]:18782
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757435Ab3FSTMP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Jun 2013 15:12:15 -0400
In-Reply-To: <201306192052.09575.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>

On 06/19/2013 11:52 AM, Arnd Bergmann wrote:
> On Wednesday 19 June 2013, David Daney wrote:
>> On 06/19/2013 03:01 AM, Arnd Bergmann wrote:
>
>>> It's also wrong to use the
>>> __raw_* variant, which is not guaranteed to be atomic and is not
>>> endian-safe.
>>
>> We do runtime probing and only use this function on platforms where it
>> is appropriate, so atomicity is not an issue.  As for endianess, I used
>> the __raw_ variant precisely because it is correct for both big and
>> little endian kernels.
>
> You don't know what the compiler turns a __raw_writeq into, it could
> always to eight byte wise stores, that's why typically writeq is
> an inline assembly while __raw_writeq is just a pointer dereference.

Well, I do know that for the cases of interest, it will be a single load 
or store, but it is moot, as I rewrote that part.

>
> __raw_* never do endian swaps,

Yes, I know that.

> so it will be wrong on either big-endian
> CPUs or on little-endian CPUs, depending on what the MMIO register
> needs.

Please see the instruction set reference manual 
(MD00087-2B-MIPS64BIS-AFP-03.51 or similar) available at:

http://www.mips.com/products/architectures/mips64/#specifications

... for why you are mistaken.  Pay particular attention to the low order 
address bit scrambling on narrow loads and stores and how this results 
in uniform (not affected by processor endian mode) load and store 
results for aligned 64-bit accesses.  In effect, it is magic, and 
__raw_writeq yields correct results in both big and little endian modes 
of operation.

David Daney.


