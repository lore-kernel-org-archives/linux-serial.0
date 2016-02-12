From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Fri, 12 Feb 2016 07:38:51 +0100
Message-ID: <56BD7DFB.10608@samsung.com>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
 <4571887.rTPndCnv20@wuerfel> <56BAA27A.9050605@roeck-us.net>
 <2606061.l722KO95iI@wuerfel> <56BC022B.7030004@roeck-us.net>
 <56BC2DF7.20803@samsung.com> <20160211153243.GA3076@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160211153243.GA3076@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Baruch Siach <baruch@tkos.co.il>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, kernel-testers@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 02/11/2016 04:32 PM, Guenter Roeck wrote:
> On Thu, Feb 11, 2016 at 07:45:11AM +0100, Andrzej Hajda wrote:
>> On 02/11/2016 04:38 AM, Guenter Roeck wrote:
>>> On 02/10/2016 07:21 AM, Arnd Bergmann wrote:
>>>> On Tuesday 09 February 2016 18:37:46 Guenter Roeck wrote:
>>>>> On 02/09/2016 07:26 AM, Arnd Bergmann wrote:
>>>>>> On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
>>>>>>> IS_ERR_VALUE() assumes that its parameter is an unsigned long.
>>>>>>> It can not be used to check if an unsigned int reflects an erro=
r.
>>>>>>> Doing so can result in the following build warning.
>>>>>>>
>>>>>>> drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digi=
color_uart_probe=E2=80=99:
>>>>>>> include/linux/err.h:21:38: warning:
>>>>>>>           comparison is always false due to limited range of da=
ta type
>>>>>>> drivers/tty/serial/digicolor-usart.c:485:6: note:
>>>>>>>           in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99
>>>>>>>
>>>>>>> If that warning is seen, an error return from platform_get_irq(=
) is missed.
>>>>>>>
>>>>>>>
>>>>>> The patch looks correct to me, but what compiler version and whi=
ch kernel
>>>>>> tree is it that triggered the warning?
>>>>>>
>>>>>> Andrzej Hajda just modified the definition of IS_ERR_VALUE(), an=
d the
>>>>>> changes are still under discussion, but I don't see that warning=
 with
>>>>>> any of the versions.
>>>>>>
>>>>> I see it with gcc 5.1 and 5.2 (and W=3D1). I did not see / notice=
 Andrzej's patch.
>>>>>
>>>>> I agree that fixing the problem in IS_ERR_VALUE() is preferrable.
>>>>>
>>>>>
>>>> Ah, W=3D1 explains it. We are still debating about the proper solu=
tion. Al Viro
>>>> pointed out that most users of IS_ERR_VALUE() shouldn't be using i=
t at all,
>>>> so your patch is probably best here after all.
>>>>
>>> Yes, after looking into it some more I agree. Coccinelle should be =
able to handle
>>> most of the conversions automatically. I actually tried to write a =
script, just
>>> for the fun of it, but it misses some of the problem cases in patch=
 mode.
>>> Maybe I get it working tonight.
>>>
>>> Guenter
>>>
>> Maybe it can be helpful. The script which classifies all IS_ERR_VALU=
E
>> usages as
>> correct, signed, incorrect and unknown (cocci was not able to detect=
 type).
>> Adding patch mode should be quite simple.
>>
>> // Options: --all-includes --include
>> include/uapi/linux/netfilter_ipv6/ip6_tables.h --include
>> include/uapi/linux/netfilter_ipv4/ip_tables.h --include
>> include/uapi/linux/netfilter_arp/arp_tables.h --include
>> include/uapi/linux/netfilter/x_tables.h --include include/linux/mm_t=
ypes.h
>>
>> virtual context
>> virtual report
>>
>> @r@
>> typedef bool, u8, u16, u32, u64, s8, s16, s32, s64, __u64, dma_addr_=
t,
>> Elf32_Addr, Elf64_Addr;
>> {unsigned long, size_t} ev;
>> {short, int, long, s16, s32, ssize_t} ew;
>> {char, unsigned char, unsigned short, unsigned int, long long, unsig=
ned
>> long long, bool, u8, u16, u32, u64, s64, __u64, dma_addr_t, Elf32_Ad=
dr,
>> Elf64_Addr} ei;
>> expression eu;
>> position p;
>> @@
>>
>> IS_ERR_VALUE(\(ev \| ew \| ei \| eu \))@p
>>
>> @script:python depends on report@
>> p << r.p =3D [];
>> ev << r.ev =3D "";
>> ew << r.ew =3D "";
>> ei << r.ei =3D "";
>> eu << r.eu =3D "";
> This doesn't work for me; it bails out at the assignments. If I remov=
e
> the assignments, it does not report anything.
>
> Any idea what might be wrong ?

Old version of spatch. Default values are supported since 1.0.3.

Regards
Andrzej
