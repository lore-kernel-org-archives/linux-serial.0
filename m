From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v6 RESEND] serial: rewrite pxa2xx-uart to use 8250_core
Date: Wed, 26 Oct 2016 21:49:35 +0200
Message-ID: <8737ji3n74.fsf@belgarion.home>
References: <1474993396-525-1-git-send-email-robert.jarzmik@free.fr>
        <87shsa804g.fsf@belgarion.home> <20161006071535.GA17007@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161006071535.GA17007@kroah.com> (Greg Kroah-Hartman's message
        of "Thu, 6 Oct 2016 09:15:35 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Yanovich <ynvich@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, James Cameron <quozl@laptop.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Oct 06, 2016 at 08:25:35AM +0200, Robert Jarzmik wrote:
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> 
>> > From: Sergey Yanovich <ynvich@gmail.com>
>> >
>> > pxa2xx-uart was a separate uart platform driver. It was declaring
>> > the same device names and numbers as 8250 driver. As a result,
>> > it was impossible to use 8250 driver on PXA SoCs.
>> >
>> > Upon closer examination pxa2xx-uart turned out to be a clone of
>> > 8250_core driver.
>> >
>> > Workaround for Erratum #19 according to Marvel(R) PXA270M Processor
>> > Specification Update (April 19, 2010) is dropped. 8250_core reads
>> > from FIFO immediately after checking DR bit in LSR.
>> >
>> > The patch leaves the original SERIAL_PXA driver around. The original
>> > driver is just marked DEPRECATED in Kconfig and C source. When
>> > the original driver is considered safe to remove, no changes
>> > to SERIAL_8250 will be necessary.
>> >
>> > Compiling SERIAL_8250_CONSOLE and SERIAL_PXA_CONSOLE even without
>> > SERIAL_8250_PXA breaks console for SERIAL_PXA. For this reasons, the new
>> > and the original drivers are made mutually exclusive.
>> >
>> > Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
>> > CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> > CC: James Cameron <quozl@laptop.org>
>> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > CC: Robert Jarzmik <robert.jarzmik@free.fr>
>> > CC: Russell King <linux@arm.linux.org.uk>
>> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> > [rebased on v4.8]
>> > Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> 
>> Greg, can you take that into you tty tree please ?
>
> Please wait until after the 4.9-rc1 merge window is over before worrying
> about new patches being applied to my trees...

Hi Greg,

Is it a better time slot now ?

Cheers.

-- 
Robert
