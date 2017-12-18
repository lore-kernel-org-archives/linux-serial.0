From: Helge Deller <deller@gmx.de>
Subject: Re: Have my PA8800 back online... (serial port missing on v4.14)
Date: Mon, 18 Dec 2017 21:07:16 +0100
Message-ID: <ebe416dd-aa18-9433-4dd7-67490d5778ee@gmx.de>
References: <20171208190644.GA22228@ls3530.fritz.box>
 <1512980798.25007.581.camel@linux.intel.com>
 <43eb21b5-75d9-1142-1307-c2e2d218b362@gmx.de>
 <1513178210.7000.34.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1513178210.7000.34.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-parisc-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frank Scheiner <frank.scheiner@web.de>, linux-parisc@vger.kernel.org, John David Anglin <dave.anglin@bell.net>, linux-serial@vger.kernel.org
Cc: debian-hppa@lists.debian.org
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On 13.12.2017 16:16, Andy Shevchenko wrote:
> On Tue, 2017-12-12 at 21:11 +0100, Helge Deller wrote:
>> On 11.12.2017 09:26, Andy Shevchenko wrote:
>>> On Fri, 2017-12-08 at 20:06 +0100, Helge Deller wrote:
> 
>> Before your patch this check was inside the function
>> serial_pci_guess_board()
>> and if (ent->driver_data != pbn_default) the pci serial port got
>> registered 
>> and initialized *even* if it's *not* of class SERIAL or MODEM.
> 
> Ah, okay, it explains indeed.
> Though PCI devices with wrong class should have their own quirks for my
> p.o.v.
> 
>>> (Of course, I agree this is regression and needs to be fixed ASAP)
>>
>> I don't know if it's easy to fix without reverting your patch.
> 
> As I explained earlier it's about pci_enable_device() called twice for
> the same device which basically calls pcibios_enable_irq() twice which
> might be a problem on some platforms. (At least I have such use case).
> Perhaps it's possible to workaround the issue on those platforms, though
> I didn't come up with the better solution that time.
> 
>> Thanks for the offer to accept this patch, but maybe we are able
>> to come up with another patch which simply hides those unsupported
>> devices (serial port and ATI graphics card device on the Diva card).

>> I posted a proposed patch here:
>> http://www.spinics.net/lists/linux-parisc/msg08187.html
> 
> Reading briefly that one I guess it's even better (now I realized you
> even do not have connectors of those devices outside).

It's now fixed for parisc by new PCI quirks which
disable the parisc serial AUX port: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcf3f1752a622f1372d3252d0fea8855d89812e7

Thanks,
Helge
