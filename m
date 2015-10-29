From: Shannon Zhao <shannon.zhao@linaro.org>
Subject: Re: [PATCH 0/3] Add AMBA bus probing support to ACPI
Date: Thu, 29 Oct 2015 22:47:22 +0800
Message-ID: <5632317A.40607@linaro.org>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Shannon Zhao <zhaoshenglong@huawei.com>
List-Id: linux-serial@vger.kernel.org



On 2015/9/30 18:38, Graeme Gregory wrote:
> As discussed when Shannon Zhao sent a patch to add platform_device support
> to pl061 driver. Russel and other maintainers prefered that ACPI learned
> how to create AMBA devices rather than converting/adding platform_device
> support to AMBA drivers.
>
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/431364
>
> 1) Adds basic AMBA device probing support to ACPI, it uses a whitelist of
> device IDs as the number of AMBA devices is limited. Currently the two ids
> present are those used in QEMU for arm64.
>
> 2) Adds the plumbing into ACPI probe sequence.
>
> 3) From ACPI pl011 is only defined (SBSA document) to be in SBSA mode which has
> reduced functionality. There may be a better method to do this that I have
> overlooked.
>
Thanks. I test this patchset with PL061 on QEMU for arm64 through below 
patchset[1]. It works well.

Tested-by: Shannon Zhao <shannon.zhao@linaro.org>

[1] 
https://git.linaro.org/people/shannon.zhao/qemu.git/shortlog/refs/heads/PowerButton_v2

-- 
Shannon
