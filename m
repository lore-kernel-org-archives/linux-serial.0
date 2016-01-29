From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Fri, 29 Jan 2016 08:21:48 +0000
Message-ID: <20160129082148.GR3368@x1>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453982106.2521.279.camel@linux.intel.com>
 <56AAFD88.2060505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56AAFD88.2060505@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, jslaby@suse.com, peter_hong@fintek.com.tw, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 29 Jan 2016, Peter Hung wrote:
> >>+obj-$(CONFIG_MFD_FINTEK_F81504_CORE)	+=3D f81504-core.o
> >
> >I think '_' is better than '-'. What I saw and usually do is '_' for
> >regular source modules and '-' for the resulting objects when they h=
ave
> >more than one file.
>=20
> I used f81504_core.c originally, but I found most of files are named
> xxx-ooo.c when I try to modify makefile. Should I change it to
> f81504_core.c ??

I prefer '-' in MFD.

> >>+#define F81504_DEV_DESC		"Fintek F81504/508/512 PCIE-
> >>to-UART core"
> >
> >Do you need this definition? Is it used more than once?
>=20
> ok, I'll direct use the string without define.

Please rid all of the {DEV_NAME,DEV_DEC} defines, they only serve to
obfuscate code.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
