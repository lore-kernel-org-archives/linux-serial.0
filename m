From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO accesses
 via DT
Date: Mon, 24 Nov 2014 15:55:25 -0800
Message-ID: <5473C56D.1050308@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64227 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaKXXzl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 18:55:41 -0500
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

On 11/24/2014 03:36 PM, Kevin Cernekee wrote:
> My last submission attempted to work around serial driver coexistence
> problems on multiplatform kernels.  Since there are still questions
> surrounding the best way to solve that problem, this patch series
> will focus on the narrower topic of big endian MMIO support on serial.

FWIW:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> 
> V2->V3:
> 
>  - Document the new DT properties.
> 
>  - Add libfdt-based wrapper, to complement the "struct device_node" based
>    version.
> 
>  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>    temporary variable, so it is easy to add more of_setup_earlycon()
>    properties later.
> 
>  - Make of_serial and serial8250 honor the new "big-endian" property.
> 
> 
> This series applies cleanly to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
> 
> but was tested on the mips-for-linux-next branch because my BE platform
> isn't supported in mainline yet.
> 
> 
> Kevin Cernekee (7):
>   of: Add helper function to check MMIO register endianness
>   of/fdt: Add endianness helper function for early init code
>   of: Document {little,big,native}-endian bindings
>   serial: core: Add big-endian iotype
>   serial: earlycon: Set UPIO_MEM32BE based on DT properties
>   serial: of_serial: Support big-endian register accesses
>   serial: 8250: Add support for big-endian MMIO accesses
> 
>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>  drivers/of/base.c                                  | 23 +++++++++
>  drivers/of/fdt.c                                   | 26 +++++++++-
>  drivers/tty/serial/8250/8250_core.c                | 20 ++++++++
>  drivers/tty/serial/8250/8250_early.c               |  5 ++
>  drivers/tty/serial/earlycon.c                      |  4 +-
>  drivers/tty/serial/of_serial.c                     |  3 +-
>  drivers/tty/serial/serial_core.c                   |  2 +
>  include/linux/of.h                                 |  6 +++
>  include/linux/of_fdt.h                             |  2 +
>  include/linux/serial_core.h                        | 15 +++---
>  11 files changed, 155 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
> 

