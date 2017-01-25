From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/8] serial: st-asc: Allow handling of RTS line
Date: Wed, 25 Jan 2017 11:07:22 +0100
Message-ID: <20170125100722.GB17954@kroah.com>
References: <20170124134310.27512-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124134310.27512-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 24, 2017 at 01:43:02PM +0000, Lee Jones wrote:
> When hardware flow-control is disabled, manual toggling of the UART's
> reset line (RTS) using userland applications (e.g. stty) is not
> possible, since the ASC IP does not provide this functionality in the
> same was as some other IPs do.  Thus, we have to do this manually.
> 
> This set ensures the correct Pinctrl groups are configured and
> obtained for both manual toggling of the RTS line and for the IP to
> take over the lines when HW flow-control is requested by the user.
> 
> Lee Jones (8):
>   serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
>   serial: st-asc: Provide RTS functionality
>   serial: st-asc: Read in all Pinctrl states
>   serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
>   ARM: dts: STiH410-b2260: Identify the UART RTS line
>   ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
>   ARM: dts: STiH407-family: Use new Pinctrl groups
>   ARM: dts: STiH407-family: Enable HW flow-control
> 
>  arch/arm/boot/dts/stih407-family.dtsi  |  7 +--
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 12 ++++-
>  arch/arm/boot/dts/stih410-b2260.dts    |  1 +
>  drivers/tty/serial/st-asc.c            | 98 +++++++++++++++++++++++++++++++---
>  4 files changed, 105 insertions(+), 13 deletions(-)
> 
> -- 
> 2.10.2

I'll ignore this series due to the kbuild problems :(
