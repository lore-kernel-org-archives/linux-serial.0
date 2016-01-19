From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Tue, 19 Jan 2016 12:33:27 +0000
Message-ID: <20160119123327.3b519062@lxorguk.ukuu.org.uk>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
	<20160119035649.GA1696@windriver.com>
	<569DF7C3.5050306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569DF7C3.5050306@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

> The architecture of 8250_pci.c is good for PCIE device with 8250
> compatible serial ports. We want to implement all functions of
> F81504/508/512, but it'll make 8250_pci.c bloated and complex if we
> implement GPIOLIB in 8250_pci.c

Your device is multi-function. Create an MFD driver for it. Make the
8250 driver bind to the MFD, and provide your own baud rate methods
within the standard 8250 layer

Implement the GPIO lines in a GPIO driver that also binds to the MFD and
lives in drivers/gpio

All the needed pieces already exist to implement it cleanly this way
without duplicating a ton of code.

Alan
