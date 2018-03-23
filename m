From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/5] Bluetooth: hci_bcm: Add irq_polarity module option
Date: Fri, 23 Mar 2018 12:17:25 +0100
Message-ID: <564f71d3-c9ab-c383-cd40-fe3edf92e9cf@redhat.com>
References: <20180316202811.5678-1-hdegoede@redhat.com>
 <a5553246-d39c-8d3a-430e-2b8fea3b7732@redhat.com>
 <3ECCC2D8-93CF-4A37-AA12-EE991EF1B7E3@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <3ECCC2D8-93CF-4A37-AA12-EE991EF1B7E3@holtmann.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 23-03-18 12:16, Marcel Holtmann wrote:
> Hi Hans,
> 
>>> Add irq_polarity module option for easier troubleshooting of irq-polarity
>>> issues.
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Marcel, is there any reason why this (bug-fix) series is not merged
>> yet? Any review remarks I missed?
> 
> I was waiting for net to be merged back into net-next so that I don’t have to deal with conflicts.

Ah ok, no problem. I was just wondering if there was anything
I needed to do.

Regards,

Hans
