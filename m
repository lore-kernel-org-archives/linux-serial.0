From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Date: Mon, 12 Feb 2018 08:43:45 -0600
Message-ID: <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

On 2/12/18 7:47 AM, Prarit Bhargava wrote:
> ACPI SPCR is used by a vendor to define the serial console for a system.  If
> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
> parameters) and the console will work out-of-the-box.

"earlycon" is needed only for an *early* console.  You don't need any 
command line parameters for a normal console to work with SPCR.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
