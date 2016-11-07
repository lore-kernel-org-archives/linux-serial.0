From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH] tty: serial: make crisv10 explicitly non-modular
Date: Mon, 7 Nov 2016 12:38:34 +0100
Message-ID: <20161107113834.GR30704@axis.com>
References: <20161031174216.900-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161031174216.900-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 31, 2016 at 01:42:16PM -0400, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> arch/cris/arch-v10/drivers/Kconfig:config ETRAX_SERIAL
> arch/cris/arch-v10/drivers/Kconfig:     bool "Serial-port support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.

Agreed, put in the cris tree for 4.10.

> We don't replace module.h with init.h since the file already has that.
> 
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-cris-kernel@axis.com
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks!

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
