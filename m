From: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Thu, 11 Feb 2016 07:45:11 +0100
Message-ID: <56BC2DF7.20803@samsung.com>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
 <4571887.rTPndCnv20@wuerfel> <56BAA27A.9050605@roeck-us.net>
 <2606061.l722KO95iI@wuerfel> <56BC022B.7030004@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <56BC022B.7030004-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 02/11/2016 04:38 AM, Guenter Roeck wrote:
> On 02/10/2016 07:21 AM, Arnd Bergmann wrote:
>> On Tuesday 09 February 2016 18:37:46 Guenter Roeck wrote:
>>> On 02/09/2016 07:26 AM, Arnd Bergmann wrote:
>>>> On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
>>>>> IS_ERR_VALUE() assumes that its parameter is an unsigned long.
>>>>> It can not be used to check if an unsigned int reflects an error.
>>>>> Doing so can result in the following build warning.
>>>>>
>>>>> drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digico=
lor_uart_probe=E2=80=99:
>>>>> include/linux/err.h:21:38: warning:
>>>>>           comparison is always false due to limited range of data=
 type
>>>>> drivers/tty/serial/digicolor-usart.c:485:6: note:
>>>>>           in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99
>>>>>
>>>>> If that warning is seen, an error return from platform_get_irq() =
is missed.
>>>>>
>>>>>
>>>> The patch looks correct to me, but what compiler version and which=
 kernel
>>>> tree is it that triggered the warning?
>>>>
>>>> Andrzej Hajda just modified the definition of IS_ERR_VALUE(), and =
the
>>>> changes are still under discussion, but I don't see that warning w=
ith
>>>> any of the versions.
>>>>
>>> I see it with gcc 5.1 and 5.2 (and W=3D1). I did not see / notice A=
ndrzej's patch.
>>>
>>> I agree that fixing the problem in IS_ERR_VALUE() is preferrable.
>>>
>>>
>> Ah, W=3D1 explains it. We are still debating about the proper soluti=
on. Al Viro
>> pointed out that most users of IS_ERR_VALUE() shouldn't be using it =
at all,
>> so your patch is probably best here after all.
>>
> Yes, after looking into it some more I agree. Coccinelle should be ab=
le to handle
> most of the conversions automatically. I actually tried to write a sc=
ript, just
> for the fun of it, but it misses some of the problem cases in patch m=
ode.
> Maybe I get it working tonight.
>
> Guenter
>

Maybe it can be helpful. The script which classifies all IS_ERR_VALUE
usages as
correct, signed, incorrect and unknown (cocci was not able to detect ty=
pe).
Adding patch mode should be quite simple.

// Options: --all-includes --include
include/uapi/linux/netfilter_ipv6/ip6_tables.h --include
include/uapi/linux/netfilter_ipv4/ip_tables.h --include
include/uapi/linux/netfilter_arp/arp_tables.h --include
include/uapi/linux/netfilter/x_tables.h --include include/linux/mm_type=
s.h

virtual context
virtual report

@r@
typedef bool, u8, u16, u32, u64, s8, s16, s32, s64, __u64, dma_addr_t,
Elf32_Addr, Elf64_Addr;
{unsigned long, size_t} ev;
{short, int, long, s16, s32, ssize_t} ew;
{char, unsigned char, unsigned short, unsigned int, long long, unsigned
long long, bool, u8, u16, u32, u64, s64, __u64, dma_addr_t, Elf32_Addr,
Elf64_Addr} ei;
expression eu;
position p;
@@

IS_ERR_VALUE(\(ev \| ew \| ei \| eu \))@p

@script:python depends on report@
p << r.p =3D [];
ev << r.ev =3D "";
ew << r.ew =3D "";
ei << r.ei =3D "";
eu << r.eu =3D "";
@@

t =3D ""
if ev: t =3D "correct"
if ew: t =3D "signed"
if ei: t =3D "incorrect"
if eu: t =3D "unknown"


e =3D ev + ew + ei + eu;
if t:
    msg =3D "WARNING: %s argument type in IS_ERR_VALUE(%s)" % (t, e)
    coccilib.report.print_report(p[0], msg)
