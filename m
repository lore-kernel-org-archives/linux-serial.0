From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
Date: Mon, 23 Sep 2019 00:29:15 +0200
Message-ID: <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi all,

On 9/20/19 5:00 PM, Hans de Goede wrote:
> So as promised I've given this patch a try, unfortunately it breaks
> existing users of ACPI serdev device instantation.
> 
> After adding this patch "ls /sys/bus/serial/devices" is empty,
> where as before it gives:
> 
> [root@dhcp-45-50 ~]# ls -l /sys/bus/serial/devices/
> total 0
> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0 -> ../../../devices/pci0000:00/8086228A:00/serial0
> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0-0 -> ../../../devices/pci0000:00/8086228A:00/serial0/serial0-0
> 
> And since the serdev is missing bluetooth does not work.

Thanks to some testing by Hans, it turns out that the reason for this is
that acpi_walk_resources fails with AE_AML_INVALID_RESOURCE_TYPE for a
specific device. If anyone is interested, the _CRS of the device in
question is

     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
     {
         Name (NAM, Buffer (0x14)
         {
             "\\_SB.PCI0.SDHB.BRC1"
         })
         Name (SPB, Buffer (0x0C)
         {
             /* 0000 */  0x8E, 0x1D, 0x00, 0x01, 0x00, 0xC0, 0x02, 0x00,
             /* 0008 */  0x00, 0x01, 0x00, 0x00
         })
         Name (END, ResourceTemplate ()
         {
         })
         Concatenate (SPB, NAM, Local0)
         Concatenate (Local0, END, Local1)
         Return (Local1)
     }

To solve this, I propose ignoring errors that occur when evaluating the
_CRS method. Note that with the previously discussed change for v2,
where we will only look at the first device in _CRS, we should be able
to handle errors from the actual serdev device allocation separately
(and only ignore AML evaluation errors).

Further, I think it might also make sense to move the status and
already-enumerated checks out of acpi_serdev_register_device to before
looking at _CRS. On one hand, this might save us from unnecessarily
checking the _CRS on devices that are not present, but on the other
hand, moving the status check may cause more AML code execution, as we'd
be checking the status of every device, even if it doesn't have a _CRS.
Maybe a better solution would be something like: Check if device has
already been enumerated, then check for _CRS presence, then for
status/device-presence, and finally look at _CRS contents and
potentially allocate serdev client?

Regards,

Maximilian
