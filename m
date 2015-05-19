From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v3 1/2] serial_core: add pci uart early console support
Date: Tue, 19 May 2015 14:01:07 +0200
Message-ID: <1432036867.9091.75.camel@x220>
References: <20150518212152.GA95407@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150518212152.GA95407@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Mon, 2015-05-18 at 14:21 -0700, Bin Gao wrote:
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2228,6 +2228,8 @@ config PCI
>  	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
>  	  VESA. If you have PCI, say Y, otherwise N.
>  
> +	select HAVE_EARLY_PCI
> +

It's legal to have options after the help text of a Kconfig entry. It's
also very uncommon to do that. Please put this select statement before
the line reading "---help---" of the PCI entry.
 
> +config HAVE_EARLY_PCI
> +	def_bool y

You probably want just
	bool

here. Because this symbol has no further dependencies, which means
HAVE_EARLY_PCI will now always be set to 'y'. That, in turn, makes the
select you added above pointless.

> +	help
> +	  This option indicates that a group of APIs are available (in
> +	  asm/pci-direct.h) so the kernel can access pci config registers
> +	  before the PCI subsystem is initialized. Any arch that supports

Is this expected to be used outside of X86?

> +	  early pci APIs must enable this option which is required  by arch
> +	  independent codes, e.g. uart8250 pci early console driver.
> +

Thanks,


Paul Bolle
