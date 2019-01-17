From: Darwin Dingel <Darwin.Dingel@alliedtelesis.co.nz>
Subject: Re: [PATCH] serial: 8250: Fix serial8250 initialization crash
Date: Thu, 17 Jan 2019 20:06:15 +0000
Message-ID: <1fcc3761e9f34254a25602002f65773a@svr-chch-ex1.atlnz.lc>
References: <1547715619-181299-1-git-send-email-zhe.he@windriver.com>
 <41c574bfdce7490597079dae8f328661@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "zhe.he@windriver.com" <zhe.he@windriver.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "colin.king@canonical.com" <colin.king@canonical.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
List-Id: linux-serial@vger.kernel.org

On 18/01/19 8:49 AM, Darwin Dingel wrote:=0A=
> On 17/01/19 10:00 PM, zhe.he@windriver.com wrote:=0A=
>> From: He Zhe <zhe.he@windriver.com>=0A=
>>=0A=
>> The initialization code of interrupt backoff work might reference NULL=
=0A=
>> pointer and cause the following crash, if no port was found.=0A=
>>=0A=
>> [   10.017727] CPU 0 Unable to handle kernel paging request at virtual a=
ddress 000001b0, epc =3D=3D 807088e0, ra =3D=3D 8070863c=0A=
>> ---- snip ----=0A=
>> [   11.704470] [<807088e0>] serial8250_register_8250_port+0x318/0x4ac=0A=
>> [   11.747251] [<80708d74>] serial8250_probe+0x148/0x1c0=0A=
>> [   11.789301] [<80728450>] platform_drv_probe+0x40/0x94=0A=
>> [   11.830515] [<807264f8>] really_probe+0xf8/0x318=0A=
>> [   11.870876] [<80726b7c>] __driver_attach+0x110/0x12c=0A=
>> [   11.910960] [<80724374>] bus_for_each_dev+0x78/0xcc=0A=
>> [   11.951134] [<80725958>] bus_add_driver+0x200/0x234=0A=
>> [   11.989756] [<807273d8>] driver_register+0x84/0x148=0A=
>> [   12.029832] [<80d72f84>] serial8250_init+0x138/0x198=0A=
>> [   12.070447] [<80100e6c>] do_one_initcall+0x5c/0x2a0=0A=
>> [   12.110104] [<80d3a208>] kernel_init_freeable+0x370/0x484=0A=
>> [   12.150722] [<80a49420>] kernel_init+0x10/0xf8=0A=
>> [   12.191517] [<8010756c>] ret_from_kernel_thread+0x14/0x1c=0A=
>>=0A=
>> This patch makes sure the initialization code can be reached only if a p=
ort=0A=
>> is found.=0A=
>>=0A=
>> Fixes: commit 6d7f677a2afa ("serial: 8250: Rate limit serial port rx int=
errupts during input overruns")=0A=
>> Signed-off-by: He Zhe <zhe.he@windriver.com>=0A=
>> ---=0A=
>>    drivers/tty/serial/8250/8250_core.c | 17 +++++++++--------=0A=
>>    1 file changed, 9 insertions(+), 8 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/82=
50/8250_core.c=0A=
>> index 189ab12..e441221 100644=0A=
>> --- a/drivers/tty/serial/8250/8250_core.c=0A=
>> +++ b/drivers/tty/serial/8250/8250_core.c=0A=
>> @@ -1070,15 +1070,16 @@ int serial8250_register_8250_port(struct uart_82=
50_port *up)=0A=
>>    =0A=
>>    			ret =3D 0;=0A=
>>    		}=0A=
>> -	}=0A=
>>    =0A=
>> -	/* Initialise interrupt backoff work if required */=0A=
>> -	if (up->overrun_backoff_time_ms > 0) {=0A=
>> -		uart->overrun_backoff_time_ms =3D up->overrun_backoff_time_ms;=0A=
>> -		INIT_DELAYED_WORK(&uart->overrun_backoff,=0A=
>> -				  serial_8250_overrun_backoff_work);=0A=
>> -	} else {=0A=
>> -		uart->overrun_backoff_time_ms =3D 0;=0A=
>> +		/* Initialise interrupt backoff work if required */=0A=
>> +		if (up->overrun_backoff_time_ms > 0) {=0A=
>> +			uart->overrun_backoff_time_ms =3D=0A=
>> +				up->overrun_backoff_time_ms;=0A=
>> +			INIT_DELAYED_WORK(&uart->overrun_backoff,=0A=
>> +					serial_8250_overrun_backoff_work);=0A=
>> +		} else {=0A=
>> +			uart->overrun_backoff_time_ms =3D 0;=0A=
>> +		}=0A=
>>    	}=0A=
>>    =0A=
>>    	mutex_unlock(&serial_mutex);=0A=
>>=0A=
> =0A=
> Reviewed-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>=0A=
> =0A=
> I presume this is the same issue reported here:=0A=
> =0A=
> https://www.spinics.net/lists/linux-serial/msg33114.html=0A=
> https://lkml.org/lkml/2018/12/22/171=0A=
> =0A=
> =0A=
> =0A=
> Thanks!=0A=
> Regards,=0A=
> =0A=
> Darwin=0A=
> =0A=
=0A=
Adding Colin and Dan.=0A=
=0A=
Regards,=0A=
Darwin=0A=
