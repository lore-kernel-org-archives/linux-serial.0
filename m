From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/3] Add AMBA bus probing support to ACPI
Date: Wed, 21 Oct 2015 10:41:37 -0600
Message-ID: <5627C041.6090001@redhat.com>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org
List-Id: linux-serial@vger.kernel.org

On 09/30/2015 04:38 AM, Graeme Gregory wrote:
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
> Thanks
> 
> Graeme
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Any comments on these patches?  It's been awful quiet....

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
