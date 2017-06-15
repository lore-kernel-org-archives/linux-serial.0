From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC 0/4] serdev GPIO-based multiplexing support
Date: Thu, 15 Jun 2017 09:07:28 +0200
Message-ID: <2dc9011f-1a48-1f57-c411-d010fa6a8146@axentia.se>
References: <1497451130-7741-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1497451130-7741-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, robh@kernel.org, linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2017-06-14 16:38, Ulrich Hecht wrote:
> Hi!
> 
> This is an attempt to add multiplexer support to serdev, specifically
> GPIO-based multiplexing.
> 
> Our use case is the Renesas Blanche V2H board with several MAX9260 GMSL
> deserializers attached to one serial port. A sample driver that implements
> i2c passthrough over the GMSL link is part of this series. This device
> wants to be talked to with even parity, so a patch implementing parity
> control in serdev is included as well.
> 
> The board-specific part of this series depends on the "pinctrl: sh-pfc:
> r8a7792: Add SCIF1 pin groups" patch.
> 
> Please tell me if this is a suitable way to implement this functionality
> in serdev, or how to improve it. Thank you.

When I look at patch 2/4, I can't help but think that you should perhaps
consider the new mux framework available in linux-next [1]. But as the
author of that, I'm maybe biased...

You then support other means of controlling the mux automatically (i.e.
you get free support for non-gpio muxes). You also get support for
sharing the mux controller should the same gpio pins control muxes
for unrelated functions (which happened for my hw).

However, I see that you request the gpios when you select the mux, and
free them when you deselect it. That is not how the gpio mux in the
mux framework operates; it instead keeps the gpios requested and either
leaves the gpios as-is on deselect or sets a specific idle value. But
that is perhaps ok for this use-case too?

Cheers,
peda

[1] https://lkml.org/lkml/2017/5/14/160

> CU
> Uli
> 
> 
> Ulrich Hecht (4):
>   serdev: add method to set parity
>   serdev: add GPIO-based multiplexer support
>   max9260: add driver for i2c over GMSL passthrough
>   ARM: dts: blanche: add SCIF1 and MAX9260 deserializer
> 
>  arch/arm/boot/dts/r8a7792-blanche.dts |  45 ++++++
>  drivers/media/i2c/Kconfig             |   6 +
>  drivers/media/i2c/Makefile            |   1 +
>  drivers/media/i2c/max9260.c           | 294 ++++++++++++++++++++++++++++++++++
>  drivers/tty/serdev/Kconfig            |   3 +
>  drivers/tty/serdev/Makefile           |   1 +
>  drivers/tty/serdev/core.c             |  55 ++++++-
>  drivers/tty/serdev/mux-gpio.c         |  80 +++++++++
>  drivers/tty/serdev/serdev-ttyport.c   |  17 ++
>  include/linux/serdev.h                |  30 +++-
>  10 files changed, 528 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/media/i2c/max9260.c
>  create mode 100644 drivers/tty/serdev/mux-gpio.c
> 
