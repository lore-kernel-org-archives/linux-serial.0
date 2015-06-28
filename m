From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v6 1/2] serial_core: add pci uart early console support
Date: Sun, 28 Jun 2015 16:44:49 -0400
Message-ID: <55905CC1.7020106@hurleysoftware.com>
References: <20150529183839.GA13090@worksta> <20150608181711.GA181146@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150608181711.GA181146@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/08/2015 02:17 PM, Bin Gao wrote:
> On some Intel Atom SoCs, the legacy IO port UART(0x3F8) is not available.
> Instead, a 8250 compatible PCI uart can be used as early console.
> This patch adds pci support to the 8250 early console driver uart8250.
> For example, to enable pci uart(00:21.3) as early console on these
> platforms, append the following line to the kernel command line
> (assume baud rate is 115200):
> earlyprintk=uart8250,pci32,0:24.2,115200n8

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
