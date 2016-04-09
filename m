From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 00/12] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Sat, 9 Apr 2016 20:48:08 +0300
Message-ID: <CAHp75VcQiDrP-n0WDbfj4NnWGtSJpvoTQPxm6Q23nNnOGcxcLw@mail.gmail.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1460220789.19152.5.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460220789.19152.5.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 9, 2016 at 7:53 PM, Bryan O'Donoghue
<pure.logic@nexus-software.ie> wrote:
> On Thu, 2016-04-07 at 23:37 +0300, Andy Shevchenko wrote:
>> This is combined series of two things:
>>  - split out the Intel LPSS specific driver from 8250_pci into
>> 8250_lpss
>>  - enable DMA support on Intel Quark UART
>>
>> The patch has been tested on few Intel SoCs / platforms.
>>
>> This is targeting serial subsystem, thus it would be nice to get and
>> Ack from Vinod first.
>> Moreover, the series depends on series [1] that is now under review.
>>
>> That's why I ask Vinod to create immutable tag / branch for the [1]
>> and the
>> dependants (at least one more, which is sata_dwc_460ex).
>>
>> [1] http://www.spinics.net/lists/dmaengine/msg08709.html
>
> Andy.
>
> Which tree/branch exactly are you applying this against ? I'd like to
> test it out on Galileo.
>

It's based on linux-next. it would be nice to have your tag / comments!

> Could you give a link ?
>

You may try my branch
https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk

> ---
> bod
>



-- 
With Best Regards,
Andy Shevchenko
