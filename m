From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] serial: 8250_EXAR: fix duplicate Kconfig text and add
 missing help text
Date: Tue, 28 Mar 2017 08:52:48 +0100
Message-ID: <20170328075248.GA3992@sudip-tp>
References: <20170327233910.13122-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170327233910.13122-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 27, 2017 at 07:39:10PM -0400, Paul Gortmaker wrote:
> In commit d0aeaa83f0b0f7a92615bbdd6b1f96812f7dcfd2 ("serial: exar:
> split out the exar code from 8250_pci") the exar driver got its own
> Kconfig.  However the text for the new option was never changed from
> the original 8250_PCI text, and hence it appears confusing when you
> get asked the same question twice:
> 
>   8250/16550 PCI device support (SERIAL_8250_PCI) [Y/n/m/?] (NEW)
>     8250/16550 PCI device support (SERIAL_8250_EXAR) [Y/n/m] (NEW)
> 
> Adding to the confusion, is that there is no help text for this new
> option to indicate it is specific to a certain family of cards.
> 
> Fix both issues at the same time, as well as the space vs. tab issues
> introduced in the same commit.
> 
> Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
