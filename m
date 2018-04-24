From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC][PATCH 0/1] serdev: Support HS-UART serdev slaves over tty
Date: Tue, 24 Apr 2018 23:16:38 +0200
Message-ID: <b4947b3c-15b3-15ea-e1b7-38169f11d0f9@redhat.com>
References: <20180424082954.11453-1-shrirang.bagul@canonical.com>
 <20180424171846.GD4615@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424171846.GD4615@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, Rob Herring <robh@kernel.org>, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 24-04-18 19:18, Johan Hovold wrote:
> [ Adding some more people on CC. ]
> 
> On Tue, Apr 24, 2018 at 04:29:53PM +0800, Shrirang Bagul wrote:
>> On systems using Intel Atom (Baytrail-I) SoC's, slave devices connected on
>> HSUART1/2 ports are described by the ACPI BIOS as virtual hardware using
>> HID's INT3511/INT3512 [1].
>>
>> As a consequence, HW manufacturers have complete freedom to install any
>> devices on-board as long as they can be accessed over serial tty
>> interface. Once such device is Dell Edge 3002 IoT Gateway which sports
>> ZigBee & GPS devices on the HS-UART ports 1 & 2 respectively.
>>
>> In kernels before the introduction of 'Serial Device Bus (serdev)'
>> subsystem, these devices were accessible using /dev/ttySx nodes. But,
>> kernels since 4.15 can no longer do so.
>>
>> Post 4.15, with CONFIG_SERIAL_DEV_BUS=y, serdev port controller driver
>> handles the enumeration for the slaves connected on these ports. Also,
>> /dev/ttySx device nodes for these ports are no longer exposed to the
>> userspace.
>>
>> This patch implements a new driver which binds to the ACPI serdev slaves
>> enumerated by the serdev port controller and exposes /dev/ttyHSx device
>> nodes which the userspace applications can use. Otherwise, upgrades to 4.15
>> or higher kernels would certainly render these devices unusable.
>>
>> Considering serdev is new and evolving, this is one approach to solving
>> the problem at hand. An obvious drawback is the change in the tty device
>> node name from ttySx => ttyHSx, which means userspace applications have to
>> be modified (I know that this is strongly discouraged). For the same
>> reason, I am submitting these patches as RFC.
>>
>> If there are other/better ways of solving this or improving on the
>> proposed solution, that will be most helpful.
> 
> Yeah, I don't think this is the right solution to this problem. It seems
> we need to blacklist (or maybe even use whitelists) ACPI-ids until there
> are drivers for the slave devices that would otherwise be claimed by
> serdev.

FWIW I've been using this patch for a while for realtek UART attached bluetooth:
https://github.com/jwrdegoede/linux-sunxi/commit/bc904e3703940600ca66c65fcdb0a8cb01dff55d
which is a gross hack.

If we're going to do a whitelist for this, it better support some sort of
wildcards as there are a LOT of BCM2E?? devices which need to be on the
whitelist. I think a blacklist would actually be better though, this also
documents which devices are lacking a proper kernel (where applicable).

Regards,

Hans


> 
>> This patch is based on:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v4.17-rc2
>>
>> [1] Enabling Multi-COM Port for Microsoft Windows OS 8.1 & 10 / IoT Core [Sec. 4.1]
>> (https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/enabling-multi-com-port-white-paper.pdf)
> 
> Thanks,
> Johan
> 
