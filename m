From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v6 RESEND] serial: rewrite pxa2xx-uart to use 8250_core
Date: Thu, 06 Oct 2016 08:25:35 +0200
Message-ID: <87shsa804g.fsf@belgarion.home>
References: <1474993396-525-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474993396-525-1-git-send-email-robert.jarzmik@free.fr> (Robert
        Jarzmik's message of "Tue, 27 Sep 2016 18:23:16 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Yanovich <ynvich@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, James Cameron <quozl@laptop.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> From: Sergey Yanovich <ynvich@gmail.com>
>
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
> CC: James Cameron <quozl@laptop.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Robert Jarzmik <robert.jarzmik@free.fr>
> CC: Russell King <linux@arm.linux.org.uk>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> [rebased on v4.8]
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Greg, can you take that into you tty tree please ?

Cheers.

--
Robert
