From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/4] serial: sccnxp: Add DT support
Date: Thu, 1 Aug 2013 10:54:06 +0100
Message-ID: <20130801095406.GD26420@e106331-lin.cambridge.arm.com>
References: <1375268145-13393-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38559 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753943Ab3HAJyV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Aug 2013 05:54:21 -0400
Content-Disposition: inline
In-Reply-To: <1375268145-13393-1-git-send-email-shc_work@mail.ru>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>

On Wed, Jul 31, 2013 at 11:55:45AM +0100, Alexander Shiyan wrote:
> Add DT support to the SCCNCP serial driver.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../bindings/tty/serial/sccnxp-serial.txt          | 53 ++++++++++++++++++++++
>  drivers/tty/serial/sccnxp.c                        | 46 +++++++++++++++----
>  include/linux/platform_data/serial-sccnxp.h        |  6 +--
>  3 files changed, 93 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt b/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
> new file mode 100644
> index 0000000..d18b169
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
> @@ -0,0 +1,53 @@
> +* NXP (Philips) SCC+++(SCN+++) serial driver
> +
> +Required properties:
> +- compatible: Should be "nxp,<ictype>". The supported ICs include sc2681,
> +  sc2691, sc2692, sc2891, sc2892, sc28202, sc68681 and sc68692.
> +- reg: Address and length of the register set for the device.
> +- interrupts: Should contain the interrupt number. If omitted,
> +  polling mode will be used instead, so "poll-interval" property should
> +  be populated in this case.

I'm not so keen on bindings describing what drivers *will* do (as
opposed to what they *may* do), but many other bindings already describe
this. It feels like we're describing driver behaviour rather than
describing the hardware and letting a driver try its best to use the
hardware in whatever way it sees fit.

I'm not sure how others feel on this, but I'd prefer a description more
like:

- interrupts: Should contain the interrupt number. If omitted, a driver
  may poll the device, so the "poll-interval" property should be
  populated.

> +
> +Optional properties:
> +- clocks: Phandle to input clock. If omitted, default IC frequency will be
> +  used instead.
> +- poll-interval: Poll interval time in nanoseconds.

Is there any reason this needs to be described at all? Is this interval
a minimum/maximum bound required for some reason, or just a sensible
value?

This feels like driver configuration than hardware description.

> +- vcc-supply: The regulator supplying the VCC to drive the chip.
> +- nxp,sccnxp-io-cfg: Array contains values for the emulated modem signals.
> +  The number of values depends on the UART-number in the selected chip.
> +  Each value should be composed according to the following rules:
> +  (LINE1 << SIGNAL1) | ... | (LINEX << SIGNALX), where:
> +   LINE - VALUE:
> +    OP0 - 1
> +    OP1 - 2
> +    OP2 - 3
> +    OP3 - 4
> +    OP4 - 5
> +    OP5 - 6
> +    OP6 - 7
> +    OP7 - 8
> +    IP0 - 9
> +    IP1 - 10
> +    IP2 - 11
> +    IP3 - 12
> +    IP4 - 13
> +    IP5 - 14
> +    IP6 - 15
> +   SIGNAL - VALUE:
> +    DTR - 0
> +    RTS - 4
> +    DSR - 8
> +    CTS - 12
> +    DCD - 16
> +    RNG - 20
> +    DIR - 24

I don't really understand what this is describing, but I'm not sure that
the encoding (with an OR of shifted values) is the most sensible. Could
you elaborate on what is being described and how it's used?

Thanks,
Mark.
