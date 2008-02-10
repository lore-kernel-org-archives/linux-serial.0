From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][7/8] kgdb: exclusive use kgdb8250 uart I/O driver
Date: Sun, 10 Feb 2008 15:26:26 +0000
Message-ID: <20080210152626.GA3993@ucw.cz>
References: <1202564114-18587-1-git-send-email-jason.wessel@windriver.com> <1202564114-18587-2-git-send-email-jason.wessel@windriver.com> <1202564114-18587-3-git-send-email-jason.wessel@windriver.com> <1202564114-18587-4-git-send-email-jason.wessel@windriver.com> <1202564114-18587-5-git-send-email-jason.wessel@windriver.com> <1202564114-18587-6-git-send-email-jason.wessel@windriver.com> <1202564114-18587-7-git-send-email-jason.wessel@windriver.com> <1202564114-18587-8-git-send-email-jason.wessel@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753315AbYBJP06@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1202564114-18587-8-git-send-email-jason.wessel@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jason.wessel@windriver.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jan Kiszka <jan.kiszka@web.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi!

> This patch some small hooks into the normal serial core so that a uart
> can be unregistered to be exclusively used for KGDB.  These changes
> allow for registering and unregistering a port with a struct
> uart_port. From that point on KGDB does raw accesses to the serial
> IO ports it has taken over.
> 
> CC: linux-serial@vger.kernel.org
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/DocBook/kgdb.tmpl |   44 ++++
>  drivers/serial/8250.c           |   30 +++
>  drivers/serial/8250_kgdb.c      |  489 +++++++++++++++++++++++++++++++++++++++
>  drivers/serial/Kconfig          |    2 +-
>  drivers/serial/Makefile         |    1 +
>  drivers/serial/serial_core.c    |   18 ++-
>  include/linux/serial_8250.h     |    2 +
>  lib/Kconfig.kgdb                |   21 ++
>  8 files changed, 603 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/serial/8250_kgdb.c
> 
> diff --git a/Documentation/DocBook/kgdb.tmpl b/Documentation/DocBook/kgdb.tmpl
> index c423411..111a2a0 100644
> --- a/Documentation/DocBook/kgdb.tmpl
> +++ b/Documentation/DocBook/kgdb.tmpl
> @@ -92,6 +92,50 @@
>    <chapter id="BootingTheKernel">
>      <title>Booting the kernel</title>
>      <para>
> +    The Kernel command line option <constant>kgdbwait</constant> makes kgdb
> +    wait for gdb connection during booting of a kernel.  If the
> +    <symbol>CONFIG_KGDB_8250</symbol> driver is used (or if applicable,
> +    another serial driver) this breakpoint will happen very early on, before
> +    console output.
> +    </para>

I believe we already have command line options listed in different
file... and in readable format, too.


> --- /dev/null
> +++ b/drivers/serial/8250_kgdb.c
> @@ -0,0 +1,489 @@
> +/*
> + * 8250 serial I/O driver for KGDB.
> + *
> + * This is a merging of many different drivers, and all of the people have
> + * had an impact in some form or another:
> + *
> + * 2004-2005 (c) MontaVista Software, Inc.
> + * 2005-2006 (c) Wind River Systems, Inc.

Hmm, is it WindRiver or
           WinDriver? :-)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
