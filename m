From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/2] acpi, x86: Add SPCR table support
Date: Fri, 8 Dec 2017 07:29:25 +0100
Message-ID: <20171208062925.64ov23u7oxmdfzyk@gmail.com>
References: <20171207172912.17868-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207172912.17868-1-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-serial@vger.kernel.org


* Prarit Bhargava <prarit@redhat.com> wrote:

> The SPCR (Serial Port Console Redirection) Table provides information
> about the configuration of serial port.  This information can be used
> to configure the early console.

s/about the configuration of serial port
 /about the configuration of the serial port

> SPCR support was added for arm64 and is made available across all arches
> in this patchset.  The first patch adds a weak per-arch configuration function
> and moves the SPCR code into ACPI.  The second patch adds support to x86.
> 
> The existing behaviour on arm64 is maintained.  If the SPCR exists the
> earlycon and console are automatically configured.

s/arm64
 /ARM64

which is easier to read and it's also the prevalent spelling:

 triton:~/tip> for N in $(git grep -ih arm64 arch/arm64/ | sed 's/[[:punct:]]/ /g'); do echo $N | grep -iw arm64; done | sort | uniq -c
     412 arm64
       1 Arm64
     854 ARM64

> The existing default behaviour on x86 is also maintained.  If no console or
> earlycon parameter is defined and the SPCR exists , the serial port is not
> configured.  If the earlycon parameter is used both the early console
> and the console are configured using the data from the SPCR.

s/exists , the
 /exists, the

But, the logic to not use the SPCR looks confusing to me.

The SPCR is only present if the user has explicitly configured a serial console 
for that machine, either in the firmware, or remotely via IPMI, correct? I.e. SPCR 
will not be spuriously present by default on systems that have a serial console 
but the user never expressed any interest for them, right?

If so then we should pick up that serial console configuration and activate it, 
regardless of any kernel boot options!

Thanks,

	Ingo
