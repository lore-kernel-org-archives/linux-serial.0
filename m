From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/2] acpi, x86: Add SPCR table support
Date: Mon, 11 Dec 2017 15:42:18 +0100
Message-ID: <20171211144218.fcycoxibyln5f44x@gmail.com>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171208062925.64ov23u7oxmdfzyk@gmail.com>
 <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-serial@vger.kernel.org


* Prarit Bhargava <prarit@redhat.com> wrote:

> If I disable "Serial Port Console Debug" in my BIOS I still see the SPCR configured:
> 
> [root@prarit-lab ~]# dmesg | grep SPCR
> [    0.000000] ACPI: SPCR 0x0000000069031000 000050 (v01
> 00000000      00000000)
> 
> AFAICT the SPCR is always enabled on some systems.

Fair enough.

> > If so then we should pick up that serial console configuration and activate it, 
> > regardless of any kernel boot options!
> 
> I'm worried about someone who doesn't want a console on ttyS0 suddenly ending up
> with one.  The SPCR could contain incorrect data, etc.

Yeah, that's not good.

Thanks,

	Ingo
