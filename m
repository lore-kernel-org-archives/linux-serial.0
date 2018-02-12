From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Date: Mon, 12 Feb 2018 16:44:34 +0100
Message-ID: <20180212154434.GX25201@hirez.programming.kicks-ass.net>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <20180212145652.GM25181@hirez.programming.kicks-ass.net>
 <03e799c6-a0f3-eccf-882d-78205e9335ad@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <03e799c6-a0f3-eccf-882d-78205e9335ad@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 12, 2018 at 10:18:06AM -0500, Prarit Bhargava wrote:
> > But when I specify "earlyprintk=serial,ttyS0,115200" this SPCR crud will
> > not interfere?
> > 
> 
> I tested "earlyprintk=serial,ttyS0,115200" on a system which is known to have a
> functional console with "console=ttyS0,1152008N1" both with and without
> CONFIG_ACPI_SPCR_TABLE enabled.

OK, but my point was that SPCR will never override explicit earlyprintk
stuff. There is absolutely nothing worse than breaking working setups.
