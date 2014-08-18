From: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Mon, 18 Aug 2014 16:56:24 +0200
Message-ID: <53F21418.80307@ts.fujitsu.com>
References: <53F1CD68.9080901@ts.fujitsu.com> <20140818105307.GA5811@kroah.com> <53F1DF48.8000007@ts.fujitsu.com> <53F1E14D.7000408@ts.fujitsu.com> <53F202FF.5020809@ts.fujitsu.com> <20140818135046.GA927@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:8030 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbaHROzc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 10:55:32 -0400
In-Reply-To: <20140818135046.GA927@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 18.08.2014 15:50, Greg KH wrote:
> On Mon, Aug 18, 2014 at 03:43:27PM +0200, Cestonaro Thilo wrote:
>> Hey,
>>
>> do I need to do something like:
>> ----
>> f = filp_open("/dev/ttyS0", O_RDWR | O_NOCTTY | O_NDELAY, 0600);
>> fs=get_fs();
>> set_fs(KERNEL_DS);
>> ---
>> Is there really no API for a uart attached device to communicate with it?
>>
>> That would be the last thing I thought of :(.
> Wait, you want to talk to a serial port from within the kernel?  No,
> don't open the device node, just talk directly to the tty layer.  An
> example of code that does this is some of the bluetooth layer.
>
> good luck,
>
> greg k-h
>

 From the hci_uart stuff I got to the conclusion that I need to implement
a tty line discipline driver and change the corresponding tty's line 
discipline
to my own one.

Is this the best way or did I miss something? I ask again, cause writing 
a tty line discipline
looks rather complicate then straight forward and before I start doing it,
I want to be sure to not run against a wall :).

Cheers,
Thilo





