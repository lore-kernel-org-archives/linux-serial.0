From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
Date: Wed, 24 May 2017 18:09:11 +0200
Message-ID: <b5a032c8-db86-c16b-750f-10aa2a132248@xilinx.com>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
 <20170522192636.5b578d89@alans-desktop>
 <1668f36e-f9be-7008-004a-e467a6813e0f@xilinx.com>
 <20170523210710.4e84dd2d@alans-desktop>
 <924433a1-7e27-6eb6-71ca-ed7baceb427f@xilinx.com>
 <20170524143108.682a548d@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170524143108.682a548d@alans-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Michal Simek <michal.simek@xilinx.com>
Cc: Rob Herring <robh+dt@kernel.org>, Sam Povilus <kernel.development@povil.us>, gregkh@linuxfoundation.org, jslaby@suse.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 24.5.2017 15:31, Alan Cox wrote:
>> I am not saying that config option is perfect solution. It is at least
>> aligned with 5 others serial drivers in the tree.
> 
> And the fact people keep doing hacks jutifies continuing to make a mess.
> Especialy as in this case it's entirely theoretical. Nobody has produced
> actual hardware that hits the limit. Nobody has filed a bug, nobody is
> impacted.

This is the reason why we are talking about it how to do it right.

With this ps uart it is not that easy because this is cadence RTL which
is not in public IP database but the same think is with uartlite.
Limit there is 16. If you really want that I can create that HW design
which will require more than 16 uartlites in one design.


> Creating extra CONFIG_ entries for junk like this is ridiculous, most of
> the others at least have the excuse of being old code.

No doubt about it. I am just trying to find out what's the way you are
suggesting.


> Generally it is better to call uart_register_driver from the probe method
> because that way you don't waste time and memory registering drivers for
> stuff that isn't even present however if you have no idea how many
> devices there might be then you still really need to pass a suitable limit
> and handle it internally dynamically allocating as needed.

Ok. Is there any problem if uart_register_driver is called for every
instance separately with nr=1? This driver has major 0, minor 0. Based
on comment major 0 is for dynamic node allocation. Not sure about minor
but it is easy to figured out if this should be 0 or 1, 2, 3, etc.

> If someone was hitting this in the real world and you posted a patch that
> just changed the constant to 8 or 16 or whatever was needed I wouldn't
> care too much, but adding CONFIG_ entries just makes stuff harder and
> harder to config and more and more impossible to keep generic.
> 
> I keep hearing that the ARM folks are trying to get one unified kernel.
> CONFIG_ options is not how to do that.

I have really not a problem with all of this. Just trying to understand
how to do it properly and cleanup the second driver which we use on
fpga. Last driver used by Xilinx is uart16550 where that old config
macro already exists.

Because at least now there is an issue in driver if you use serial
aliases (serial2 and up) which needs to be fixed.

Thanks,
Michal
