From: Nathan <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Sun, 30 Oct 2016 10:33:02 -0500
Message-ID: <c73bc50a-51fb-78db-b872-277af3fb06bc@sgi.com>
References: <20161018180518.GA28700@gofer.mess.org>
 <20161018192930.GA207959@stormcage.americas.sgi.com>
 <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org>
 <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161027201916.GA7718@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org



On 10/27/2016 03:19 PM, Sean Young wrote:
> On Wed, Oct 26, 2016 at 01:16:16PM -0500, Nathan Zimmer wrote:
>> On 10/25/2016 03:41 PM, Sean Young wrote:
>>> On Mon, Oct 24, 2016 at 04:49:25PM -0500, Nathan Zimmer wrote:
>>>> [    1.565062] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>>> The isa probe driver find the serial port.
>>>
>>>> [    1.566453] serial 00:04: pnp_assign_resources, try dependent set 0
>>>> [    1.567383] serial 00:04:   couldn't assign io 0 (min 0x2f8 max 0x2f8)
>>> But then decides that the port is already in use (the existing serial driver).
>>>> [    1.568366] serial 00:04: pnp_assign_resources failed (-16)
>>>> [    1.569188] serial 00:04: unable to assign resources
>>>> [    1.569924] serial: probe of 00:04 failed with error -16
>>> Please try and boot 3.7.0 with "8250.share_irqs=1", maybe it will pick
>>> irq 3 and it will be happy again, but that is just a guess.
>>>
>>> I think I have not fully understood what the failure is. Does the serial
>>> port not work or does the boot hang? What are the symptoms?
>> With console=ttyS1 the boot will "hang", sometimes it makes it all the way
>> through but may take 30 minutes, instead of the 2-4 minutes this box
> Where does it hang? Any error messages?
>
>>> We might be able to fix the problem with a pnp quirk but 3.7 is has not had
>>> any releases for a long time. We will need a reproduction on a concurrent
>>> kernel so a patch can be written for that.
>> Yes it still happens with 4.8+
>> I had only started dwelling on 3.6/3.7 since that is where it first appears
>> and don't have any attachment to those.
> Ok. Please try to following patch. I'm not sure it is good enough to be
> merged as-is, but should provide a start for testing. Output with
> CONFIG_PNP_DEBUG_MESSAGES should show only irq 3 is available for the
> serial port now.
>
> Sean
>
>  From 3a1705a2e28f4385b778ad96d7c517b82ea860e2 Mon Sep 17 00:00:00 2001
> From: Sean Young <sean@mess.org>
> Date: Thu, 27 Oct 2016 20:13:50 +0100
> Subject: [PATCH] PNP: Add quirk for BIOS advertising wrong irqs for serial
>   port
>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   drivers/pnp/quirks.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index d28e3ab..8712161 100644
> --- a/drivers/pnp/quirks.c
> +++ b/drivers/pnp/quirks.c
> @@ -66,6 +66,48 @@ static void quirk_awe32_resources(struct pnp_dev *dev)
>   	}
>   }
>   
> +static void quirk_serial_port(struct pnp_dev *dev)
> +{
> +	struct pnp_option *option;
> +	struct pnp_irq *irq;
> +	struct pnp_port *port;
> +
> +	list_for_each_entry(option, &dev->options, list) {
> +		if (!pnp_option_is_dependent(option))
> +			continue;
> +
> +		if (option->type == IORESOURCE_IO) {
> +			port = &option->u.port;
> +
> +			if (port->min != 0x2f8 || port->max != 0x2f8 ||
> +				port->size != 8 || port->align != 1)
> +				return;
> +		} else if (option->type == IORESOURCE_IRQ) {
> +			pnp_irq_mask_t map;
> +
> +			irq = &option->u.irq;
> +
> +			bitmap_zero(map.bits, PNP_IRQ_NR);
> +			__set_bit(3, map.bits);
> +			__set_bit(4, map.bits);
> +			__set_bit(5, map.bits);
> +			__set_bit(6, map.bits);
> +			__set_bit(7, map.bits);
> +			__set_bit(10, map.bits);
> +			__set_bit(11, map.bits);
> +			__set_bit(12, map.bits);
> +
> +			if (!bitmap_equal(map.bits, irq->map.bits, PNP_IRQ_NR))
> +				return;
> +		}
> +	}
> +
> +	if (irq && port) {
> +		bitmap_zero(irq->map.bits, PNP_IRQ_NR);
> +		__set_bit(3, irq->map.bits);
> +	}
> +}
> +
>   static void quirk_cmi8330_resources(struct pnp_dev *dev)
>   {
>   	struct pnp_option *option;
> @@ -448,6 +490,7 @@ static struct pnp_fixup pnp_fixups[] = {
>   #ifdef CONFIG_PCI
>   	{"PNP0c02", quirk_intel_mch},
>   #endif
> +	{"PNP0c02", quirk_serial_port},
>   	{""}
>   };
>   

I think this should be PNP0501 instead of PNP0c02.
Once I alter that then when I boot the serial comes up on irq 3. However 
it still hangs.
I'll keep digging.
