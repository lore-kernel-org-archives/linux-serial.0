From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH v10 3/4] ARM64: ACPI: enable ACPI_SPCR_TABLE
Date: Fri, 9 Sep 2016 09:36:27 +0100
Message-ID: <20160909083627.GA7292@xora-monster>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <20160905123617.18775-4-aleksey.makarov@linaro.org>
 <7e5486cc-4080-2d1e-8f6d-98874379887d@gmail.com>
 <20160908111654.GH1493@arm.com>
 <1473352456.21193.8.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473352456.21193.8.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, Aleksey Makarov <amakarov.linux@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Yury Norov <ynorov@caviumnetworks.com>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Al Stone <ahs3@redhat.com>, linux-arm-kern
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 08, 2016 at 12:34:16PM -0400, Mark Salter wrote:
> On Thu, 2016-09-08 at 12:16 +0100, Will Deacon wrote:
> > On Wed, Sep 07, 2016 at 12:30:19PM +0300, Aleksey Makarov wrote:
> > > 
> > > 
> > > On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
> > > > 
> > > > SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64
> > > > 
> > > > Earlycon should be set up as early as possible.  ACPI boot tables are
> > > > mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() that
> > > > is called from setup_arch() and that's where we parse SPCR.
> > > > So it has to be opted-in per-arch.
> > > > 
> > > > When ACPI_SPCR_TABLE is defined initialization of DT earlycon is
> > > > deferred until the DT/ACPI decision is done.  Initialize DT earlycon
> > > > if ACPI is disabled.
> > > Hi Will, Catalin,
> > > 
> > > Can you review this patch and consider ACKing it please?
> > Hanjun, Al, Mark, Graeme -- any comments on this?
> > 
> > Will
> 
> I think there is a problem still with systems using 32-bit access to 8250
> UARTs (i.e. Mustang) but that will need a DBG2 table spec change and
> followup patch to resolve.
> 

We went over this with the HPE firmware people. The General Address
Structure has Register Bit Width and Access Size fields. If set
correctly then 8250 UART works.

AFAIK Moonshot firmware has this fix, I have no access to Mustang
firmware to verify on that platform.

Graeme
