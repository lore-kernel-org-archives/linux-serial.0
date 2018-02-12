From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Date: Mon, 12 Feb 2018 14:34:29 +0100
Message-ID: <20180212133429.GC25314@hirez.programming.kicks-ass.net>
References: <20180118150951.28964-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180118150951.28964-1-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 18, 2018 at 10:09:51AM -0500, Prarit Bhargava wrote:
>  config ACPI_SPCR_TABLE
> +	bool "ACPI Serial Port Console Redirection Support"
> +	default y if X86
> +	help
> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
> +	  This table provides information about the configuration of the
> +	  earlycon console.

I just got asked this by oldconfig, which left me rather puzzled, WTF
does this do?
