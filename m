From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
Date: Sun, 01 Feb 2015 22:45:12 -0500
Message-ID: <54CEF2C8.1050808@hurleysoftware.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>	 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>	 <54CE53F3.5040709@hurleysoftware.com> <54CE6FD9.5030606@hurleysoftware.com> <1422846994.5512.25.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1422846994.5512.25.camel@mtksdaap41>
Sender: linux-doc-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 02/01/2015 10:16 PM, Eddie Huang wrote:
> Hi Peter,
> 
> On Sun, 2015-02-01 at 13:26 -0500, Peter Hurley wrote:
>> On 02/01/2015 11:27 AM, Peter Hurley wrote:
>>> Hi Eddie,
>>>
>>> On 01/12/2015 08:08 AM, Eddie Huang wrote:
>>>> Add earlycon support not only baudrate option, but also add noinit option.
>>>> If use noinit option, 8250 earlycon will not init serial hardware and use
>>>> loader setting.
>>>
>>> I see this went into Greg's tty-testing branch.
>>>
>>> The only point of this is to not program the divisor, right?
>>>
>>> I ask because early_serial8250_setup() could already handle this without
>>> extra options by simply not doing divisor programming if no baud option is
>>> present.
>>
>> Does the patch below work for your use-case?
>>
>> [ Note: the patch applies to 3.19-rcX. To test, your noinit patches need to be
>>   reverted first.
>> ]
>>
>> --- >% ---
>> From: Peter Hurley <peter@hurleysoftware.com>
>> Subject: [PATCH] serial: 8250_early: Assume uart already initialized if no
>>  baud option
>>
>> The <baud><parity><bit> option string is not supplied if the earlycon
>> is started via devicetree and OF_EARLYCON_DECLARE(). The option string
>> is also not required if started via kernel command line parameters of
>> the form:
>>   earlycon=uart,mmio,<addr>
>>   console=uart,mmio,<addr>
>>
>> If earlycon_device->baud is 0, then an option string was not supplied.
>> In this case, assume the uart has already been initialized by the
>> bootloader or firmware.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>  drivers/tty/serial/8250/8250_early.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
>> index d7b831b..1701d00 100644
>> --- a/drivers/tty/serial/8250/8250_early.c
>> +++ b/drivers/tty/serial/8250/8250_early.c
>> @@ -149,12 +149,18 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
>>  		return 0;
>>  
>>  	if (!device->baud) {
>> +		struct uart_port *port = &device->port;
>> +		unsigned int ier;
>> +
>>  		device->baud = probe_baud(&device->port);
>>  		snprintf(device->options, sizeof(device->options), "%u",
>>  			 device->baud);
>> -	}
>>  
>> -	init_port(device);
>> +		/* assume the device was initialized, only mask interrupts */
>> +		ier = serial8250_early_in(port, UART_IER);
>> +		serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
>> +	} else
>> +		init_port(device);
> Should add brace in else.

I don't do that unless I have to.

> Where is original line here.
>           early_device = device;

Whoops :)

I wrote the patch from a private branch which implements extensible console
matching (so a console can define its own match function) and a bunch of
other console cleanup and code removal. In that series, early_device becomes
unnecessary and is removed.

I'll respin proper patches on top of Greg's tty-testing branch with reverts
for the noinit options. I noticed that one of the noinit patches actually
has the linkage for the mtk earlycon, so I'll be sure to preserve that.

Regards,
Peter Hurley

