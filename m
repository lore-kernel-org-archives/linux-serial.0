From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v5 0/4] tty/serial: meson_uart: add support for core clock
 handling
Date: Mon, 19 Jun 2017 10:43:05 +0200
Message-ID: <f4179b26-54fc-30ee-2d8d-7659349ccb74@baylibre.com>
References: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, khilman@baylibre.com
Cc: hgkr.klein@gmail.com, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/14/2017 10:29 AM, Neil Armstrong wrote:
> This patchset is a re-spin of Helmut Klein's v3 patchset at [0] and the v4 patchset at [1].
> 
> Initially, the original patchset was made to enable usage on the non-AO UARTS
> not enabled by the Bootloader (uart_B and uart_C), but the patchset needed
> an overall change to have clean and stable DT bindings.
> 
> The Amlogic Meson UART Driver did not have stable DT bindings and mismatched
> clock handling on non-AO UARTs since these "EE" UARTs needs a clock gate to
> be ungated to works correctly.
> In the same way, the AO UARTs does not need gating and can be used as
> Early Consoles.
> 
> In the same time, the UART Interfaces can take clock input for the baudrate
> generate from either the external Xtal or the internal Bus Clock (clk81).
> 
> So new bindings was necessary to meet these requirements and the DT
> maintainers requirements.
> 
> The "legacy" binding actually used in the driver is left until all the DT
> files are switched to the new bindings.
> 
> The GX DT has been tested, but the last 4 Meson6/Meson8/b are only
> compile-tested, and testing is welcome.
> Thus only the first 3 patches can be merged until the Meson6/Meson8/b are
> formally tested.
> 
> It must be noted that the meson6 cannot work today except using an early
> console since the UART driver could not probe without a clocks property.
> 
> Changes since v4 at [1]:
>  - Droped meson8/meson8b DT patches
>  - Fixes copy/paste error in patch 2
>  - Refactored clock probing in patch 2
>  - merged meson6 patches together to avoid breaking bisect
> 
> [0] http://lkml.kernel.org/r/20170331165437.26227-1-hgkr.klein@gmail.com
> [1] http://lkml.kernel.org/r/1497001756-942-1-git-send-email-narmstrong@baylibre.com
> 
> Helmut Klein (3):
>   dt-bindings: serial: Add bindings for the Amlogic Meson UARTs
>   tty/serial: meson_uart: update to stable bindings
>   ARM64: dts: meson-gx: use stable UART bindings with correct gate clock
> 
> Neil Armstrong (1):
>   ARM: dts: meson6: use stable UART bindings
> 
>  .../bindings/serial/amlogic,meson-uart.txt         | 38 +++++++++
>  arch/arm/boot/dts/meson.dtsi                       |  8 +-
>  arch/arm/boot/dts/meson6.dtsi                      | 28 +++++++
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 12 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 25 ++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 25 ++++++
>  drivers/tty/serial/meson_uart.c                    | 90 ++++++++++++++++++++--
>  7 files changed, 209 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
> 


Hi Greg,

Patches 3 & 4 will need a respin to avoid breaking compatibility with old kernel
like the tty patch does by keeping the legacy compatible string.
I will re-send then in a separate thread and Kevin will handle them.

Patches 1 & 2 can be taken if they are OK for you.

Thanks,
Neil
