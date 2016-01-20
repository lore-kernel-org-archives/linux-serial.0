From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Wed, 20 Jan 2016 10:59:28 +0800
Message-ID: <569EF810.1000304@gmail.com>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20160119035649.GA1696@windriver.com> <569DF7C3.5050306@gmail.com>
 <20160119123327.3b519062@lxorguk.ukuu.org.uk>
 <1453209684.2521.115.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453209684.2521.115.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, gregkh@linuxfoundation.org, jslaby@suse.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy, Alan

Andy Shevchenko =E6=96=BC 2016/1/19 =E4=B8=8B=E5=8D=88 09:21 =E5=AF=AB=E9=
=81=93:
>> Your device is multi-function. Create an MFD driver for it. Make the
>> 8250 driver bind to the MFD, and provide your own baud rate methods
>> within the standard 8250 layer
>
> Ouch, somehow I missed this one!
>
> Peter, Alan's suggestion is really worth to try.
>

Thanks for point this. It seems good to probe on MFD driver, them MFD
register platform devices to invoke platform driver to initialize
sub-parts. I'll try to survey first.

But I had a new question, If I really do it with MFD subsystem, it'll
split into 3 parts, MFD probe(driver/mfd) / GPIO (driver/gpio) / UART
(drivers/tty/serial/8250). It'll cross more than 2 subsystems and=20
maintainers How should I do to organize the patches?

=46or examples, I should remove the probe function in 8250_pci.c and
move it to new MFD file. It should organize it in the same patch as Pau=
l
said, but this patch will need 2 subsystem maintainer to do with the
same patch, it seems weird.

Andy had cc "[PATCH v5] serial: 8250: add gpio support to exar" to me,
could I use the same way to do GPIOLIB? First add a platform driver
for F81504 gpio and add platform device into 8250_pci.c? It seems to
be good and simple to implement.

--=20
With Best Regards,
Peter Hung
