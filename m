From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Tue, 21 Jun 2016 18:46:23 +0300
Message-ID: <CAHp75VccNzvJoWCs9b+47m5oUkOr22s5V2EukUh2N+W8MXNyvw@mail.gmail.com>
References: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1466521805.520.266.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466521805.520.266.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 21, 2016 at 6:10 PM, Bryan O'Donoghue
<pure.logic@nexus-software.ie> wrote:
> On Mon, 2016-06-20 at 12:17 +0300, Andy Shevchenko wrote:
>> This is combined series of two things:
>> - split out the Intel LPSS specific driver from 8250_pci into
>> 8250_lpss
>> - enable DMA support on Intel Quark UART
>>
>> The patch has been tested on few Intel SoCs / platforms. In any case
>> I would
>> like to ask Bryan to do independent test.
>>
>> This is targeting serial subsystem, and it has necessary Ack from
>> Vinod.
>>
>> The series can be reached in the branch located at [2].
>>
>> [1] http://www.spinics.net/lists/kernel/msg2244475.html
>> [2] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk
>>
>> Bryan, since this series doesn't include any DMA management quirks I
>> didn't
>> address it. It is a matter of the following series which I would send
>> later.
>
> OK I'm not 100% happy with that but I trust you to do it.
>
> For the series.
>
> Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

Thanks!

-- 
With Best Regards,
Andy Shevchenko
