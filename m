From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [v3 3/3] serial: 8250_dw: Add UPF_SKIP_TEST to flags depend on
 device tree
Date: Wed, 12 Aug 2015 09:16:48 -0400
Message-ID: <55CB4740.7070703@hurleysoftware.com>
References: <1437886478-29273-1-git-send-email-noamc@ezchip.com> <1439378312-6463-1-git-send-email-noamc@ezchip.com> <1439378312-6463-2-git-send-email-noamc@ezchip.com> <1439378312-6463-3-git-send-email-noamc@ezchip.com> <1439378312-6463-4-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439378312-6463-4-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, @codeaurora.orggalak@codeaurora.org, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com
List-Id: linux-serial@vger.kernel.org

Hi Noam,

On 08/12/2015 07:18 AM, Noam Camus wrote:
> From: Noam Camus <noamc@ezchip.com>
> 
> Add support for OF option "no-loopback-test"
> 
> use case: simulator which does not implements loopback test mode.

I think Greg's question about the simulator still applies: why upstream this?
The simulator is not even identified so how is someone supposed to know
this workaround applies?

The fact there are no in-tree DT users of this workaround argues against
its acceptance.

Regards,
Peter Hurley


> Signed-off-by: Noam Camus <noamc@ezchip.com>
> ---
>  .../bindings/serial/snps-dw-apb-uart.txt           |    2 ++
>  drivers/tty/serial/8250/8250_dw.c                  |    3 +++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
> index 289c40e..5d16047 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
> @@ -33,6 +33,8 @@ Optional properties:
>  - ri-override : Override the RI modem status signal. This signal will always be
>    reported as inactive instead of being obtained from the modem status register.
>    Define this if your serial port does not use this pin.
> +- no-loopback-test: set to indicate that the port does not implements loopback
> +  test mode
>  
>  Example:
>  
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 62f766a..0f397ae 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -394,6 +394,9 @@ static int dw8250_probe_of(struct uart_port *p,
>  		up->dma->txconf.dst_maxburst = p->fifosize / 4;
>  	}
>  
> +	if (of_find_property(np, "no-loopback-test", NULL))
> +		p->flags |= UPF_SKIP_TEST;
> +
>  	if (!of_property_read_u32(np, "reg-shift", &val))
>  		p->regshift = val;
>  
> 
