From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [patch v1 0/2] JTAG driver introduction
Date: Thu, 3 Aug 2017 19:48:22 +0200
Message-ID: <20170803174822.GI15018@lunn.ch>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <20170802141209.GB25781@lunn.ch>
 <AM4PR0501MB2194E6B8D14EC15356C1C0BFB1B10@AM4PR0501MB2194.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB2194E6B8D14EC15356C1C0BFB1B10@AM4PR0501MB2194.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, system-sw-low-level <system-sw-low-level@mellanox.com>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mec@shout.net" <mec@shout.net>, "joel@jms.id.au" <joel@jms.id.au>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "vadimp@maellanox.com" <vadimp@maellanox.com>, "tklauser@distanz.ch" <tklauser@distanz.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

> Hi Andrew
> 
> Thanks a lot for review.
> 

> We used user space tool for that, which is an adaptation of some
> Lattice tools, which allows programming of SVF files. We are using
> it for Lattice CPLD burning, since we have for such devices on our
> system, but this tool could be used for programming other devices
> from other vendors as well.
 
> https://github.com/mellanoxbmc/mellanox-bmc-tools

Since you are defining a new Kernel ABI here, it would be good to get
some buy-in from potential users for the ABI. Maybe for the next
version of the patchset you can cross post to the OpenOCD-devel list?

	Andrew
