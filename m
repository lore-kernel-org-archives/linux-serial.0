From: "long.wanglong" <long.wanglong@huawei.com>
Subject: Re: [RFC] With 8250 Designware UART, if writes to the LCR failed
 the kernel will hung up
Date: Mon, 9 Mar 2015 15:10:49 +0800
Message-ID: <54FD4779.3020902@huawei.com>
References: <54F96F5B.2090601@huawei.com> <54F9DACA.3020103@hurleysoftware.com> <CAD7vxxJXEz8KfXd9fBjkxTi5Nnjyw0=wwvbw5qCSwCMbBd64eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD7vxxJXEz8KfXd9fBjkxTi5Nnjyw0=wwvbw5qCSwCMbBd64eA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Zhang Zhen <zhenzhang.zhang@huawei.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tim Kryger <tim.kryger@linaro.org>, gregkh@linuxfoundation.org, jamie@jamieiles.com, alan@linux.intel.com, arnd@arndb.de, shenjiangjiang@huawei.com, Wang Kai <morgan.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

On 2015/3/7 11:01, Tim Kryger wrote:
> You only hit the silicon bug if you bombard the uart with characters
> and simultaneously request a baud rate or framing change.
>=20
> I'm not sure why you would do either to the uart console.  Is it
> possible your host machine is doing something weird?
>=20
> If you have the leverage, remind the SoC vendor to upgrade the serial
> block.  Synopsys fixed this a long time ago.
>=20
> -Tim

Hi, Tim

thanks for you reply. if we bombard the uart with characters and simult=
aneously
request a baud rate change, we hit the silicon bug.

Our scenario is to do stability testing=EF=BC=88at the system booting, =
we bombard the uart
with characters=EF=BC=89, With this version(v3.0.6) Synopsys Serial,  t=
he expect are
print out the message(Couldn't set LCR to xxxx) and the kernel will not=
 hung.

Maybe the next release of the board we will upgrade the serial block to=
 the new version.
but the issue is that how we circumvent this problem in kernel?

do you have any ideas? thanks.

Best Regards
Wang Long


>=20
> On Fri, Mar 6, 2015 at 8:50 AM, Peter Hurley <peter@hurleysoftware.co=
m> wrote:
>> Hi Zhang,
>>
>> On 03/06/2015 04:11 AM, Zhang Zhen wrote:
>>> Hi,
>>>
>>>       I'm testing 4.0-rc1 kernel on my board with 8250 Designware U=
ART.(ARM Cortex-a15 single core).
>>>
>>>       I found if serial is busy and writes to the LCR failed after =
tried 1000 times.
>>>       The kernel will hung up.
>>>
>>>       The system boot success after changed from:
>>>
>>>  95 static void dw8250_serial_out(struct uart_port *p, int offset, =
int value)
>>>  96 {
>>>  97         struct dw8250_data *d =3D p->private_data;
>>>  98
>>> ...
>>> ...
>>> 112                         writeb(value, p->membase + (UART_LCR <<=
 p->regshift));
>>> 113                 }
>>> 114                 dev_err(p->dev, "Couldn't set LCR to %d\n", val=
ue);
>>> 115         }
>>> 116 }
>>>
>>>       to:
>>>
>>>  95 static void dw8250_serial_out(struct uart_port *p, int offset, =
int value)
>>>  96 {
>>>  97         struct dw8250_data *d =3D p->private_data;
>>>  98
>>> ...
>>> ...
>>> 112                         writeb(value, p->membase + (UART_LCR <<=
 p->regshift));
>>> 113                 }
>>> 114                 dev_info(p->dev, "Couldn't set LCR to %d\n", va=
lue);            //changed here
>>> 115         }
>>> 116 }
>>>
>>>       The reason is serial8250_console_write can't get port->lock b=
ecause serial8250_do_set_termios has
>>>       got port->lock.
>>>       So i think here we should change from dev_err to dev_info ?
>>
>> That's not really going to help because this will still hang if the
>> console_loglevel is set to < KERN_INFO.
>>
>>>       Any suggestions are welcome.
>>
>> Check that the port is not the uart_console() before logging the err=
or,
>> like;
>>
>>         if (!uart_console(p))
>>                 dev_err(p->dev, "Couldn't .....");
>>
>> Use a global flag to note the error and check it from other contexts=
=2E
>> Plus, find out why you can't write LCR there.
>>
>> Also, consider re-designing how the 8250_dw driver implements that
>> "feature".
>>
>> Regards,
>> Peter Hurley
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>=20
> .
>=20
