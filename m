From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 0/3] serial: remove modular code from a few more
 non-modular drivers
Date: Tue, 21 Jun 2016 01:30:12 -0400
Message-ID: <20160621053012.GM12567@windriver.com>
References: <20160620225505.7320-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160620225505.7320-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alexey Charkov <alchark@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tony Prisk <linux@prisktech.co.nz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[[PATCH 0/3] serial: remove modular code from a few more non-modular drivers] On 20/06/2016 (Mon 18:55) Paul Gortmaker wrote:

> For anyone new to the underlying goal of this cleanup, we are trying to
> not use module support for code that can never be built as a module since:
> 
>  (1) it is easy to accidentally write unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else, thus adding to CPP overhead.
>  (4) it gets copied/replicated into other code and spreads like weeds.
> 
> We have already fixed a bunch of these in drivers/tty already, so there
> is really nothing new to see here (at least for the serial maintainers).

Apologies in advance to anyone who is trying to find these patches via
an archive of linux-kernel or linux-serial ; it seems that we hit a
window where a glitch at vger.kernel.org was rejecting incoming mails.

P.
--

> 
> Changes seen here cover the following categories:
> 
>   -just replacement of modular macros with their non-modular
>    equivalents that CPP would have inserted anyway
> 
>   -the removal of including module.h ; replaced with init.h
>    as required based on whether the file already had it.
> 
>   -the removal of any/all unused/orphaned __exit functions
>    that would never be called/exercised.
> 
>   -the removal of any ".remove" functions that were hooked into
>    the driver struct.   This ".remove" function would of
>    course not be called from the __exit function since that was
>    never run.  However in theory, someone could have triggered it
>    via sysfs unbind, even though there isn't a sensible use case
>    for doing so.  So to cover that possibility, we've also disabled
>    sysfs unbind in the driver.
> 
> In doing so we get rid of ~70 lines of dead code across 3 drivers.
> 
> There are no initcall level changes here; everything was at the level
> of device_initcall and remains so, by using the builtin equivalents.
> 
> Build tested for arm(2) and m32r(1) on the linux-next tree from today
> to ensure no silly typos crept in.
> 
> If there is a desire for any of these to be modular, we can definitely
> consider that, but by default the changes here keep the code consistent
> with existing behaviour.  Thus I do not expand functionality into the
> modular realm that I can't run time test, or even know if the modular
> instance has a sensible modular use case.
> 
> Paul.
> ---
> 
> Cc: Alexey Charkov <alchark@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: linux-serial@vger.kernel.org
> 
> Paul Gortmaker (3):
>   serial: pxa: make it explicitly non-modular
>   serial: vt8500_serial: make it explicitly non-modular
>   serial: m32r_sio: make it explicitly non-modular
> 
>  drivers/tty/serial/m32r_sio.c      | 18 +-----------------
>  drivers/tty/serial/pxa.c           | 31 +++----------------------------
>  drivers/tty/serial/vt8500_serial.c | 30 ++----------------------------
>  3 files changed, 6 insertions(+), 73 deletions(-)
> 
> -- 
> 2.8.4
