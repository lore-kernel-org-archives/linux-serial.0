From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] tty: Remove leftover dependencies on PPC_OF
Date: Fri, 17 Apr 2015 07:58:10 +0100
Message-ID: <CACxGe6tVLha4wS3=La1Wji7pa_X3WXnmkM-GYxETFj5Cti=u7A@mail.gmail.com>
References: <1429248059-18461-1-git-send-email-linux@roeck-us.net> <20150417060104.GH6256@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150417060104.GH6256@pek-khao-d1.corp.ad.wrs.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 17, 2015 at 7:01 AM, Kevin Hao <haokexin@gmail.com> wrote:
> On Thu, Apr 16, 2015 at 10:20:59PM -0700, Guenter Roeck wrote:
>> powerpc qemu runs fail with the current upstream kernel.
>> Bisect points to commit 52d996270032 ("powerpc: kill PPC_OF").
>> Unfortunately, that commit did not remove all instances of PPC_OF.
>> Practical impact is that the serial driver used by powerpc qemu
>> targets is no longer built into the test kernel.
>
> Sorry for the break. This is a dependency issue. The patch 213dce3c17a6
> ("tty: kconfig: remove the superfluous dependency on PPC_OF") has already
> been merged into tty-next, but still not propagate to upstream yet. I failed
> to reminder Michael of this when the pulling request is sent to Linus.

This means you're doing it wrong. If there are dependencies between
patches, then they *must* all be in the same tree. You cannot depend
on the order that branches get merged because it breaks bisecting.

Or, to put it another way, every branch must compile on it's own
without needing to be merged into mainline or linux-next first.

There are two ways to handle this. The easiest is to commit all the
patches to a single branch. Then there is guaranteed to be no
problems. However, if the patches really need to be split up between
several branches, then the way to handle it is to put the prerequisite
patches into a new clean branch, and then merge that branch into each
tree that needs the prerequisite. That way every single tree includes
the required commit without committing it more than once or breaking
bisectability.

g.

>
> Thanks,
> Kevin
>>
>> Fixes: 52d996270032 ("powerpc: kill PPC_OF")
>> Cc: Kevin Hao <haokexin@gmail.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  drivers/tty/serial/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index d2501f01cd03..77471d3db8d3 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -835,7 +835,7 @@ config SERIAL_MCF_CONSOLE
>>
>>  config SERIAL_PMACZILOG
>>       tristate "Mac or PowerMac z85c30 ESCC support"
>> -     depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
>> +     depends on (M68K && MAC) || PPC_PMAC
>>       select SERIAL_CORE
>>       help
>>         This driver supports the Zilog z85C30 serial ports found on
>> @@ -1153,7 +1153,7 @@ config SERIAL_OMAP_CONSOLE
>>
>>  config SERIAL_OF_PLATFORM_NWPSERIAL
>>       tristate "NWP serial port driver"
>> -     depends on PPC_OF && PPC_DCR
>> +     depends on PPC_DCR
>>       select SERIAL_OF_PLATFORM
>>       select SERIAL_CORE_CONSOLE
>>       select SERIAL_CORE
>> --
>> 2.1.0
>>
