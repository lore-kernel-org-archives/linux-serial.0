From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v3 1/2] serial_core: add pci uart early console support
Date: Wed, 20 May 2015 19:50:12 +0200
Message-ID: <1432144212.21715.94.camel@x220>
References: <20150518212152.GA95407@worksta> <1432036867.9091.75.camel@x220>
	 <20150519173224.GA202975@worksta> <1432113385.21715.76.camel@x220>
	 <20150520175922.GA163133@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520175922.GA163133@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Wed, 2015-05-20 at 10:59 -0700, Bin Gao wrote:
> The HAVE_EARLY_PCI entry should be actually in generic PCI layer,
> i.e. drivers/pci, because it's a PCI feature but only some archs
> (currently only x86) support it.
> Then an arch with this feature could announce it in arch/<arch>/Kconfig by:
> select HAVE_EARLY_PCI if PCI

That makes more sense. So v4 will put HAVE_EARLY_PCI in a Kconfig under
drivers/pci/?

Thanks,


Paul Bolle
