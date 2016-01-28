From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V2 4/4] serial: 8250_pci: Remove Fintek F81504/508/512
 UART driver
Date: Thu, 28 Jan 2016 14:04:17 +0200
Message-ID: <1453982657.2521.287.camel@linux.intel.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
	 <1453972838-30268-5-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453972838-30268-5-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-01-28 at 17:20 +0800, Peter Hung wrote:
> Remove Fintek F81504/508/512 PCIE-to-UART device driver from
> 8250_pci.c
> 
> Paul recommed us do less code deletion to avoid confusing problem
> when
> bisect.
> https://lkml.org/lkml/2016/1/18/646
> 
> 


> -	/* Fintek PCI serial cards */
> -	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
> -	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
> -	{ PCI_DEVICE(0x1c29, 0x1112), .driver_data = pbn_fintek_12
> },

Shouldn't you blacklist them in 8250_pci?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
