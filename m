From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / platform: Add support for build-in properties
Date: Thu, 10 Nov 2016 00:40:51 +0100
Message-ID: <CAJZ5v0iALibO6Nub_Q4oZvY+SgehTQHrAZQG32ar8R281_NyAw@mail.gmail.com>
References: <20161102154139.GD11523@kuha.fi.intel.com> <20161103142126.87413-1-heikki.krogerus@linux.intel.com>
 <1478448574.1591.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1478448574.1591.2.camel@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Feng Kan <fkan@apm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Nov 6, 2016 at 5:09 PM, J=C3=A9r=C3=B4me de Bretagne
<jerome.debretagne@gmail.com> wrote:
> Le jeudi 03 novembre 2016 =C3=A0 16:21 +0200, Heikki Krogerus a =C3=A9cri=
t :
>> We have a couple of drivers, acpi_apd.c and acpi_lpss.c,
>> that need to pass extra build-in properties to the devices
>> they create. Previously the drivers added those properties
>> to the struct device which is member of the struct
>> acpi_device, but that does not work. Those properties need
>> to be assigned to the struct device of the platform device
>> instead in order for them to become available to the
>> drivers.
>>
>> To fix this, this patch changes acpi_create_platform_device
>> function to take struct property_entry pointer as parameter.
>>
>> Fixes: 20a875e2e86e ("serial: 8250_dw: Add quirk for APM X-Gene SoC")
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> ---
>>
>> Hi,
>>
>> Found the problem, and this is my proposal for a fix.
>>
>> J=C3=A9r=C3=B4me, please test it when you have time.
>>
>
> Hi Heikki,
>
> I can confirm that this patch fixes the issue I've reported on the Lenovo
> ThinkPad 8 tablet. You were fast to find the root cause, impressive, real=
ly
> appreciated.
>
> Feel free to add:
> Tested-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
>
> Let's hope it can still make it during the remaining 4.9 rc timing.

It's in my linux-next branch now (it should hit linux-next on Friday)
and I'm going to push it for -rc5 if it doesn't lead to problems.

Thanks,
Rafael
