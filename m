From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v10 3/4] ARM64: ACPI: enable ACPI_SPCR_TABLE
Date: Tue, 13 Sep 2016 14:45:56 -0400
Message-ID: <1473792356.31972.0.camel@redhat.com>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
         <20160905123617.18775-4-aleksey.makarov@linaro.org>
         <7e5486cc-4080-2d1e-8f6d-98874379887d@gmail.com>
         <20160908111654.GH1493@arm.com> <1473352456.21193.8.camel@redhat.com>
         <706e4bc9-1010-ba2d-55ec-dc6f24611bd3@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <706e4bc9-1010-ba2d-55ec-dc6f24611bd3@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Aleksey Makarov <amakarov.linux@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Yury Norov <ynorov@caviumnetworks.com>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-09-09 at 17:28 +0800, Hanjun Guo wrote:
> On 2016/9/9 0:34, Mark Salter wrote:
> > 
> > On Thu, 2016-09-08 at 12:16 +0100, Will Deacon wrote:
> > > 
> > > On Wed, Sep 07, 2016 at 12:30:19PM +0300, Aleksey Makarov wrote:
> > > > 
> > > > 
> > > > 
> > > > On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
> > > > > 
> > > > > 
> > > > > SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64
> > > > > 
> > > > > Earlycon should be set up as early as possible.  ACPI boot tables are
> > > > > mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() that
> > > > > is called from setup_arch() and that's where we parse SPCR.
> > > > > So it has to be opted-in per-arch.
> > > > > 
> > > > > When ACPI_SPCR_TABLE is defined initialization of DT earlycon is
> > > > > deferred until the DT/ACPI decision is done.  Initialize DT earlycon
> > > > > if ACPI is disabled.
> > > > Hi Will, Catalin,
> > > > 
> > > > Can you review this patch and consider ACKing it please?
> > > Hanjun, Al, Mark, Graeme -- any comments on this?
> > > 
> > > Will
> > I think there is a problem still with systems using 32-bit access to 8250
> > UARTs (i.e. Mustang) but that will need a DBG2 table spec change and
> > followup patch to resolve.
> Hmm, I think you mean we can add patches later with the spec updated,
> and this patch works with SBSA pl011 can go for now?

Yes, I think this series is fine for now.

> 
> Thanks
> Hanjun

