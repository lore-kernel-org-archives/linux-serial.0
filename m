From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4.9-stable] serial: pl011: add console matching function
Date: Tue, 5 Jun 2018 12:19:53 +0200
Message-ID: <20180605101953.GC26129@kroah.com>
References: <20180604131612.14407-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180604131612.14407-1-ard.biesheuvel@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org, leif.lindholm@linaro.org, graeme.gregory@linaro.org, linux@armlinux.org.uk, jslaby@suse.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 04, 2018 at 03:16:12PM +0200, Ard Biesheuvel wrote:
> From: Aleksey Makarov <aleksey.makarov@linaro.org>
> 
> Commit 10879ae5f12e9cab3c4e8e9504c1aaa8a033bde7 upstream.
> 
> This patch adds function pl011_console_match() that implements
> method match of struct console.  It allows to match consoles against
> data specified in a string, for example taken from command line or
> compiled by ACPI SPCR table handler.
> 
> This patch was merged to tty-next but then reverted because of
> conflict with
> 
> commit 46e36683f433 ("serial: earlycon: Extend earlycon command line option to support 64-bit addresses")
> 
> Now it is fixed.
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Tested-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Please consider for v4.9-stable. It is the missing puzzle piece for SPCR
> support on arm64 ACPI systems, which got merged for v4.9 [0]. Now that more
> systems are becoming available to people working in the kernel community, it
> turns out that v4.9 distro installers (e.g., Debian Stretch) won't work
> unless you pass a 'console=' parameter explicitly, which is annoying.
> Given that it was clearly the intent to include this code at the time,
> I hope it will be considered for backporting.
> 
> [0] To quote the tty maintainer:
> 
>       Also in here is the long-suffering ACPI SPCR patchset, which was
>       passed around from maintainer to maintainer like a hot-potato. Seems I
>       was the sucker^Wlucky one. All of those patches have been acked by the
>       various subsystem maintainers as well.

Now queued up, thanks.

greg k-h
