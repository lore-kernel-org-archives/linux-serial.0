From: Maarten Brock <m.brock@vanmierlo.com>
Subject: Re: [RFC PATCH 0/3] serial: uartps: Add run time support for more IPs
 than hardcoded 2
Date: Sat, 05 May 2018 15:10:35 +0200
Message-ID: <1d3bc2082972bb1d4abc2c15db396257@vanmierlo.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: gnomes@lxorguk.ukuu.org.uk, monstr@monstr.eu, linux-serial-owner@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2018-04-26 16:08, Michal Simek wrote:
> Hi,
> 
> this series is trying to address discussion I had with Alan in past
> https://patchwork.kernel.org/patch/9738445/.
> 
> It is moving uart_register_driver() to probe function like it is done 
> in
> pl011 driver.
> And also introducing new function for alias compatibility checking to
> resolve cases where some IPs have alias and some of them not.
> This case is detected in pl011_probe_dt_alias() but not properly 
> solved.
> 
> Also keep status of free ids/minor numbers in bitmap to know what's the
> next unallocated number.
> 
> The same solution can be used in pl011, uart16550 and uartlite to 
> really
> get unified kernel.
> 
> Tested on these use cases:
> Notes:
> ff000000 is the first PS uart listed in dtsi
> ff010000 is the second PS uart listed in dtsi
> 
> Standard zcu102 setting
> 		serial0 = &uart0;
> 		serial1 = &uart1;
> [    0.196628] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.642542] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> Swapped zcu102 setting
> 		serial0 = &uart1;
> 		serial1 = &uart0;
> [    0.196472] ff000000.serial: ttyPS1 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.196824] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> uart0 on alias higher then MAX uart ports
> 		serial0 = &uart1;
> 		serial200 = &uart0;
> [    0.176793] ff000000.serial: ttyPS200 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.177288] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> Both uarts on higher aliases
> 		serial1 = &uart1;
> 		serial2 = &uart0;
> [    0.196470] ff000000.serial: ttyPS2 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.196823] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> uart0 not listed but it is probed first that's why should be ttyPS0 but
> there is uart1 via alias
> 		serial0 = &uart1;
> [    0.176656] xuartps ff000000.serial: No serial alias passed. Using
> the first free id
> [    0.176671] xuartps ff000000.serial: Validate id 0
> [    0.176680] xuartps ff000000.serial: The empty id is 0
> [    0.176692] xuartps ff000000.serial: ID 0 already taken - skipped
> [    0.176701] xuartps ff000000.serial: Validate id 1
> [    0.176710] xuartps ff000000.serial: The empty id is 1
> [    0.176719] xuartps ff000000.serial: Selected ID 1 allocation passed
> [    0.176760] ff000000.serial: ttyPS1 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.177104] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> uart0 not listed but it is probed first that's why should be ttyPS0
> 		serial1 = &uart1;
> [    0.176661] xuartps ff000000.serial: No serial alias passed. Using
> the first free id
> [    0.176676] xuartps ff000000.serial: Validate id 0
> [    0.176686] xuartps ff000000.serial: The empty id is 0
> [    0.176696] xuartps ff000000.serial: Selected ID 0 allocation passed
> [    0.176737] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.177069] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> uarts not listed in aliases list
> [    0.176673] xuartps ff000000.serial: No serial alias passed. Using
> the first free id
> [    0.176687] xuartps ff000000.serial: Validate id 0
> [    0.176697] xuartps ff000000.serial: The empty id is 0
> [    0.176707] xuartps ff000000.serial: Selected ID 0 allocation passed
> [    0.176746] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.177057] xuartps ff010000.serial: No serial alias passed. Using
> the first free id
> [    0.177070] xuartps ff010000.serial: Validate id 0
> [    0.177079] xuartps ff010000.serial: The empty id is 0
> [    0.177089] xuartps ff010000.serial: Selected ID 0 allocation failed
> [    0.177098] xuartps ff010000.serial: Validate id 1
> [    0.177107] xuartps ff010000.serial: The empty id is 1
> [    0.177116] xuartps ff010000.serial: Selected ID 1 allocation passed
> [    0.177149] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> Thanks,
> Michal

Hello Michal,

How will this interact with ns16550 based UARTs?

Can we have both /dev/ttyS0 and /dev/ttyPS0?
Currently we can't unless we create *no* serialN alias for the ns16550.
And there is no other means to lock the /dev/ttySx name to a device 
either.

Or will the xuartps driver eventually use /dev/ttySx as well?

Maarten
