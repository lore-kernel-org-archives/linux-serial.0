From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [RFC 0/5] console/acpi: add DBG2 and SPCR console configuration
Date: Tue, 12 Jan 2016 10:14:09 -0500
Message-ID: <56951841.4010101@codeaurora.org>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Leif Lindholm <leif.lindholm@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, graeme.gregory@linaro.org
Cc: mark.rutland@arm.com, al.stone@linaro.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, torez@redhat.com, lv.zheng@intel.com, Timur Tabi <timur@quicinc.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 09/08/2015 08:43 AM, Leif Lindholm wrote:
> Support for configuring bootconsole and console via the ACPI tables
> DBG2 (Debug Port Table 2) [1] and SPCR (Serial Port Console Redirection
> Table) [2], defined by Microsoft, has been discussed on and off over the
> years.
> 
> [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
> [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
> 
> Licensing concerns have prevented this happening in the past, but as of
> 10 August 2015, these tables have both been released also under OWF 1.0
> (http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0)
> which is think is noncontroversially GPL-compatible?
> 
> This set is a first attempt at implementing this.
> 
> Submitting as an RFC since the SPCR handling currently depends on the
> console driver being initialized after subsystem initcalls. Workaround
> to enable testing surrounding infrastructure in 5/5, _really_ not
> intended to be merged.
> (Suggestions for acceptable ways of working around this appreciated.)

What's required for this to graduate from RFC status? Is anyone working
on it?

Thanks,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
