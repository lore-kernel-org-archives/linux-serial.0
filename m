From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v10 0/4] ACPI: parse the SPCR table
Date: Wed, 21 Sep 2016 12:37:49 +0200
Message-ID: <20160921103749.GA7993@kroah.com>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <25d32778-e708-6763-7cb2-4ddbeebc844b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <25d32778-e708-6763-7cb2-4ddbeebc844b@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 21, 2016 at 01:27:30PM +0300, Aleksey Makarov wrote:
> 
> 
> On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
> > 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port Console
> > Redirection Table) [2] as a mandatory ACPI table that specifies the
> > configuration of serial console.
> > 
> > Move "earlycon" early_param handling to earlycon.c to parse this option once
> > 
> > Parse SPCR table, setup earlycon and register specified console.
> > 
> > Enable parsing this table on ARM64.  Earlycon should be set up as early as
> > possible.  ACPI boot tables are mapped in
> > arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from setup_arch() and
> > that's where we parse spcr.  So it has to be opted-in per-arch. When
> > ACPI_SPCR_TABLE is defined initialization of DT earlycon is deferred until the
> > DT/ACPI decision is done.
> > 
> > Implement console_match() for pl011.
> 
> Hi Greg,
> 
> Can you consider picking this series for 4.9 please?

I thought you asked Rafael to take them, they are not in my queue
anymore because of that.  Don't try to shop-around for maintainers
please, that's kind of rude...

greg k-h
