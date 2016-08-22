From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 23:52:56 +0100
Message-ID: <20160822235256.2966dd49@lxorguk.ukuu.org.uk>
References: <20160818202900.hyvm4hfxedifuefn@earth>
        <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
        <20160819052125.ze5zilppwoe3f2lx@earth>
        <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
        <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
        <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com>
        <20160820143405.04303834@lxorguk.ukuu.org.uk>
        <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com>
        <20160822203947.ksxwnvzhc3tpnnx7@earth>
        <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
        <20160822224247.vdh3plda6dxelvzw@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822224247.vdh3plda6dxelvzw@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> There are usb-serial devices, which could benefit from support
> btw. I would find it really useful, if the Dangerous Prototype's
> Bus Pirate would expose native /dev/i2c and /dev/spi and it's
> based on FT232.

That should just need an ldisc. I2C and SPI should at this point be sane
for hotplugging as needed for an ldisc.

And having an ldisc also has another nice effect. You can plug the bus
pirate into a remote machine, run an 8bit clean link over a pty/tty pair
half way around the world and get a local i2c/spi to the remote machine's
i2c/spi bus pirate ports and devices.

It also means that if Bus Pirate 5 changes USB uart nothing breaks.

Alan
