From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] tty: serial: lpc32xx_hs: fix missing console boot
 messages
Date: Wed, 23 Jan 2019 00:38:50 +0200
Message-ID: <e7fb8d2d-5daf-afdf-bd8e-472c76701650@mleia.com>
References: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roland Stigge <stigge@antcom.de>, Sylvain Lemieux <slemieux.tyco@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Alexandre,

On 01/15/2019 07:18 PM, Alexandre Belloni wrote:
> When probing the HSUART, it is put in loopback mode in order to prevent a
> potential issue that may happen on RX (Errata HSUART.1).
> 
> serial_lpc32xx_startup() moves it out of loopback mode but this is too late
> to get the kernel boot messages before userspace opens the device.
> 
> Also get out of loopback mode in lpc32xx_hsuart_console_setup().
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

the change looks good, thank you.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
