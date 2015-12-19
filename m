From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 1/2] serial: rewrite pxa2xx-uart to use 8250_core
Date: Sat, 19 Dec 2015 13:45:21 +0100
Message-ID: <8737uyhaji.fsf@belgarion.home>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
	<1449700088-28076-1-git-send-email-ynvich@gmail.com>
	<1449700088-28076-2-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, James Cameron <quozl@laptop.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, Scott Wood <scottwood@freescale.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Burton <paul.burton@imgtec.com>, Joachim Eastwood <manabian@gmail.com>, Mans Rullgard <mans@mansr.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, linux-arm-k
List-Id: linux-serial@vger.kernel.org

Sergei Ianovich <ynvich@gmail.com> writes:

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
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: James Cameron <quozl@laptop.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

I was wondering if this should go through pxa tree, or through serial tree ?

Cheers.

--
Robert
