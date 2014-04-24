From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Date: Fri, 25 Apr 2014 01:33:29 +0200
Message-ID: <1418731.YSFS18bIMD@avalon>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:36036 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaDXXdU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Apr 2014 19:33:20 -0400
In-Reply-To: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Simon,

Thank you for the patch.

On Thursday 24 April 2014 15:54:44 Simon Horman wrote:
> According to the platform data for the legacy-C initialisation of sh-sci
> for the r8a7779 SoC and my own testing the SCIx_SH4_SCIF_REGTYPE bit of
> scscr needs to be set.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> With the approach taken by this patch sh-sci may be initialised using the
> "renesas,scif-r8a7779" compat string but not the generic "renesas,scif"
> compat string.  An alternate approach would be to add a binding to allow
> setting of this bit to be controlled directly from DT.

Handling the SCSCR bits properly with DT has been on my to-do list for some 
time. Thank you for volunteering to implement that :-D

The CKE bits control both the behaviour of the SCK pin and the SCIF input 
clock selection. The SCIF can use various internal and external clocks, with 
up to two baud rate generators (programmable dividers) chained. Whether the 
SoC is provided with an external clock for its serial ports is a board 
property, not an SoC property. I would thus like to implement support for this 
feature properly and avoid hardcoding the CKE bits like done below.

The Marzen board has an external clock generator connected to the SCIF_SCK pin 
that can be used as a clock source, but I don't really see a reason why we 
couldn't use the internal P clock instead. I don't want to delay integration 
of SCIF DT support until we have a proper solution to handle clock 
configuration, but couldn't we use the internal P clock on the Marzen board in 
the meantime ?

> ---
>  .../devicetree/bindings/serial/renesas,sci-serial.txt      |  1 +
>  drivers/tty/serial/sh-sci.c                                | 10  +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt index
> 53e6c17..bba86de 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -12,6 +12,7 @@ Required properties:
>      - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
> - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART. -
> "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART. +   
> - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART. -
> "renesas,scif" for generic SCIF compatible UART.
>      - "renesas,scifa" for generic SCIFA compatible UART.
>      - "renesas,scifb" for generic SCIFB compatible UART.
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 88236da..3b5d2f6 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2419,6 +2419,7 @@ static int sci_remove(struct platform_device *dev)
>  struct sci_port_info {
>  	unsigned int type;
>  	unsigned int regtype;
> +	unsigned int scscr_extra;
>  };
> 
>  static const struct of_device_id of_sci_match[] = {
> @@ -2429,6 +2430,13 @@ static const struct of_device_id of_sci_match[] = {
>  			.regtype = SCIx_SH4_SCIF_REGTYPE,
>  		},
>  	}, {
> +		.compatible = "renesas,scif-r8a7779",
> +		.data = (void *)&(const struct sci_port_info) {
> +			.type = PORT_SCIF,
> +			.regtype = SCIx_SH4_SCIF_REGTYPE,
> +			.scscr_extra = SCSCR_CKE1,
> +		},
> +	}, {
>  		.compatible = "renesas,scifa",
>  		.data = &(const struct sci_port_info) {
>  			.type = PORT_SCIFA,
> @@ -2488,7 +2496,7 @@ sci_parse_dt(struct platform_device *pdev, unsigned
> int *dev_id) p->flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
>  	p->type = info->type;
>  	p->regtype = info->regtype;
> -	p->scscr = SCSCR_RE | SCSCR_TE;
> +	p->scscr = SCSCR_RE | SCSCR_TE | info->scscr_extra;
> 
>  	return p;
>  }

-- 
Regards,

Laurent Pinchart

