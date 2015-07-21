From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Tue, 21 Jul 2015 15:17:50 -0700
Message-ID: <55AEC50E.3030202@roeck-us.net>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net> <20150721210115.GJ9981@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150721210115.GJ9981@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-serial@vger.kernel.org

On 07/21/2015 02:01 PM, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
>> Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get funct=
ions")
>> makes the flags argument to devm_gpiod_get_optional mandatory but do=
es not
>> update all users. This results in the following build error.
>>
>> drivers/tty/serial/etraxfs-uart.c:933:16: error:
>> 	too few arguments to function =E2=80=98devm_gpiod_get_optional=E2=80=
=99
>>
>> Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get funct=
ions")
>> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> We discussed this driver while I worked on updating the gpiod API. I
> don't care much about this driver, but if you want to do something ab=
out
> the build failure, I'd prefer:
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 76e65b714471..3a6a7c235f09 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1066,6 +1066,7 @@ config SERIAL_VT8500_CONSOLE
>   config SERIAL_ETRAXFS
>   	bool "ETRAX FS serial port support"
>   	depends on ETRAX_ARCH_V32 && OF
> +	depends on BROKEN
>   	select SERIAL_CORE
>
>   config SERIAL_ETRAXFS_CONSOLE
>
> Best regards
> Uwe
>

Uwe,

I understand the value of BROKEN, but I do not think it would be
appropriate here. It would be appropriate for a driver which is really
broken, not one that doesn't build anymore because an API it uses
was updated and the driver code wasn't updated for some reason.

With your suggested patch I would no longer be able to run my qemu test=
s
for this architecture, which I would not entirely be happy about.

You may not care, but maybe others do.

Makes me wonder: It used to be that API changes were handled by those
making the API changes, not by those responsible for the code using
the API. Has this changed recently, ie is it now acceptable to not
update all callers of a modified API (on purpose, as it looks like
it was done here) ?

Thanks,
Guenter
