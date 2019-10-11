From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: Re: [PATCH v9 3/5] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Fri, 11 Oct 2019 10:37:10 +0200
Message-ID: <20191011103710.6c45fdbc9a05fdd13177193e@suse.de>
References: <20191010145953.21327-1-tbogendoerfer@suse.de>
        <20191010145953.21327-4-tbogendoerfer@suse.de>
        <20191010200002.5fe5f34f@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191010200002.5fe5f34f@cakuba.netronome.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 10 Oct 2019 20:00:02 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> On Thu, 10 Oct 2019 16:59:49 +0200, Thomas Bogendoerfer wrote:
> >  	dev = alloc_etherdev(sizeof(struct ioc3_private));
> > -	if (!dev) {
> > -		err = -ENOMEM;
> > -		goto out_disable;
> > -	}
> > -
> > -	if (pci_using_dac)
> > -		dev->features |= NETIF_F_HIGHDMA;
> 
> Looks like the NETIF_F_HIGHDMA feature will not longer be set, is that
> okay?

yes, all platforms where ioc3 is usable are running 64bit kernels without
HIGHMEM.

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 247165 (AG München)
Geschäftsführer: Felix Imendörffer
