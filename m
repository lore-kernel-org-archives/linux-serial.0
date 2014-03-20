From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: hci_ldsic nested locking problem
Date: Thu, 20 Mar 2014 13:31:40 -0400
Message-ID: <532B25FC.3070408@hurleysoftware.com>
References: <20140320163435.GH32692@saruman.home> <1395333736.22077.32.camel@acox1-desk.ger.corp.intel.com> <20140320171621.GA2827@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140320171621.GA2827@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, Marcel Holtmann <marcel@holtmann.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Muralidharan Karicheri <m-karicheri2@ti.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Huang Shijie <b32955@freescale.com>
List-Id: linux-serial@vger.kernel.org

[ +cc Huang Shijie ]

On 03/20/2014 01:16 PM, Felipe Balbi wrote:
> On Thu, Mar 20, 2014 at 04:42:16PM +0000, Alan Cox wrote:
>> On Thu, 2014-03-20 at 11:34 -0500, Felipe Balbi wrote:
>>> Hi,
>>>
>>> when 8250 driver calls uart_write_wakeup(), the tty port lock is already
>>> taken. hci_ldisc.c's implementation of ->write_wakeup() calls
>>> tty->ops->write() to actually send the characters, but that call will
>>> try to acquire the same port lock again.
>>>
>>> Looking at other line disciplines that looks like a bug in hci_ldisc.c.
>>> Am I correct to assume that ->write_wakeup() is supposed to *just*
>>> wakeup the bottom half so we handle ->write() in another context ?
>>>
>>> Is it legal to call tty->ops->write() from within ->write_wakeup() ?
>>
>> It isn't because you might send all the bytes and go
>>
>> 	write
>> 		write_wakeup
>> 			write
>> 				write wakeup
>> 					...
>>
>> and recurse
>
> cool, so there really is a bug in hci_ldisc. Marcel, any tips on how do
> you want this to be sorted out ?

hci_uart_tx_wakeup() should perform the I/O as work.
FWIW, this was reported by Huang Shijie back on Dec 6.

I'd fix it but I have no way to test it.

Regards,
Peter Hurley
