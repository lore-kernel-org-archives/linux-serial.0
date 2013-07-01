From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: [v3.9] [v3.10] [Regression]  serial: 8250_pci: add support for
 another kind of NetMos Technology PCI 9835 Multi-I/O Controller
Date: Mon, 01 Jul 2013 14:48:56 -0400
Message-ID: <51D1CF18.80201@canonical.com>
References: <51D1AAF5.5050004@canonical.com> <20130701162751.GA18834@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130701162751.GA18834@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: udknight@gmail.com, jslaby@suse.cz, alan@linux.intel.com, matts@commtech-fastcom.com, wfp5p@virginia.edu, tklauser@distanz.ch, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 07/01/2013 12:27 PM, Greg KH wrote:
> On Mon, Jul 01, 2013 at 12:14:45PM -0400, Joseph Salisbury wrote:
>> Hi Wang,
>>
>> A bug was opened against the Ubuntu kernel[0].  After a kernel bisect,
>> it was found that reverting the following commit resolved this bug:
>>
>> commit 8d2f8cd424ca0b99001f3ff4f5db87c4e525f366
>> Author: Wang YanQing <udknight@gmail.com>
>> Date:   Fri Mar 1 11:47:20 2013 +0800
>>
>>     serial: 8250_pci: add support for another kind of NetMos Technology
>> PCI 9835 Multi-I/O Controller
>>
>>
>> The regression was introduced as of v3.9-rc3 and still exists in the
>> current Mainline tree.  It was also propagated to the stable trees.
>>
>> The patch causes the device to use the serial module instead of
>> parport_serial.  Maybe the the quirk in ~drivers/pci/quirks.c
>> quirk_netmos() needs to be modified?
>>
>> I see that you are the author of this patch, so I wanted to run this by
>> you.  I was thinking of requesting a revert, but I wanted to get your
>> feedback first.
> You missed the conversation we had about this already this weekend :)
>
> The offending patch has already been reverted and will propagate to the
> stable trees soon.
>
> thanks,
>
> greg k-h
Good news.  Thanks for the help, Greg!
