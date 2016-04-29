From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2] serial: mctrl_gpio: Drop support for out1-gpios and out2-gpios
Date: Fri, 29 Apr 2016 15:21:37 +0200
Message-ID: <CAGm1_ksHa_148RzRHF-=qnTJY1ffE=apTW3kpabr=TyQpKCYZw@mail.gmail.com>
References: <1461930026-15783-1-git-send-email-geert+renesas@glider.be> <CACQ1gAiwO1FeAyo0u1nM4_b+B66D2EcNcLSeZeLA2aRQmO_PSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACQ1gAiwO1FeAyo0u1nM4_b+B66D2EcNcLSeZeLA2aRQmO_PSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 29, 2016 at 3:11 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:
> 2016-04-29 13:40 GMT+02:00 Geert Uytterhoeven <geert+renesas@glider.be>:
>> The OUT1 and OUT2 pins present on some legacy UARTs are basically GPIOs.
>> It doesn't make much sense to emulate GPIOs using other GPIOs, hence
>> drop support for that.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>> v2:
>>   - Add Reviewed-by,
>>   - Drop forgotten UART_GPIO_OUT[12] enum values.
>> ---
>>  drivers/tty/serial/serial_mctrl_gpio.c | 2 --
>>  drivers/tty/serial/serial_mctrl_gpio.h | 2 --
>>  2 files changed, 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
>> index 02147361eaa94747..821ffa637eb630cb 100644
>> --- a/drivers/tty/serial/serial_mctrl_gpio.c
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
>> @@ -43,8 +43,6 @@ static const struct {
>>         { "rng", TIOCM_RNG, false, },
>>         { "rts", TIOCM_RTS, true, },
>>         { "dtr", TIOCM_DTR, true, },
>> -       { "out1", TIOCM_OUT1, true, },
>> -       { "out2", TIOCM_OUT2, true, },
>>  };
>>
>>  void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
>> index bcfad5d1db61decf..332a33ab0647cbe3 100644
>> --- a/drivers/tty/serial/serial_mctrl_gpio.h
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.h
>> @@ -32,8 +32,6 @@ enum mctrl_gpio_idx {
>>         UART_GPIO_RI = UART_GPIO_RNG,
>>         UART_GPIO_RTS,
>>         UART_GPIO_DTR,
>> -       UART_GPIO_OUT1,
>> -       UART_GPIO_OUT2,
>>         UART_GPIO_MAX,
>>  };
>>
>> --
>> 1.9.1
>>
> It seems all right now !
>
>
> Reviewed-by: Richard Genoud <richard.genoud@gmail.com>

Reviewed-by: Yegor Yefremov <yegorslists@googlemail.com>
