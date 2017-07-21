From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 1/4] serial: uartps: Remove console_initcall from the
 driver
Date: Fri, 21 Jul 2017 08:47:20 -0700
Message-ID: <20170721154720.ifjsn3og6apqi7mv@xsjsorenbubuntu.xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
 <bd75a2ab5838ae1cf44af667e24be2f02c2e9f3c.1500629544.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd75a2ab5838ae1cf44af667e24be2f02c2e9f3c.1500629544.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-07-21 at 11:32:24 +0200, Michal Simek wrote:
> register_console() is called from
> uart_add_one_port()->uart_configure_port()
> that's why register_console() is called twice.
> 
> This patch remove console_initcall to call register_console() only from
> one location.
> 
> Also based on my tests cdns_uart_console_setup() is not called
> from the first register_console() call.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> I am not quite sure about this because console_initcall is called
> early but I can see any difference in usage.
> pl011 is not calling this but others are doing it.

Doesn't this break early console/printk? I would expect that the UART
initialization may happen later than console init.

	Sören
