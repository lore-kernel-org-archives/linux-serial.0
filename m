From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Date: Mon, 12 Feb 2018 09:49:47 -0500
Message-ID: <7bd5897f-d6da-7e29-29c4-aa26d24f6355@redhat.com>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org



On 02/12/2018 09:43 AM, Timur Tabi wrote:
> On 2/12/18 7:47 AM, Prarit Bhargava wrote:
>> ACPI SPCR is used by a vendor to define the serial console for a system.  If
>> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
>> parameters) and the console will work out-of-the-box.
> 
> "earlycon" is needed only for an *early* console.  You don't need any command
> line parameters for a normal console to work with SPCR.

That's true on ARM64.  I specifically did not enable the console by default on
x86.  There are users who do not want a console active during boot & runtime.

P.

> 
