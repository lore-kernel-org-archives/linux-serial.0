From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 3/5] acpi/serial: add DBG2 earlycon support
Date: Wed, 9 Sep 2015 10:36:59 +0100
Message-ID: <20150909093659.GA15606@leverpostej>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <1441716217-23786-4-git-send-email-leif.lindholm@linaro.org>
 <20150908130951.GE20562@leverpostej>
 <20150908170307.GP10728@bivouac.eciton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150908170307.GP10728@bivouac.eciton.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "torez@redhat.com" <torez@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

> > > +#ifdef CONFIG_SERIAL_EARLYCON
> > > +static int use_earlycon __initdata;
> > > +static int __init setup_acpi_earlycon(char *buf)
> > > +{
> > > +	if (!buf)
> > > +		use_earlycon = 1;
> > > +
> > > +	return 0;
> > > +}
> > > +early_param("earlycon", setup_acpi_earlycon);
> > 
> > It seems a shame to add this after folding the OF case into the earlycon
> > code. What necessitates this being a separate early_param? Why is it too
> > early to parse DBG2?
> 
> Currently, we don't even know where our ACPI tables are  at this point
> (efi_init() is called two functions after parse_early_param() in
> setup_arch). More specifically, because acpi_boot_table_init() is
> called even later than that.
> 
> If we moved both of those earlier, we could drop the extra earlycon
> param handling for ACPI. That would of course reduce the ability to
> have dynamically configurable debug messages for both of these.

Ok. Would you be able to put something in the commit message regarding
the above, to make it clear why we need this multi-step dance (and why
it's preferable to the alternative)?

Mark.
