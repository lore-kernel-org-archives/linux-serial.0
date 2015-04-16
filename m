From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] serial: of-serial: Remove device_type = "serial" registration
Date: Thu, 16 Apr 2015 11:31:10 +0200
Message-ID: <3734018.A9aq7EmC6b@wuerfel>
References: <ffb577a257d14087e1d2d0347a071f5aef519e52.1429005786.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <ffb577a257d14087e1d2d0347a071f5aef519e52.1429005786.git.michal.simek@xilinx.com>
Sender: stable-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Tuesday 14 April 2015 12:03:09 Michal Simek wrote:
> Do not probe all serial drivers by of_serial.c which are using
> device_type = "serial"; property. Only drivers which have valid
> compatible strings listed in the driver should be probed.
> 
> When PORT_UNKNOWN is setup probe will fail anyway.
> 
> Arnd quotation about driver historical background:
> "when I wrote that driver initially, the idea was that it would
> get used as a stub to hook up all other serial drivers but after
> that, the common code learned to create platform devices from DT"
> 
> This patch fix the problem with on the system with xilinx_uartps and
> 16550a where of_serial failed to register for xilinx_uartps and because
> of irq_dispose_mapping() removed irq_desc. Then when xilinx_uartps was asking
> for irq with request_irq() EINVAL is returned.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> CC: <stable@vger.kernel.org>
> ---
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
