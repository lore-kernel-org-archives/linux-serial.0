From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 01/10] serial: mvebu-uart: initial support for
 Armada-3700 serial port
Date: Tue, 2 Feb 2016 15:19:43 -0600
Message-ID: <20160202211943.GA18698@rob-hp-laptop>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Wilson Ding <dingwei@marvell.com>, Nadav Haklai <nadavh@marvell.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 02, 2016 at 07:07:39PM +0100, Gregory CLEMENT wrote:
> From: Wilson Ding <dingwei@marvell.com>
> 
> Armada-3700's uart is a simple serial port, which doesn't
> support. Configuring the modem control lines. The uart port has a 32
> bytes Tx FIFO and a 64 bytes Rx FIFO
> 
> The uart driver implements the uart core operations. It also support the
> system (early) console based on Armada-3700's serial port.
> 
> Known Issue:
> 
> The uart driver currently doesn't support clock programming, which means
> the baud-rate stays with the default value configured by the bootloader
> at boot time
> 
> [gregory.clement@free-electrons.com: Rewrite many part which are too long
> to enumerate]
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/tty/serial/mvebu-uart.txt  |  13 +

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/kernel-parameters.txt                |   6 +
>  drivers/tty/serial/Kconfig                         |  22 +
>  drivers/tty/serial/Makefile                        |   1 +
>  drivers/tty/serial/mvebu-uart.c                    | 649 +++++++++++++++++++++
>  include/uapi/linux/serial_core.h                   |   3 +
>  6 files changed, 694 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt
>  create mode 100644 drivers/tty/serial/mvebu-uart.c
