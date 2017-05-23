From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/4] tty/serial: meson_uart: add support for core clock
 handling
Date: Tue, 23 May 2017 10:37:01 +0200
Message-ID: <81ec5e8e-2cf0-a59c-7355-c64e9f6106d9@baylibre.com>
References: <20170331165437.26227-1-hgkr.klein@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170331165437.26227-1-hgkr.klein@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Helmut Klein <hgkr.klein@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Helmut,


On 03/31/2017 06:54 PM, Helmut Klein wrote:
> To be able to use the three none AO uarts of the meson gx SoCs (uart_A,
> uart_B & uart_C), the core clock has to be enabled (see chapter 22.3 of
> the public s905 data sheet).
> At least the u-boot of my s905 based media player (netxeon minimx-g)
> doesn't do this. so the driver must enable the clock.
> 
> This patch set does:
> - exposes the UART clock ids to the dtb
> - adds documentation for the dt-bindings of meson_uart
> - adds the core clock handling to the driver
> - adds the core clock handling to meson-gxbb.dtsi and meson-gxl.dtsi
> 
> The patchset is based on the branch "master" of the repository in [1]
> 
> Changes since v2
> - mail subjects reworked
> - add clocks/clock-names to the documentation
> - add core clock handling to meson-gxbb.dtsi & meson-gxl.dtsi
> 
> Changes since v1
> - use git to produce the patch set
> - added the clock ids for uart_B and uart_C
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git

I'll take the first patch then I will need to rework your patchset (keeping your
autorship, don't worry) since we need to handle the old bindings.

I'll post it for review when ready.

Anyway, thanks for the patchset.

Neil

> 
> Helmut Klein (4):
>   clk: meson: gxbb: expose CLKID_UARTx
>   dt-bindings: meson_uart: add documentation for meson UARTs
>   tty/serial: meson_uart: add the core clock handling to the driver
>   ARM64: dts: meson-gx: add core clock support for uart_A, uart_B and
>     uart_C
> 
>  .../bindings/serial/amlogic,meson_uart.txt         | 30 ++++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 15 +++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 15 +++++++++++
>  drivers/clk/meson/gxbb.h                           |  6 ++---
>  drivers/tty/serial/meson_uart.c                    | 10 ++++++++
>  include/dt-bindings/clock/gxbb-clkc.h              |  3 +++
>  6 files changed, 76 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt
> 
> --
> 2.11.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
