From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v4 11/11] serial: 8250_omap: Add omap8250 earlycon
Date: Wed, 13 Jan 2016 09:06:15 -0800
Message-ID: <56968407.7090500@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
 <1452627672-9482-12-git-send-email-peter@hurleysoftware.com>
 <56955941.1080701@hurleysoftware.com> <569616B9.1090504@nvidia.com>
 <5696224F.7050907@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5696224F.7050907@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Sebastian Frias <sf84@laposte.net>, Paul Burton <paul.burton@imgtec.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

Hi Jon,

On 01/13/2016 02:09 AM, Jon Hunter wrote:
> On 13/01/16 09:19, Jon Hunter wrote:
>> On 12/01/16 19:51, Peter Hurley wrote:
>>> Wasn't planning on sending this patch just yet, but oh well.
>>>
>>> On 01/12/2016 11:41 AM, Peter Hurley wrote:
>>>> Add DT earlycon for 8250_omap driver. This boot console is included
>>>> for kernels built with CONFIG_SERIAL_EARLYCON=y, CONFIG_OF=y,
>>>> CONFIG_SERIAL_8250_OMAP=y, and CONFIG_OF_EARLY_FLATTREE=y.
>>>>
>>>> This boot console is enabled with the command line option "earlycon"
>>>> (without "=<name>...") when the DT 'stdout-path' property matches a
>>>> compatible uart. For example,
>>>>
>>>> / {
>>>>    chosen {
>>>>         stdout-path = "serial0:115200";
>>>>    };
>>>>
>>>>    ....
>>>>
>>>>    aliases {
>>>>         serial0 = &uart0;
>>>>    };
>>>>
>>>>    ....
>>>>
>>>>    ocp : ocp {
>>>>         uart0 : serial@44e09000 {
>>>>              compatible = "ti,omap3-uart";
>>>>         }
>>>>    };
>>>> };
>>>>
>>>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>>>> ---
>>>>  drivers/tty/serial/8250/8250_early.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
>>>> index e7cdc0c..d1f6310 100644
>>>> --- a/drivers/tty/serial/8250/8250_early.c
>>>> +++ b/drivers/tty/serial/8250/8250_early.c
>>>> @@ -201,3 +201,23 @@ EARLYCON_DECLARE(rt288x, early_rt288x_setup);
>>>>  OF_EARLYCON_DECLARE(rt288x, "ralink,rt2880-uart", early_rt288x_setup);
>>>>  
>>>>  #endif /* CONFIG_SERIAL_8250_RT288X */
>>>
>>> This patch may not apply because the context is sitting on top of
>>> unsubmitted code. Sorry.
>>>
>>> Regards,
>>> Peter Hurley
>>>
>>>> +
>>>> +#ifdef CONFIG_SERIAL_8250_OMAP
>>>> +
>>>> +static int __init early_omap8250_setup(struct earlycon_device *device,
>>>> +				       const char *options)
>>>> +{
>>>> +	struct uart_port *port = &device->port;
>>>> +
>>>> +	if (!(device->port.membase || device->port.iobase))
>>>> +		return -ENODEV;
>>>> +
>>>> +	port->regshift = 2;
>>>> +	device->con->write = early_serial8250_write;
>>>> +	return 0;
>>>> +}
>>
>> I see you did not mean to send this out, but would the above still be
>> necessary with my patch [0]? I am wondering if with my patch you can
>> just add the below OF_EARLYCON_DECLARE() for OMAP?
> 
> Sorry, I see that you have also already made the changes I have in patch
> [0]. However, still curious why you need the above for OMAP?

Yeah, sorry about trouncing your patches.

I let that series from the beginning of last year stall after writing the
dtc compiler patch waiting for the kernel libfdt copy to catch up, and
then forgot about it, until the flood of recent earlycon patches.

Since it rebased (and retested) fairly trivially, I thought I'd just
push it out again.

The reason the omap8250 earlycon needs the regshift init is that the
omap uart DT nodes don't adequately describe the register layout; the
8250_omap sub-driver handles the uart port initialization (iow, it
doesn't use the 8250_of properties to describe i/o register access).
This situation is an artifact of the original omap uart driver,
omap-serial.c

For regular 8250 DT nodes, the only requirement should be the
OF_EARLYCON_DECLARE() to associate the compatible string with
early_serial8250_setup() (and a unique earlycon name such as the one
you already used).

NB: You should be able to re-use the earlycon name itself when
declaring new OF earlycons now. IOW,

OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);

should work. And this will keep the proliferation of command line
options to a minimum.

Please let me know if that doesn't work.

Regards,
Peter Hurley


> Jon
> 
> [0] http://marc.info/?l=linux-serial&m=145259482325332&w=2
> 
