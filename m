From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 2/4] tty/8250_dw: Add support for OCTEON UARTS.
Date: Thu, 20 Jun 2013 11:29:00 +0300
Message-ID: <20130620082900.GB32331@xps8300>
References: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com>
 <1371677849-23912-3-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371677849-23912-3-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 19, 2013 at 02:37:27PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> A few differences needed by OCTEON:
> 
> o These are DWC UARTS, but have USR at a different offset.
> 
> o Internal SoC buses require reading back from registers to maintain
>   write ordering.
> 
> o 8250 on OCTEON appears with 64-bit wide registers, so when using
>   readb/writeb in big endian mode we have to adjust the membase to hit
>   the proper part of the register.
> 
> o No UCV register, so we hard code some properties.
> 
> Because OCTEON doesn't have a UCV register, I change where
> dw8250_setup_port(), which reads the UCV, is called by pushing it in
> to the OF and ACPI probe functions, and move unchanged
> dw8250_setup_port() earlier in the file.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki
