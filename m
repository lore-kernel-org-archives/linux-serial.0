From: Leif Lindholm <leif.lindholm@linaro.org>
Subject: Re: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
Date: Mon, 11 Sep 2017 12:05:22 +0100
Message-ID: <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net>
References: <20160927151953.GB4371@kroah.com>
 <20160927205418.31529-1-aleksey.makarov@linaro.org>
 <20160927205418.31529-2-aleksey.makarov@linaro.org>
 <mvmzia1bnvu.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mvmzia1bnvu.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

I'm afraid Aleksey is no longer assigned to Linaro (you will probably
have seen a bounce).

On Mon, Sep 11, 2017 at 11:11:49AM +0200, Andreas Schwab wrote:
> On Sep 27 2016, Aleksey Makarov <aleksey.makarov@linaro.org> wrote:
> 
> > 'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
> > Console Redirection Table) [2] as a mandatory ACPI table that
> > specifies the configuration of serial console.
> >
> > Defer initialization of DT earlycon until ACPI/DT decision is made.
> >
> > Parse the ACPI SPCR table, setup earlycon if required,
> > enable specified console.
> 
> How can I tell the kernel to ignore this table and use the console on
> the command line instead?

I guess we could just ignore the table completely
	if (console_set_on_cmdline)
like its counterpart in of_console_check().

Like so (not tested beyond compile testing):

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 324b35bfe781..c3cf0f1ebb8f 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -96,6 +96,9 @@ int __init parse_spcr(bool earlycon)
        int baud_rate;
	        int err;

+       if (console_set_on_cmdline)
+               return 0;
+
        if (acpi_disabled)
	                return -ENODEV;

Are you asking because you want to use a different console in a lab
setup or because there are issues with SPCR on your platform?

/
    Leif
