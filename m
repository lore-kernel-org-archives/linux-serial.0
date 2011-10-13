From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH] tty/serial: Prevent drop of DCD on suspend for Tegra
 UARTs
Date: Thu, 13 Oct 2011 10:57:59 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A0C6@HQMAIL01.nvidia.com>
References: <1318377943-24519-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318377943-24519-1-git-send-email-dianders@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jiri Slaby <jirislaby@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Allen Martin <AMartin@nvidia.com>, Tom Warren <TWarren@nvidia.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Doug Anderson wrote at Tuesday, October 11, 2011 6:06 PM:
> On Tegra UARTs (except UART1), the DTR / DCD / DSR lines are not
> externally accessible.  Instead, the DTR line internally appears to be
> looped back to be the input to the DCD and DSR lines.  The net effect
> of this is that when we drop DTR (like when we suspend), we'll see DCD
> drop too.  ...and when we see DCD drop, we treat that as a hangup.
> 
> In order to prevent this hangup from occurring at every sleep, we need
> to force DTR to remain high on Tegra UARTs.
> 
> This patch uses the mcr_mask / mcr_force fields, which were originally
> added for the kludge ALPHA_KLUDGE_MCR.  Using these fields does not
> prevent us from removing ALPHA_KLUDGE_MCR--we can just remove the "if"
> tests I have added and always init mcr_mask / mcr_force from the
> serial8250_config.
> 
> NOTE: If we have people that are using UARTA on a Tegra and need to
> control DTR, we'll need to either add a separate port type for UARTA
> or we'll need to add some tegra-specific code to detect whether the
> DTR needs to be left high.

I did some research on the HW, and here's how everything is hooked up
in Tegra20 and Tegra30. Later chips may have this fixed, or at least
configurable; I don't know the details yet.

All 5 UARTs support the modem signals in the HW block.

In UART A, you can mux the modem signals out using the pinmux. If the
pinmux /doesn't/ route the signals out, the DSR and DCD signals are tied
to an /active/ state.

In UART B, the DTR output is indeed wired back into the DSR and DCD
inputs, as you discovered.

In UARTs C, D, and E, the DSR and DCD signals are tied to an /inactive/
state.

So, I think this particular WAR is only needed on UART B.

-- 
nvpublic
