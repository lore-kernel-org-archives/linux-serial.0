From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Tue, 7 Jun 2016 13:04:19 +0300
Message-ID: <CAHp75VczbhPEvp6gn-5hPFdSGscNeyZMzPQWeeB1Xza1mHD8dw@mail.gmail.com>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1463065601.17131.319.camel@linux.intel.com> <1463620733.4224.75.camel@nexus-software.ie>
 <1464111448.31269.67.camel@linux.intel.com> <1464113301.31269.79.camel@linux.intel.com>
 <1464280589.2351.19.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464280589.2351.19.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 26, 2016 at 7:36 PM, Bryan O'Donoghue
<pure.logic@nexus-software.ie> wrote:
> On Tue, 2016-05-24 at 21:08 +0300, Andy Shevchenko wrote:
>> On Tue, 2016-05-24 at 20:37 +0300, Andy Shevchenko wrote:
>> > On Thu, 2016-05-19 at 02:18 +0100, Bryan O'Donoghue wrote:
>> > > On Thu, 2016-05-12 at 18:06 +0300, Andy Shevchenko wrote:
>> > > > On Fri, 2016-05-06 at 18:17 +0300, Andy Shevchenko wrote:
>> > > > > This is combined series of two things:
>> > > > > - split out the Intel LPSS specific driver from 8250_pci into
>> > > > > 8250_lpss
>> > > > > - enable DMA support on Intel Quark UART
>> > > > >
>> > > > > The patch has been tested on few Intel SoCs / platforms. In
>> > > > > any
>> > > > > case I
>> > > > > would
>> > > > > like to ask Bryan to do independent test.
>> > >
>> > > Andy.
>> > >
>> > > It looks as though there's a performance drop when enabling the
>> > > DMA
>> > > here (v) stock PIO mode with the 8250 driver.
>>
>> Wait, the time measurement you done is unrelated to DMA/non-DMA mode.
>> It's significantly depend to the speed of the port.
>
> Does it ? The size of the FIFO is what - 16 bytes ?

Doesn't matter if you have data longer than FIFO size you will wait
for data to be sent / received (DMA request line is asserted
accordingly).

> Max burst size is 8
> bytes - so for 37 bytes you'd expect to see five DMA transactions {8,
> 8, 8, 5}, for the second test 183 bytes you'd expect to see 23 eight
> byte transactions followed by one 7 byte transaction. The flip side to
> add data to the FIFO in PIO mode is a pretty different pattern.

Yes and it relies on DMA request signal. DMA is not about transfer
speed it is about offload CPU.
Basically you run the transfer process in a separate thread in the
user application which will sleep until transfer is done. Your test
case is synchronous.

>
>> I also tried on my Galileo board, I used longer data stream, i.e.
>> output
>> of dmesg (since your data pattern makes 0:s in statistics) and got
>> something quite near to each other:
>
> I'll find some time to look at both a short stream and a long stream,
> based on the branch you've indicated and maybe against the latest
> stable kernel.

Please, do. I'm planning to resend new version soon (this week or
lately beginning of the next one).

-- 
With Best Regards,
Andy Shevchenko
