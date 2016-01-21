From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH] serial: amba-pl011: mark vendor_zte as __maybe_unused
Date: Thu, 21 Jan 2016 10:34:53 +0800
Message-ID: <CABymUCMwgcEHDBEHCy=4E2bLbDdqQ+KO3ijB0Rz-m0uczWne7Q@mail.gmail.com>
References: <1973012.CU51qOk9Kt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1973012.CU51qOk9Kt@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

2016-01-20 18:40 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> The pl011 driver has gone back and forth on the definition of the
> ZTE specific variation of the hardware definitions, but the
> current state is that the vendor definition is left in place
> yet unused:
>
> drivers/tty/serial/amba-pl011.c:190:27: warning: 'vendor_zte' defined but not used [-Wunused-variable]
>
> I don't know what the plan forward is to get this code to work,
> but the current behavior is a bit annoying as we get a warning
> whenever we build this driver.
>
> This patch does not help us to make it work, but at least
> shuts up the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7ec758718920 ("tty: amba-pl011: add support for ZTE UART (EXPERIMENTAL)")
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c0da0ccbbcf5..4cdfe8f806df 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -187,7 +187,7 @@ static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
>         [REG_DMACR] = ZX_UART011_DMACR,
>  };
>
> -static struct vendor_data vendor_zte = {
> +static struct vendor_data vendor_zte __maybe_unused = {
>         .reg_offset             = pl011_zte_offsets,
>         .access_32b             = true,
>         .ifls                   = UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
>

Thanks for handling this. I am OK with the patch. Will prepare a patch
to make ZTE uart work after Timur's pending pl011 patch is merged.

Jun
