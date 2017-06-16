From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: Delete dead code for CIR serial ports
Date: Fri, 16 Jun 2017 14:43:54 +0300
Message-ID: <1497613434.22624.145.camel@linux.intel.com>
References: <20170615155449.28482-1-mbrugger@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615155449.28482-1-mbrugger@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <mbrugger@suse.com>, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: ed.blake@imgtec.com, vigneshr@ti.com, alexander.sverdlin@nokia.com, yegorslists@googlemail.com, dhowells@redhat.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2017-06-15 at 17:54 +0200, Matthias Brugger wrote:
> Commit e4fda3a04275 ("serial: don't register CIR serial ports") adds a
> check for PORT_8250_CIR to serial8250_register_8250_port(). But the
> code
> isn't needed as the function never takes the branch when the port is
> CIR
> serial port.

> +		if (serial8250_isa_config != NULL)

> +			serial8250_isa_config(0, &uart->port,
> +					&uart->capabilities);

Can't it be one line after all?

>  

> +		ret = uart_add_one_port(&serial8250_reg,
> +					&uart->port);

Ditto.

> +		if (ret == 0)
> +			ret = uart->port.line;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
