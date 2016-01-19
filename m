From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Tue, 19 Jan 2016 16:45:55 +0800
Message-ID: <569DF7C3.5050306@gmail.com>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20160119035649.GA1696@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160119035649.GA1696@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Paul,

Paul Gortmaker =E6=96=BC 2016/1/19 =E4=B8=8A=E5=8D=88 11:56 =E5=AF=AB=E9=
=81=93:
>> The serial ports support from 50bps to 1.5Mbps with Linux baudrate
>> define excluding 1.0Mbps due to not support 16MHz clock source.
>
> How does this differ from what was achieved or possible with the old =
way
> of things?  What was the limitation in the existing 8250 code sharing
> that required Fintek code to fork and become independent?

The architecture of 8250_pci.c is good for PCIE device with 8250
compatible serial ports. We want to implement all functions of
=4681504/508/512, but it'll make 8250_pci.c bloated and complex if we
implement GPIOLIB in 8250_pci.c

Could I implement GPIOLIB within 8250_pci.c instead of a newer file?

> How much code was just copied 8250 boilerplate vs. being a new
> implementation?  The diffstat shows approx 500 lines of new code.  Wh=
at
> does that add vs. just copying?

Due to this IC contains 8250-compatible ports, the most functions is
copy from fintek section of 8250_pci.c. The differences are highbaud
rate & GPIOLIB implementations.

>
> If someone had 8250 (PCI) builtin before, and Fintek stops working,
> they will most guaranteed bisect to this commit above where you remov=
e
> support.  That is less than ideal.  We try to avoid code deletions or
> Kconfig addtions that will be obvious bisect magnets.

It can be prevented if implements GPIOLIB in 8250_pci.c.

>>    8250_fintek_pci: Add Fintek PCIE UART driver
>
> This creates a new Kconfig var. which is default=3Dm.  How does that =
work
> if people were using these for built-in early console support in the
> past?  Are these cards universal, or should it be default=3Dm if (...=
)
> based on a Kconfig where this hardware exists?

Thanks for point this out, for the early console I should make the
default mode to SERIAL_8250 if it need to split as a new file.

>>    8250_fintek_pci: Add GPIOLIB support
>
> What does this add?  The commit log is not at all clear.  Leaving me =
to
> ask if it does belong in the core PCI support code at all?  I honestl=
y
> don't know, since I don't know the hardware details here.  The commit
> long logs could go a long way to closing this knowledge gap if the 0/=
N
> listed the shortcomings and the 3/3 here indicated what the GPIO magi=
c
> had managed to add.

Sorry for the ambiguous logs. We'll implement GPIOLIB due to the
following circumstance.

Some H/W manufacturer use this IC and transform some port into GPIO
mode. The current 8250_pci.c not handle this so it maybe confuse
end-user.

> Again, this may be obvious to others, but the long logs should try an=
d
> give a hint to people on the fringe who maybe don't have all the
> specific Fintek hardware details when reading the logs.
>

I'll try to make more sense with long long.
Thanks for your advices,
--=20
With Best Regards,
Peter Hung
