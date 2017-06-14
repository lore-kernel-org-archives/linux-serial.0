From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v2 2/2] tty/serial: atmel: make the driver DT only
Date: Wed, 14 Jun 2017 09:41:38 +0200
Message-ID: <97aeecba-eb9f-508c-9052-3fb00f89f9e8@gmail.com>
References: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
 <20170613202439.26369-2-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613202439.26369-2-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 13/06/2017 22:24, Alexandre Belloni wrote:
> Now that AVR32 is gone, platform_data are not used to initialize the driver
> anymore, remove that path from the driver. Also remove the now unused
> struct atmel_uart_data.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/tty/serial/atmel_serial.c   | 96 +++++++++++++------------------------
>  include/linux/platform_data/atmel.h | 10 ----
>  2 files changed, 33 insertions(+), 73 deletions(-)

Acked-by: Richard Genoud <richard.genoud@gmail.com>
