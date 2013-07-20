From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/12] drivers/tty/serial: don't use devm_pinctrl_get_select_default()
 in probe
Date: Sat, 20 Jul 2013 19:46:48 +0200
Message-ID: <CACRpkdYnPN3sm8x9B02bkTuR3oufrng60YU-XeG4fA28J_B_ww@mail.gmail.com>
References: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
	<1373471889-18107-11-git-send-email-wsa@the-dreams.de>
	<51DE617E.3060908@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51DE617E.3060908@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 11, 2013 at 9:40 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 10/07/2013 17:57, Wolfram Sang :
>
>> Since commit ab78029 (drivers/pinctrl: grab default handles from device
>> core),
>> we can rely on device core for setting the default pins. Compile tested
>> only.
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>> ---
>>   drivers/tty/serial/atmel_serial.c |    8 --------
>
>
> For atmel_serial.c:
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Greg can you please apply this to the TTY tree if it looks
OK to you?

Yours,
Linus Walleij
