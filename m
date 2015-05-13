From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 00/11] drivers: PL011: add ARM SBSA Generic UART support
Date: Wed, 13 May 2015 10:17:48 +0100
Message-ID: <20150513091748.GA25891@red-moon>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Jakub Kicinski <moorray3@wp.pl>, Greg KH <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 12, 2015 at 03:14:44PM +0100, Andre Przywara wrote:
> This is the fourth revision of the SBSA UART support series, now
> based on the current tty-next branch.
> Compared to v3 I addressed some comments Jakub had on v3 (thanks for
> the review!). Also since some basic ACPI support for ARM64 is now
> upstream, I include the necessary ACPI binding as a new patch 11
> on top.
> ----
> 
> The ARM Server Base System Architecture[1] document describes a
> generic UART which is a subset of the ARM PL011 UART.
> It lacks DMA support, baud rate control and modem status line
> control, among other things.
> The idea is to move the UART initialization and setup into the
> firmware (which does this job today already) and let the kernel just
> use the UART for sending and receiving characters.
> 
> This patchset integrates support for this UART subset into the
> existing PL011 driver - basically by refactoring some
> functions and providing a new uart_ops structure for it. It also has
> a separate probe function to be not dependent on AMBA/PrimeCell.
> It provides a device tree and an ACPI binding.
> Beside the obvious effect of code sharing reusing most of the PL011
> code has the advantage of not introducing another serial device
> prefix, so it can go with ttyAMA, which seems to be pretty common.
> As changing the baudrate and other communication parameters is not
> specified for the SBSA UART, any userland attempt will be denied by
> the kernel. The device-tree provided fixed baud rate will be
> reported, so stty for instance prints the right value.
> 
> This series is based on Greg's tty-next branch, a git repo can
> be found at [2] (branch sbsa-uart/v4).
> 
> Patch 1/11 contains a bug fix which applies to the PL011 part also,
> it should be considered regardless of the rest of the series.
> According to Russell this is still racy, but still better than the
> current solution.
> Patch 2-7 refactor some PL011 functions by splitting them up into
> smaller pieces, so that most of the code can be reused later by the
> SBSA part.
> Patch 8 and 9 introduce two new properties for the vendor structure,
> this is for SBSA functionality which cannot be controlled by
> separate uart_ops members only.
> Patch 10 then finally drops in the SBSA specific code, by providing
> a new uart_ops, vendor struct and probe function for it. Also the new
> device tree binding is documented.
> Patch 11 adds the necessary ACPI boilerplate.
> 
> For testing you should be able to take any hardware which has a PL011
> and change the DT to use a "arm,sbsa-uart" compatible string and the
> baud rate with the "current-speed" property.
> Of course testing with a real SBSA Generic UART is welcomed - as well
> as regression testing with any PL011 implementation.
> I tested this on a FastModel, a Juno and a Midway machine, both in
> PL011 and in (DT-emulated) SBSA mode.
> 
> Changelog:
> v3 .. v4:
> - fixed rebase artifact
> - moved memory allocation out of pl011_allocate_port() function
>   (and consequently renamed that to pl011_find_free_port)
> - added ACPI driver binding
> 
> v2 .. v3:
> - rebased on top of tty-next and Dave's latest PL011 rework
> - fixed module build
> - removed redundant =NULL members in sbsa_uart_ops
> 
> v1 .. v2:
> - rebased on top of 4.0-rc1 and Dave's newest PL011 fix [3]
> - added mandatory current-speed property and report that to userland
> 
> Cheers,
> Andre
> 
> [1] ARM-DEN-0029 Server Base System Architecture, available (click-
>     thru...) from http://infocenter.arm.com
> [2] http://www.linux-arm.org/git?p=linux-ap.git
>     git://linux-arm.org/linux-ap.git
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327631.html
> 
> Andre Przywara (10):
>   drivers: PL011: avoid potential unregister_driver call
>   drivers: PL011: refactor pl011_startup()
>   drivers: PL011: refactor pl011_shutdown()
>   drivers: PL011: refactor pl011_set_termios()
>   drivers: PL011: refactor pl011_probe()
>   drivers: PL011: replace UART_MIS reading with _RIS & _IMSC
>   drivers: PL011: move cts_event workaround into separate function
>   drivers: PL011: allow avoiding UART enabling/disabling
>   drivers: PL011: allow to supply fixed option string
>   drivers: PL011: add support for the ARM SBSA generic UART
> 
> Graeme Gregory (1):
>   drivers: PL011: add ACPI probing for SBSA UART
> 
>  .../devicetree/bindings/serial/arm_sbsa_uart.txt   |  10 +
>  drivers/tty/serial/amba-pl011.c                    | 547 +++++++++++++++------
>  2 files changed, 409 insertions(+), 148 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
