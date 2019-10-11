From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: Re: [PATCH v9 5/5] MIPS: SGI-IP27: Enable ethernet phy on second
 Origin 200 module
Date: Fri, 11 Oct 2019 11:28:04 +0200
Message-ID: <20191011112804.ef8079aa9bad5c81ce473fbd@suse.de>
References: <20191010145953.21327-1-tbogendoerfer@suse.de>
        <20191010145953.21327-6-tbogendoerfer@suse.de>
        <102db20a-0c37-3e28-2d14-e9c6eaa55f5c@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <102db20a-0c37-3e28-2d14-e9c6eaa55f5c@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 10 Oct 2019 19:37:15 +0300
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> On 10/10/2019 05:59 PM, Thomas Bogendoerfer wrote:
> > +	/* enable ethernet PHY on IP29 systemboard */
> > +	pci_read_config_dword(dev, PCI_SUBSYSTEM_VENDOR_ID, &sid);
> > +	if (sid == ((PCI_VENDOR_ID_SGI << 16) | IOC3_SUBSYS_IP29_SYSBOARD))
> 
>    I thought PCI was little endian, thuis vendor ID at offset 0 and device ID
> at offset 2?

you are right. I already messed it up in pci-xtalk-bridge.c. As this is just a
fake sub device id, there is no harm, but I'll fix it.

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 247165 (AG München)
Geschäftsführer: Felix Imendörffer
