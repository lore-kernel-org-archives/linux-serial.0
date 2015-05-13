From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: serial_core: add pci uart early console support
Date: Wed, 13 May 2015 23:08:44 +0100
Message-ID: <20150513230844.1d9a5d9a@lxorguk.ukuu.org.uk>
References: <20150513192016.GA167188@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150513192016.GA167188@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 13 May 2015 12:20:16 -0700
Bin Gao <bin.gao@linux.intel.com> wrote:

> >From 8977941ac3d70425fa7ca5ef3ab6de6c28743f1f Mon Sep 17 00:00:00 2001
> From: Bin Gao <bin.gao@intel.com>
> Date: Tue, 12 May 2015 16:40:27 -0700
> Subject: [PATCH] serial_core: add pci uart early console support
> 
> On some Intel Atom SoCs, the legacy IO port UART(0x3F8) is not available.
> Instead, a 8250 compatible PCI uart can be used as early console.
> This patch adds pci support to the 8250 early console driver uart8250.
> For example, to enable pci uart(00:21.3) as early console on these
> platforms, append the following line to the kernel command line
> (assume baud rate is 115200):
> earlycon=uart8250,pci32,0:24.2,115200n8


We've already got support for this

commit ea9e9d8029020d438b0717ffddf65140fda16051


I actually think the fact you've put it into drivers/tty is better as PCI
is generic and PCI serial boot likewise. However it ought to use the same
command line interface (with extensions) to be compatible with the
existing arch/x86 code, and to remove the arch/x86 version if you are
doing so.

Alan
