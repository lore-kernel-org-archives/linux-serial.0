From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH -next 00/12] OF earlycon cleanup
Date: Wed, 04 Mar 2015 12:33:45 -0500
Message-ID: <54F741F9.7070308@hurleysoftware.com>
References: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/04/2015 12:24 PM, Peter Hurley wrote:
> Hi Greg, Grant & Rob,
> 
> This patch series builds on my earlier "Extensible console matching &
> direct earlycon" to add several useful features to earlycon:
> * Proper port i/o configuration from DT node with of_serial properties
>   (such as reg-io-width, reg-shift and reg-offset)
> * Proper console name & index initialization from earlycon name
>   (for both command line and DT-defined earlycons)
> * Support for DT 'stdout-path' options pass-through to earlycon setup
> * Improved log messages for troubleshooting
> * Support for multiple OF earlycon declarations so different
>   compatible strings can specify the same OF earlycon
> 
> Lastly, this patch series adds an omap8250 OF earlycon. I don't think
> the last patch requires the "Split 8250 driver" to work but it won't
> apply cleanly without it.
> 
> Requires: "libfdt: Teach fdt_path_offset() about ':' path separator"

I forgot to mention that the last patch which adds omap8250 earlycon
requires some kind of fixmap support, such as "ARM: early fixmap support
for earlycon", which has not yet been accepted upstream.


> Regards
> 
> Peter Hurley (12):
>   serial: earlycon: Fixup earlycon console name and index
>   serial: earlycon: Emit earlycon name in the OF table
>   of: earlycon: Fixup earlycon console name and index
>   of: earlycon: Add options string handling
>   of: earlycon: Initialize port fields from DT properties
>   of: earlycon: Move address translation to of_setup_earlycon()
>   serial: earlycon: Common log banner for command line and DT
>   serial: earlycon: Id the earlycon "driver" in banner
>   of: earlycon: Allow multiple OF_EARLYCON_DECLARE() with same name
>   of: earlycon: Log more helpful message if earlycon not found
>   serial: 8250_early: Use port->regshift
>   serial: 8250_omap: Add omap8250 earlycon
> 
>  drivers/of/fdt.c                     | 16 +++---
>  drivers/of/fdt_address.c             | 11 ++++-
>  drivers/tty/serial/8250/8250_early.c | 29 ++++++++++-
>  drivers/tty/serial/earlycon.c        | 94 +++++++++++++++++++++++++++++-------
>  include/linux/of_fdt.h               |  2 +-
>  include/linux/serial_core.h          | 20 ++++++--
>  6 files changed, 138 insertions(+), 34 deletions(-)
> 
