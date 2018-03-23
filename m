From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/5] Bluetooth: hci_bcm: Add irq_polarity module option
Date: Fri, 23 Mar 2018 12:30:31 +0100
Message-ID: <c9626a22-1ea3-b99e-1863-689a9076c834@redhat.com>
References: <20180316202811.5678-1-hdegoede@redhat.com>
 <a5553246-d39c-8d3a-430e-2b8fea3b7732@redhat.com>
 <3ECCC2D8-93CF-4A37-AA12-EE991EF1B7E3@holtmann.org>
 <564f71d3-c9ab-c383-cd40-fe3edf92e9cf@redhat.com>
 <D1968341-EFFB-4D3D-94D4-521DB1BD01B1@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <D1968341-EFFB-4D3D-94D4-521DB1BD01B1@holtmann.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Marcel,

On 23-03-18 12:23, Marcel Holtmann wrote:
> Hi Hans,
> 
>>>>> Add irq_polarity module option for easier troubleshooting of irq-polarity
>>>>> issues.
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> Marcel, is there any reason why this (bug-fix) series is not merged
>>>> yet? Any review remarks I missed?
>>> I was waiting for net to be merged back into net-next so that I don’t have to deal with conflicts.
>>
>> Ah ok, no problem. I was just wondering if there was anything
>> I needed to do.
> 
> I would really like to move over to using btuart.c that I posted a few days ago, but that will be obviously more work and maybe it is good to stabilize and simplify this inside hci_bcm.c first.

Yes I already saw your remark about this a few days ago. I do think that
moving to btuart.c eventually is a good idea, but your RFC seemed somewhat
feature incomplete. Mainly lacking the runtime-pm stuff, which is not
only needed for powersaving, but on some machines the shutdown gpio
defaults to "off", so the bluetooth won't work until we at a minimum
have added gpio support to btuart.c.

So for now I would like to get things fixed in hci_bcm.c first, as
you suggest. This will also allow easily getting the IRQ polarity and
missing IDs (at least those IDs which are confirmed to be actually
used) fixed in current stable kernels.

I'm afraid I don't have time to help much with btuart.c my hci_bcm.c
work is a small part of a project I'm working on to better support
Bay and Cherry Trail devices and that project itself is a personal
side-project. But when btuart.c is more feature complete I would be
happy to test it on various devices I own which have an uart attach
broadcom bt device.

Regards,

Hans
