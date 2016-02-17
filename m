From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V3 3/4] 8250: 8250_f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO UART support
Date: Wed, 17 Feb 2016 17:30:15 +0800
Message-ID: <56C43DA7.9080400@gmail.com>
References: <1455605710-3724-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1455605710-3724-4-git-send-email-hpeter+linux_kernel@gmail.com>
 <1455613899.31169.149.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455613899.31169.149.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Andy Shevchenko =E6=96=BC 2016/2/16 =E4=B8=8B=E5=8D=88 05:11 =E5=AF=AB=E9=
=81=93:
> On Tue, 2016-02-16 at 14:55 +0800, Peter Hung wrote:
>> +static u32 baudrate_table[] =3D { 1500000, 1152000, 921600 };
>> +static u8 clock_table[] =3D { F81504_CLKSEL_24_MHZ,
>> F81504_CLKSEL_18DOT46_MHZ,
>> +				F81504_CLKSEL_14DOT77_MHZ };
>
> I suggest to replace DOT by _.

ok

>> +/* We should do proper H/W transceiver setting before change to
>> RS485 mode */
>> +static int f81504_rs485_config(struct uart_port *port,
>> +			       struct serial_rs485 *rs485)
>> +{
>> +	u8 setting;
>> +	u8 *index =3D (u8 *) port->private_data;
>
> private_data is a type of void *, therefore no need to have an explic=
it
> casting.

ok


>> +static int f81504_check_baudrate(u32 baud, size_t *idx)
>> +{
>> +	size_t index;
>> +	u32 quot, rem;
>> +
>> +	for (index =3D 0; index < ARRAY_SIZE(baudrate_table); ++index)
>
> Post-increment is also okay.
>
>> {
>> +		/* Clock source must largeer than desire baudrate */
>> +		if (baud > baudrate_table[index])
>> +			continue;
>> +
>> +		quot =3D DIV_ROUND_CLOSEST(baudrate_table[index],
>> baud);
>
> So, how quot is used and is it possible to set, for example, baud rat=
e
> as 1000000 or 576000?

The IC don't support B1000000 due to no 16MHz clock source.

The quot & rem is only use for compare, and it's must be not 0
when the code run to calculate DIV_ROUND_CLOSEST. So quot
is a redundancy here.

This function will find the suitable clock source for future use.
We'll pass suitable baud rate * 16 to port->uartclk for
serial8250_do_set_termios() to do advance divider operations.

I'll rewrite this section with remove quot and direct check
the "baudrate_table[index] % baud" divisible.


>> +	u8 tmp, *offset =3D (u8 *) port->private_data;
>
> Same for provate_data as above.

ok


>> +			/*
>> +			 * direct use 1.8432MHz when baudrate
>> smaller then or
>> +			 * equal 115200bps
>
> Check your style of comments in a _whole_ your series.

ok


>> +			/*
>> +			 * If it can't found suitable clock source
>> but had old
>> +			 * accpetable baudrate, we'll use it
>
> Typo: acceptable.
> Baudrate ->  baud rate.

ok

>> +	port.port.private_data =3D data;	/* save current idx */
>
> Not sure you need to allocate memory for that at all, or maybe use a
> struct with one member (for now).
>

We just pass the index of PCI configuration space currently. So
I just set a allocated u8 memory to private data. We'll maintain
current method.


>> +static SIMPLE_DEV_PM_OPS(f81504_serial_pm_ops,
>> f81504_serial_suspend,
>> +		f81504_serial_resume);
>> +
>> +static struct platform_driver f81504_serial_driver =3D {
>> +	.driver =3D {
>> +		.name	=3D F81504_SERIAL_NAME,
>> +		.owner	=3D THIS_MODULE,
>
> You perhaps don't need this. Check the rest of the modules.

ok


>> +config SERIAL_8250_F81504
>> +        tristate "Fintek F81504/508/512 16550 PCIE device support"
>> if EXPERT
>> +        depends on SERIAL_8250 && MFD_FINTEK_F81504_CORE
>> +        default SERIAL_8250
>> +        select RATIONAL
>
> It seems RATIONAL API is not used here.
>

This driver hadn't use RATIONAL API. I'll remove it.


Thanks for your advice.
--=20
With Best Regards,
Peter Hung
