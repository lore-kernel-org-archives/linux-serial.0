From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 1/2] acpi, spcr: Make SPCR avialable to other
 architectures
Date: Thu, 14 Dec 2017 08:08:08 -0600
Message-ID: <6541a055-bfd4-daa7-5b91-38384bd65c3f@codeaurora.org>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-2-prarit@redhat.com> <20171213124533.GA32362@red-moon>
 <d967861e-9f83-689c-2b14-58d7450c848b@codeaurora.org>
 <20171214103027.GB697@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20171214103027.GB697@e107981-ln.cambridge.arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

On 12/14/17 4:30 AM, Lorenzo Pieralisi wrote:
>> I didn't want to put any ACPI code in amba-pl011.c, so putting it in spcr.c
>> made the most sense.  I agree the global variable is ugly.  If you have a
>> better idea, I'm all ears.

> I told you my idea. It could have been made easier by reusing the
> ACPI_DECLARE_PROBE_ENTRY() mechanism.

Sorry, I don't mean to be difficult, but when did you tell *me* this 
idea of yours?  I don't see any email from you to me that mentions 
ACPI_DECLARE_PROBE_ENTRY().  I've never even heard of that macro before. 
  Please note that I'm not the original author of this code.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
