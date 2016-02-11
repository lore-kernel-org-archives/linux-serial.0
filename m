From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Wed, 10 Feb 2016 19:38:19 -0800
Message-ID: <56BC022B.7030004@roeck-us.net>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
 <4571887.rTPndCnv20@wuerfel> <56BAA27A.9050605@roeck-us.net>
 <2606061.l722KO95iI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2606061.l722KO95iI@wuerfel>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 02/10/2016 07:21 AM, Arnd Bergmann wrote:
> On Tuesday 09 February 2016 18:37:46 Guenter Roeck wrote:
>> On 02/09/2016 07:26 AM, Arnd Bergmann wrote:
>>> On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
>>>> IS_ERR_VALUE() assumes that its parameter is an unsigned long.
>>>> It can not be used to check if an unsigned int reflects an error.
>>>> Doing so can result in the following build warning.
>>>>
>>>> drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digicol=
or_uart_probe=E2=80=99:
>>>> include/linux/err.h:21:38: warning:
>>>>           comparison is always false due to limited range of data =
type
>>>> drivers/tty/serial/digicolor-usart.c:485:6: note:
>>>>           in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99
>>>>
>>>> If that warning is seen, an error return from platform_get_irq() i=
s missed.
>>>>
>>>>
>>>
>>> The patch looks correct to me, but what compiler version and which =
kernel
>>> tree is it that triggered the warning?
>>>
>>> Andrzej Hajda just modified the definition of IS_ERR_VALUE(), and t=
he
>>> changes are still under discussion, but I don't see that warning wi=
th
>>> any of the versions.
>>>
>> I see it with gcc 5.1 and 5.2 (and W=3D1). I did not see / notice An=
drzej's patch.
>>
>> I agree that fixing the problem in IS_ERR_VALUE() is preferrable.
>>
>>
>
> Ah, W=3D1 explains it. We are still debating about the proper solutio=
n. Al Viro
> pointed out that most users of IS_ERR_VALUE() shouldn't be using it a=
t all,
> so your patch is probably best here after all.
>

Yes, after looking into it some more I agree. Coccinelle should be able=
 to handle
most of the conversions automatically. I actually tried to write a scri=
pt, just
for the fun of it, but it misses some of the problem cases in patch mod=
e.
Maybe I get it working tonight.

Guenter
