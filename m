From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
Date: Fri, 20 Sep 2019 22:15:10 +0200
Message-ID: <d5e07b37-c295-91d0-30b4-b12065d2d302@gmail.com>
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <79c9533f-882d-f2b2-b6f3-b94fa49b4367@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79c9533f-882d-f2b2-b6f3-b94fa49b4367@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 9/20/19 10:50 AM, Hans de Goede wrote:
> Also I will give this a test-run on some of the existing devices
> which rely on the instantiation of serdev devices for ACPI
> devices which are childs of the uart device.

Thank you for testing! Will get to your other mail shortly.

> Given the above I think you may want to also limit your patch to
> only instantiate a "struct device" for the first UARTSerialBusV2
> in an ACPI "Device()"'s  .

Right, I will change this for a v2 once the issue revealed by your
testing has been resolved.

> I hope this sheds some clarity on the (muddy) situation wrt
> I2cSerialBusV2 handling.

Thank you again, this has definitely helped clear things up for me and
your write-up is much appreciated!

Maximilian
