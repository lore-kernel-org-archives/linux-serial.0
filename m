From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Date: Mon, 12 Feb 2018 08:47:57 -0500
Message-ID: <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180212133429.GC25314@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org



On 02/12/2018 08:34 AM, Peter Zijlstra wrote:
> On Thu, Jan 18, 2018 at 10:09:51AM -0500, Prarit Bhargava wrote:
>>  config ACPI_SPCR_TABLE
>> +	bool "ACPI Serial Port Console Redirection Support"
>> +	default y if X86
>> +	help
>> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
>> +	  This table provides information about the configuration of the
>> +	  earlycon console.
> 
> I just got asked this by oldconfig, which left me rather puzzled, WTF
> does this do?

Odd -- I thought I had taken care of that :(  My apologies Peter.

ACPI SPCR is used by a vendor to define the serial console for a system.  If
SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
parameters) and the console will work out-of-the-box.

The serial console configuration varies from vendor to vendor.  This takes the
guess-work out of defining a serial console.

P.

> 
