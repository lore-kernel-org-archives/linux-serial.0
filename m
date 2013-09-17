From: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>
Subject: Re: [PATCH] serial: samsung: add support for manual RTS setting
Date: Tue, 17 Sep 2013 14:03:35 +0100
Message-ID: <52385327.9020706@inov.pt>
References: <1378894107-7904-1-git-send-email-jose.goncalves@inov.pt> <35383907.gKXZyKLrYq@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <35383907.gKXZyKLrYq@amdc1227>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
List-Id: linux-serial@vger.kernel.org

Hi Tomasz,

On 17-09-2013 11:18, Tomasz Figa wrote:
> Hi Jos=E9,
>
> Please see my comments below.
>
> On Wednesday 11 of September 2013 11:08:27 Jos=E9 Miguel Gon=E7alves =
wrote:
>> The Samsung serial driver currently does not support setting the
>> RTS pin with an ioctl(TIOCMSET) call. This patch adds this support.
>>
>> Signed-off-by: Jos=E9 Miguel Gon=E7alves <jose.goncalves@inov.pt>
>> ---
>>   drivers/tty/serial/samsung.c |   17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsu=
ng.c
>> index f3dfa19..e5dd808 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -407,7 +407,14 @@ static unsigned int s3c24xx_serial_get_mctrl(st=
ruct
>> uart_port *port)
>>
>>   static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsig=
ned
>> int mctrl) {
>> -	/* todo - possibly remove AFC and do manual CTS */
>> +	unsigned int umcon =3D rd_regl(port, S3C2410_UMCON);
>> +
>> +	if (mctrl & TIOCM_RTS)
>> +		umcon |=3D S3C2410_UMCOM_RTS_LOW;
>> +	else
>> +		umcon &=3D ~S3C2410_UMCOM_RTS_LOW;
>> +
>> +	wr_regl(port, S3C2410_UMCON, umcon);
> I wonder if port capability shouldn't be considered here. Depending o=
n SoC,
> only selected ports provide modem control capability.
>
> For example on S3C64xx only ports 0 and 1 support modem control, whil=
e
> ports 2 and 3 don't.

Same for S3C2416. I also wondered that, but while I have information fo=
r=20
all S3C24xx chips and for those a simple test ( port->line < 2) would=20
validate this, I don't know about other SoCs this driver supports.=20
Bearing this in mind and also that the current implementation of=20
s3c24xx_serial_get_mctrl() does not check also for which port it=20
applies, I opted for this solution.

>
>>   }
>>
>>   static void s3c24xx_serial_break_ctl(struct uart_port *port, int
>> break_state) @@ -774,8 +781,6 @@ static void
>> s3c24xx_serial_set_termios(struct uart_port *port, if (termios->c_cf=
lag
>> & CSTOPB)
>>   		ulcon |=3D S3C2410_LCON_STOPB;
>>
>> -	umcon =3D (termios->c_cflag & CRTSCTS) ? S3C2410_UMCOM_AFC : 0;
>> -
>>   	if (termios->c_cflag & PARENB) {
>>   		if (termios->c_cflag & PARODD)
>>   			ulcon |=3D S3C2410_LCON_PODD;
>> @@ -792,6 +797,12 @@ static void s3c24xx_serial_set_termios(struct
>> uart_port *port,
>>
>>   	wr_regl(port, S3C2410_ULCON, ulcon);
>>   	wr_regl(port, S3C2410_UBRDIV, quot);
>> +
>> +	if (termios->c_cflag & CRTSCTS)
>> +		umcon =3D S3C2410_UMCOM_AFC;
> Is it correct to override the last manual RTS value set to this regis=
ter
> when activating manual flow control?
>
> Shouldn't the code be more like the following:
>
> 	umcon =3D rd_regb(port, S3C2410_UMCON);
> 	if (termios->c_cflag & CRTSCTS)
> 		umcon |=3D S3C2410_UMCOM_AFC;
> 	else
> 		umcon &=3D ~S3C2410_UMCOM_AFC;
> 	wr_regl(port, S3C2410_UMCON, umcon);
>
> Probably port capability should be considered here as well.
>

Looking at the S3C24xx user manuals I've seen that if you set the=20
automatic flow control (AFC) with the S3C2410_UMCOM_AFC mask, the UART=20
controller ignores the manual RTS setting value with the=20
S3C2410_UMCOM_RTS_LOW bitmask, so it is not necessary to do that. Also,=
=20
the upper bits of UMCON control the FIFO level to trigger the AFC and=20
you should initialize these bits when using AFC (I've set these to 0 to=
=20
use full FIFO, as it was previously).

Regarding port capability, if it's decided to validate it in=20
s3c24xx_serial_get_mctrl() and s3c24xx_serial_set_mctrl() it should als=
o=20
be validated here. The question is how to validate for the full spectru=
m=20
of SoCs that this driver supports?

Best regards,
Jos=E9 Gon=E7alves
