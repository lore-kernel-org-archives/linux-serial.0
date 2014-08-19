From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v9 12/16] serial: amba-pl011: Pass FIQ information to
 KGDB.
Date: Tue, 19 Aug 2014 13:51:53 +0100
Message-ID: <53F34869.7050901@linaro.org>
References: <1404979427-12943-1-git-send-email-daniel.thompson@linaro.org> <1408372091-12689-13-git-send-email-daniel.thompson@linaro.org> <53F24660.2030404@hurleysoftware.com> <53F313F2.6090103@linaro.org> <53F33BDD.8050705@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53F33BDD.8050705@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgdb-bugreport@lists.sourceforge.net, patches@linaro.org, linaro-kernel@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Colin Cross <ccross@android.com>, kernel-team@android.com, Rob Herring <robherring2@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <Dave.Martin@arm.com>, Fabio Estevam <festevam@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Nicolas Pitre <nico@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 19/08/14 12:58, Peter Hurley wrote:
> On 08/19/2014 05:08 AM, Daniel Thompson wrote:
>> On 18/08/14 19:30, Peter Hurley wrote:
> 
> [cut]
>   
>>>> +static int pl011_poll_init(struct uart_port *port)
>>>> +{
>>>> +	struct uart_amba_port *uap = (struct uart_amba_port *)port;
>>>
>>> Please use container_of() in new code.
>>
>> Ok.
>>
>> Personally I dislike a file that mixes casts and conatiner_of but I
>> guess I can make both of us happy by switching the whole driver to
>> container_of. Separate patch again?
> 
> The change below makes the uap local unnecessary, so you can skip the
> container_of() change, if you'd prefer.

I realized that myself although not until after I'd replaced all the
casts with container_of()...

So I'll keep the patch for now but can drop it if anyone takes against it.



Thanks

Daniel.




> 
>>>> +	int retval;
>>>> +
>>>> +	retval = pl011_hwinit(port);
>>>> +
>>>> +#ifdef CONFIG_KGDB_FIQ
>>>> +	if (retval == 0)
>>>> +		kgdb_register_fiq(uap->port.irq);
>>>
>>> The uap->port dereference is unnecessary since the port parameter
>>> is the same thing.
>>>
>>> 		kgdb_register_fiq(port->irq);
>>
>> Ok.
> 
> Thanks,
> Peter Hurley
> 
