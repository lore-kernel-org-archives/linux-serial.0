From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/2] serial: sc16is7xx: depend on I2C
Date: Fri, 25 Apr 2014 13:42:17 -0700
Message-ID: <535AC8A9.9030303@infradead.org>
References: <1398455590-4374-1-git-send-email-jon@ringle.org> <1398457576.792048107@f368.i.mail.ru> <20140425203528.GA15154@kroah.com> <1398458399.164274248@f343.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398458399.164274248@f343.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>, jon@ringle.org
List-Id: linux-serial@vger.kernel.org

On 04/25/14 13:39, Alexander Shiyan wrote:
> Fri, 25 Apr 2014 13:35:28 -0700 =D0=BE=D1=82 Greg KH <gregkh@linuxfou=
ndation.org>:
>> On Sat, Apr 26, 2014 at 12:26:16AM +0400, Alexander Shiyan wrote:
>>> Fri, 25 Apr 2014 13:23:15 -0700 =D0=BE=D1=82 Greg KH <gregkh@linuxf=
oundation.org>:
>>>> On Fri, Apr 25, 2014 at 03:53:09PM -0400, jon@ringle.org wrote:
>>>>> From: Jon Ringle <jringle@gridpoint.com>
>>>>>
>>>>> Signed-off-by: Jon Ringle <jringle@gridpoint.com>
>>>>> ---
>>>>>  drivers/tty/serial/Kconfig | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kcon=
fig
>>>>> index c3e2b32..64c5659 100644
>>>>> --- a/drivers/tty/serial/Kconfig
>>>>> +++ b/drivers/tty/serial/Kconfig
>>>>> @@ -1180,6 +1180,7 @@ config SERIAL_SCCNXP_CONSOLE
>>>>> =20
>>>>>  config SERIAL_SC16IS7XX
>>>>>  	tristate "SC16IS7xx serial support"
>>>>> +	depends on I2C
>>>>>  	select SERIAL_CORE
>>>>>  	select REGMAP_I2C if I2C
>>>>>  	help
>>>>> --=20
>>>>> 1.8.5.4
>>>>
>>>> Better, but I still have the build warnings :(
>>>
>>> I hope not same as before?
>>
>> Exactly the same.
>=20
> Hmm...
>=20
> In the source:
> #ifdef CONFIG_REGMAP_I2C
> Should be of course #ifdef CONFIG_I2C
> But this should not provide such warnings...

Can I see the warnings and .config file that causes them?


--=20
~Randy
