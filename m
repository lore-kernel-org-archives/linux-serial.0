From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v6] serial: rewrite pxa2xx-uart to use 8250_core
Date: Tue, 29 Dec 2015 13:06:43 +0200
Message-ID: <20151229110643.GB19870@kuha.fi.intel.com>
References: <1450897204-6839-1-git-send-email-ynvich@gmail.com>
 <1450970122-12869-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450970122-12869-1-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, James Cameron <quozl@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Joachim Eastwood <manabian@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Scott Wood <scottwood@freescale.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Ralf Baechle <ralf@linux-mips.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 24, 2015 at 06:15:14PM +0300, Sergei Ianovich wrote:
> pxa2xx-uart was a separate uart platform driver. It was declaring
> the same device names and numbers as 8250 driver. As a result,
> it was impossible to use 8250 driver on PXA SoCs.
> 
> Upon closer examination pxa2xx-uart turned out to be a clone of
> 8250_core driver.
> 
> Workaround for Erratum #19 according to Marvel(R) PXA270M Processor
> Specification Update (April 19, 2010) is dropped. 8250_core reads
> from FIFO immediately after checking DR bit in LSR.
> 
> The patch leaves the original SERIAL_PXA driver around. The original
> driver is just marked DEPRECATED in Kconfig and C source. When
> the original driver is considered safe to remove, no changes
> to SERIAL_8250 will be necessary.
> 
> Compiling SERIAL_8250_CONSOLE and SERIAL_PXA_CONSOLE even without
> SERIAL_8250_PXA breaks console for SERIAL_PXA. For this reasons, the new
> and the original drivers are made mutually exclusive.
> 
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks,

-- 
heikki
