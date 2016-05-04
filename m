From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Wed, 4 May 2016 12:48:22 +0300
Message-ID: <CAHp75VfV5qJgfW92eTqOKg8AOvBXy=KqeRU=ZZ+rfXgQYXwAmA@mail.gmail.com>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<20160503225550.GA6599@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160503225550.GA6599@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, May 4, 2016 at 1:55 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Apr 27, 2016 at 04:48:03PM +0300, Andy Shevchenko wrote:
>> This is combined series of two things:
>> - split out the Intel LPSS specific driver from 8250_pci into 8250_lpss
>> - enable DMA support on Intel Quark UART
>>
>> The patch has been tested on few Intel SoCs / platforms. In any case I would
>> like to ask Bryan to do independent test.
>>
>> This is targeting serial subsystem, thus it would be nice to get and Ack from
>> Vinod first. Moreover, the series depends on [1] that is now under review. On
>> the other hand Vinod proposed to take it through dma-slave tree. Greg?
>
> I think if you don't take them through the tty tree, you might have
> merge issues :(

I see,

> Also, I don't have the full series in my mbox, can you resend the whole
> thing please?  Or did not all patches get sent to me?

I will resend soon an updated version anyway: Bryan reviewed it and we
have already two patches in your tree that prevents to apply smoothly.

> I'm dropping this from my queue now,

Hope, not for long.

-- 
With Best Regards,
Andy Shevchenko
