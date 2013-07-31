From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 4/4] serial: sccnxp: Add DT support
Date: Wed, 31 Jul 2013 15:45:06 -0600
Message-ID: <51F98562.9080307@wwwdotorg.org>
References: <1375268145-13393-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41685 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3GaVpL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Jul 2013 17:45:11 -0400
In-Reply-To: <1375268145-13393-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Grant Likely <grant.likely@linaro.org>

On 07/31/2013 04:55 AM, Alexander Shiyan wrote:
> Add DT support to the SCCNCP serial driver.

> diff --git a/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt b/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt


> +Optional properties:

> +- poll-interval: Poll interval time in nanoseconds.

Is this a standard/common property? If not, then it'd be best if the
property name included the vendor-prefix "nxp,".

> +- nxp,sccnxp-io-cfg: Array contains values for the emulated modem signals.
> +  The number of values depends on the UART-number in the selected chip.
> +  Each value should be composed according to the following rules:
> +  (LINE1 << SIGNAL1) | ... | (LINEX << SIGNALX), where:
> +   LINE - VALUE:
> +    OP0 - 1
...
> +    IP6 - 15
> +   SIGNAL - VALUE:
> +    DTR - 0
...
> +    DIR - 24

I wonder that shouldn't be implemented using standard pinctrl bindings.
I could see someone wanting to create a pinmuxing-based serial port
multiplexing device, which would then need to rely on this node acting
as a standard pin controller...

> +Example (Dual UART with direction control on OP0 & OP1):
> +sc2892@10100000 {
> +	compatible = "nxp,sc2892";
> +	reg = <0x10100000 0x10>;
> +	poll-interval = <10000>;
> +	clocks = <&sc2892_clk>;
> +	vcc-supply = <&sc2892_reg>;
> +	nxp,sccnxp-io-cfg = <0x01000000 0x02000000>;

Why two cells for io-cfg when the shifts above imply everything fits
into a single cell?

Oh I guess that "The number of values depends on the UART-number" means
"number of UARTs in the chip", whereas I read it as "the ID of the UART
within the chip"..

When there are multiple UARTs in the chip, should each UART have its own
separate DT node? If not, how could you refer to each individual UART
e.g. in order to set up the /aliases node?
