From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 1/2] acpi, spcr: Make SPCR avialable to other
 architectures
Date: Thu, 14 Dec 2017 15:49:43 +0000
Message-ID: <20171214154943.GA29588@e107981-ln.cambridge.arm.com>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-2-prarit@redhat.com>
 <20171213124533.GA32362@red-moon>
 <d967861e-9f83-689c-2b14-58d7450c848b@codeaurora.org>
 <20171214103027.GB697@e107981-ln.cambridge.arm.com>
 <6541a055-bfd4-daa7-5b91-38384bd65c3f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6541a055-bfd4-daa7-5b91-38384bd65c3f@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 14, 2017 at 08:08:08AM -0600, Timur Tabi wrote:
> On 12/14/17 4:30 AM, Lorenzo Pieralisi wrote:
> >>I didn't want to put any ACPI code in amba-pl011.c, so putting it in spcr.c
> >>made the most sense.  I agree the global variable is ugly.  If you have a
> >>better idea, I'm all ears.
> 
> >I told you my idea. It could have been made easier by reusing the
> >ACPI_DECLARE_PROBE_ENTRY() mechanism.
> 
> Sorry, I don't mean to be difficult, but when did you tell *me* this idea of
> yours?  I don't see any email from you to me that mentions

I said that IMO it would have been better if the quirk was managed in
amba-pl011.c - you had your reasons not to do it, end of the story.

> ACPI_DECLARE_PROBE_ENTRY().  I've never even heard of that macro before.
> Please note that I'm not the original author of this code.

It is what it is, let's move on, we will keep this in mind if a similar
quirk is required.

Thanks,
Lorenzo
