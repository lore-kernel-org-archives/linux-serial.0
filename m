From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
Date: Wed, 07 Mar 2018 23:30:11 +0000
Message-ID: <CAGS+omCr2YUcAmv9068kR1s4LOqCGij_ps3+9tQ92whVWvGBxg@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301184335.248378-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <cdall@linaro.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, marc.zyngier@arm.com, frederic@kernel.org, dwmw@amazon.co.uk, tom.saeger@oracle.com, zohar@linux.vnet.ibm.com, alexander.levin@verizon.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 1, 2018 at 11:43 AM Daniel Kurtz <djkurtz@chromium.org> wrote:

> Currently when an earlycon is registered, the uartclk is assumed to be
> BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
> options, then 8250_early's init_port will program the UART clock divider
> registers based on this assumed uartclk.

> However, not all uarts have a UART clock of 1843200.  For example, the
> 8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
> cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
> on such a device will result in incorrect divider values and a wrong UART
> clock.

> Fix this by extending the earlycon options parameter to allow
specification
> of a uartclk, like so:

>   earlycon=uart,mmio32,0xfedc6000,115200,48000000

> If none is specified, fall-back to prior behavior - 1843200.

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

This general approach is facing resistance, so trying another more targeted
approach to work around the "BASE_BAUD=115200" assumption in arch/x86:

https://patchwork.kernel.org/patch/10265587/
