From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 0/5] Add big-endian MMIO support to serial8250
Date: Fri, 10 Apr 2015 08:52:50 -0500
Message-ID: <CAL_Jsq+-Yr3oB2=7X2a9XDU_-b+08WfJRJUqVsCHAaQEQxQ1Mg@mail.gmail.com>
References: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Florian Fainelli <f.fainelli@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 9, 2015 at 3:05 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> V3->V4:
>
> Rebase on Linus' head of tree
>
> Tweak documentation per Grant's request
>
> Drop the of_earlycon patches in favor of Peter's series

Are there conflicts with Peter's stuff? The series looks good to me.
So either I can take it with Greg's ack or Greg can take it.

Acked-by: Rob Herring <robh@kernel.org>

Rob

>
>
> Kevin Cernekee (5):
>   of: Add helper function to check MMIO register endianness
>   of/fdt: Add endianness helper function for early init code
>   of: Document {little,big,native}-endian bindings
>   serial: 8250: Add support for big-endian MMIO accesses
>   serial: of_serial: Support big-endian register accesses
>
>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>  drivers/of/base.c                                  | 23 +++++++++
>  drivers/of/fdt.c                                   | 19 +++++++
>  drivers/tty/serial/8250/8250_core.c                | 20 ++++++++
>  drivers/tty/serial/8250/8250_early.c               |  5 ++
>  drivers/tty/serial/of_serial.c                     |  3 +-
>  include/linux/of.h                                 |  6 +++
>  include/linux/of_fdt.h                             |  2 +
>  8 files changed, 137 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
>
> --
> 2.2.2
>
