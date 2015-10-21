From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] Add AMBA bus probing support to ACPI
Date: Thu, 22 Oct 2015 00:29:53 +0200
Message-ID: <CAJZ5v0g8ce-_+6yA26CZpNq6XvYw5qVhhu6hB0vxnnWbHEhNHA@mail.gmail.com>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
	<5627C041.6090001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5627C041.6090001@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, shannon.zhao@linaro.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 21, 2015 at 6:41 PM, Al Stone <ahs3@redhat.com> wrote:
> On 09/30/2015 04:38 AM, Graeme Gregory wrote:
>> As discussed when Shannon Zhao sent a patch to add platform_device support
>> to pl061 driver. Russel and other maintainers prefered that ACPI learned
>> how to create AMBA devices rather than converting/adding platform_device
>> support to AMBA drivers.
>>
>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/431364
>>
>> 1) Adds basic AMBA device probing support to ACPI, it uses a whitelist of
>> device IDs as the number of AMBA devices is limited. Currently the two ids
>> present are those used in QEMU for arm64.
>>
>> 2) Adds the plumbing into ACPI probe sequence.
>>
>> 3) From ACPI pl011 is only defined (SBSA document) to be in SBSA mode which has
>> reduced functionality. There may be a better method to do this that I have
>> overlooked.
>>
>> Thanks
>>
>> Graeme
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Any comments on these patches?  It's been awful quiet....

That's because of my limited review bandwidth.

I'm kind of in the middle of travel now, sorry about that.

Thanks,
Rafael
