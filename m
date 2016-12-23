From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_dw: #ifdef out dw8250_acpi_match if ACPI
 isn't set
Date: Fri, 23 Dec 2016 19:09:23 +0100
Message-ID: <20161223180923.GA26878@kroah.com>
References: <20161223123355.1370-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161223123355.1370-1-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 23, 2016 at 08:33:55PM +0800, Jisheng Zhang wrote:
> dw8250_acpi_match is used only when ACPI is enabled. Fix the following
> gcc warning when W=1 is set:
> 
> drivers/tty/serial/8250/8250_dw.c:640:36: warning: 'dw8250_acpi_match'
> defined but not used [-Wunused-const-variable=]

Don't set W=1 then, this type of "fix" is foolish and is just going to
make code messier, sorry.

greg k-h
