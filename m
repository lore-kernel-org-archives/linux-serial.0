From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH/RFC 3/8] of: Add helper function to check MMIO register endianness
Date: Wed, 12 Nov 2014 01:04:08 -0800
Message-ID: <CAJiQ=7ADy1U60R-o1soMyqYWXqw2OqQg7vfB9L5pzeac+Yv=SA@mail.gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
 <1415781993-7755-4-git-send-email-cernekee@gmail.com> <54631F64.8080009@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:35958 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbaKLJE3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:04:29 -0500
In-Reply-To: <54631F64.8080009@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Nov 12, 2014 at 12:50 AM, Jiri Slaby <jslaby@suse.cz> wrote:
>>  /**
>> + *  of_device_is_big_endian - check if a device has BE registers
>> + *
>> + *  @device: Node to check for availability

Oops, just noticed a copy/paste error here.

>> + *
>> + *  Returns 1 if the device has a "big-endian" property, or if the kernel
>> + *  was compiled for BE *and* the device has a "native-endian" property.
>> + *  Returns 0 otherwise.
>> + *
>> + *  Callers would nominally use ioread32be/iowrite32be if
>> + *  of_device_is_big_endian() == 1, or readl/writel otherwise.
>> + */
>> +int of_device_is_big_endian(const struct device_node *device)
>> +{
>> +     if (of_property_read_bool(device, "big-endian"))
>> +             return 1;
>> +     if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
>> +         of_property_read_bool(device, "native-endian"))
>> +             return 1;
>> +     return 0;
>> +}
>
> This should actually return bool and use true/false.

Well, the other APIs currently return an int:

extern int of_device_is_compatible(const struct device_node *device,
                                   const char *);
extern int of_device_is_available(const struct device_node *device);
[...]
extern int of_machine_is_compatible(const char *compat);

Do you think it is best to change all of them at once, or just the
newly introduced function?
