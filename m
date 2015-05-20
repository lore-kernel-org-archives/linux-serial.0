From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: [PATCH v3 1/2] serial_core: add pci uart early console support
Date: Wed, 20 May 2015 14:11:22 -0700
Message-ID: <20150520211121.GA174101@worksta>
References: <20150518212152.GA95407@worksta>
 <1432036867.9091.75.camel@x220>
 <20150519173224.GA202975@worksta>
 <1432113385.21715.76.camel@x220>
 <20150520175922.GA163133@worksta>
 <1432144212.21715.94.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432144212.21715.94.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Wed, May 20, 2015 at 07:50:12PM +0200, Paul Bolle wrote:
> That makes more sense. So v4 will put HAVE_EARLY_PCI in a Kconfig under
> drivers/pci/?
> 
Yes.
