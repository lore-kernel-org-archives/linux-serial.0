From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Date: Mon, 22 Jan 2018 15:49:43 -0600
Message-ID: <745c9e29-f0b4-775b-28f7-8712cdc90fe1@codeaurora.org>
References: <20180118150951.28964-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20180118150951.28964-1-prarit@redhat.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

On 01/18/2018 09:09 AM, Prarit Bhargava wrote:
>   	if (acpi_disabled) {
> -		if (earlycon_init_is_deferred)
> +		if (earlycon_acpi_spcr_enable)

This patch works for me, so I can ACK it, but first you might want to 
rename earlycon_acpi_spcr_enable, because these two lines don't make 
much sense.

"If ACPI is disabled, and ACPI SCPR is enabled, then ...."

If ACPI is disabled, then how can a variable called 
"earlycon_acpi_spcr_enable" be true?

Would it make more sense to rename it to earlycon_spcr_enable?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
