From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [RESEND][PATCH] ARM: debug: add support for Palmchip 16550-like
 UART
Date: Wed, 04 Nov 2015 15:47:26 +0000
Message-ID: <yw1x1tc59375.fsf@unicorn.mansr.com>
References: <1445950678-16097-1-git-send-email-mans@mansr.com>
 <563A26B8.9080405@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <563A26B8.9080405@free.fr> (Mason's message of "Wed, 4 Nov 2015
 16:39:36 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mason <slash.tmp@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>, linux-serial <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Mason <slash.tmp@free.fr> writes:

> On 27/10/2015 13:57, Mans Rullgard wrote:
>
>> Some SoCs have a Palmchip UART with a non-standard register layout.
>> This allows the debug console to work with these.
>> =

>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>  arch/arm/Kconfig.debug        |  8 ++++++++
>>  arch/arm/include/debug/8250.S | 12 ++++++++++++
>>  2 files changed, 20 insertions(+)
>> =

>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 0cfd7f9..9039fff 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -1597,6 +1597,14 @@ config DEBUG_UART_8250_WORD
>>  		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
>>  		DEBUG_BRCMSTB_UART
>>  =

>> +config DEBUG_UART_8250_PALMCHIP
>> +	bool "8250 UART is Palmchip variant"
>> +	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
>
> I am 100% clueless about the UART sequence in Linux.
>
> There's earlyprintk, the boot console (polled?), the "full-blown"
> console (with IRQs)...
>
> If I want earlyprintk, I have to enable DEBUG_LL (?) so I'll have
> DEBUG_LL_UART_8250, right? There's no way to pick DEBUG_UART_8250
> in menuconfig, is there?
>
> So I picked the following options:
>
> CONFIG_DEBUG_LL=3Dy
> # CONFIG_DEBUG_ICEDCC is not set
> # CONFIG_DEBUG_SEMIHOSTING is not set
> CONFIG_DEBUG_LL_UART_8250=3Dy
> # CONFIG_DEBUG_LL_UART_PL01X is not set
> CONFIG_DEBUG_LL_INCLUDE=3D"debug/8250.S"
> # CONFIG_DEBUG_UART_8250 is not set
> # CONFIG_DEBUG_UART_BCM63XX is not set
> CONFIG_DEBUG_UART_PHYS=3D0x10700
> CONFIG_DEBUG_UART_VIRT=3D0xf0010700
> CONFIG_DEBUG_UART_8250_SHIFT=3D2
> CONFIG_DEBUG_UART_8250_WORD=3Dy
> CONFIG_DEBUG_UART_8250_PALMCHIP=3Dy
> # CONFIG_DEBUG_UART_8250_FLOW_CONTROL is not set
> CONFIG_DEBUG_UNCOMPRESS=3Dy
> CONFIG_UNCOMPRESS_INCLUDE=3D"debug/uncompress.h"
> CONFIG_EARLY_PRINTK=3Dy

Those are the settings I use.

> I suppose I have to provide DEBUG_UART_PHYS because it needs
> the address before it can parse the DT? But how am I supposed
> to know the virtual address? Isn't that from iomap(UART_PHYS)?

The decompression code and early setup don't have that luxury.

> 'make' wouldn't let me proceed unless I gave something...
>
> Then I have to add earlyprintk to my boot command line, right?
> Do I need to specify more than that?

Just earlyprintk without any parameters works.

-- =

M=E5ns Rullg=E5rd
mans@mansr.com
