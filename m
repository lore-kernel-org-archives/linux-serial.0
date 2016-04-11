From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 07/11] serial: 8250: enable AFE on ports where FIFO is
 16 bytes
Date: Mon, 11 Apr 2016 07:53:07 -0700
Message-ID: <570BBA53.4080508@hurleysoftware.com>
References: <1460379071-132591-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1460379071-132591-8-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460379071-132591-8-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 04/11/2016 05:51 AM, Andy Shevchenko wrote:
> Intel Quark has 16550A compatible UART with autoflow feature enabled. It has
> only 16 bytes of FIFO. Currently serial8250_do_set_termios() prevents to enable
> autoflow since the minimum requirement of 32 bytes of FIFO size.
> 
> Drop a FIFO size limitation to allow autoflow control be enabled on such UARTs.
> 
> While here, comment out UART_CAP_AFE for PORT_AR7 since it wasn't working and
> it will be not a good idea to use it in conjunction with trigger level of 1
> byte.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
