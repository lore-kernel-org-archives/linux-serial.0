From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 1/2] acpi, spcr: Make SPCR avialable to other
 architectures
Date: Thu, 14 Dec 2017 10:30:27 +0000
Message-ID: <20171214103027.GB697@e107981-ln.cambridge.arm.com>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-2-prarit@redhat.com>
 <20171213124533.GA32362@red-moon>
 <d967861e-9f83-689c-2b14-58d7450c848b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d967861e-9f83-689c-2b14-58d7450c848b@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 13, 2017 at 03:11:33PM -0600, Timur Tabi wrote:
> On 12/13/2017 06:45 AM, Lorenzo Pieralisi wrote:
> >>+/*
> >>+ * Erratum 44 for QDF2432v1 and QDF2400v1 SoCs describes the BUSY bit as
> >>+ * occasionally getting stuck as 1. To avoid the potential for a hang, check
> >>+ * TXFE == 0 instead of BUSY == 1. This may not be suitable for all UART
> >>+ * implementations, so only do so if an affected platform is detected in
> >>+ * acpi_parse_spcr().
> >>+ */
> >>+bool qdf2400_e44_present;
> >>+EXPORT_SYMBOL(qdf2400_e44_present);
> >
> >My eyes, this is horrible but it is not introduced by this patch. It
> >would have been much better if:
> >
> >drivers/tty/serial/amba-pl011.c
> >
> >parsed the SPCR table (again) to detect it instead of relying on this
> >horrible exported flag.
> 
> I didn't want to put any ACPI code in amba-pl011.c, so putting it in spcr.c
> made the most sense.  I agree the global variable is ugly.  If you have a
> better idea, I'm all ears.

I told you my idea. It could have been made easier by reusing the
ACPI_DECLARE_PROBE_ENTRY() mechanism.

> If it's any consolation, this erratum affects only 1.x silicon, which is
> technically pre-production (although a lot of people have them).  This
> work-around will eventually be reverted.

The sooner the better.

Lorenzo
