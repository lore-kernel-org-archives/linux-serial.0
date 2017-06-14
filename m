From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v2 1/2] tty/serial: atmel: remove
 atmel_default_console_device handling
Date: Wed, 14 Jun 2017 09:40:33 +0200
Message-ID: <0bb0be06-ef27-7bb5-af8d-1e25ec9f1534@gmail.com>
References: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 13/06/2017 22:24, Alexandre Belloni wrote:
> atmel_default_console_device was only used by AVR32, in particular
> arch/avr32/mach-at32ap/at32ap700x.c which is now gone. Remove it from the
> driver.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> 
> Changes in v2:
>  - added an empty line as suggested by Andy
>  - properly based the patch on v4.12-rc1
> 
>  drivers/tty/serial/atmel_serial.c | 43 ---------------------------------------
>  1 file changed, 43 deletions(-)
> 

Acked-by: Richard Genoud <richard.genoud@gmail.com>


Thanks !
