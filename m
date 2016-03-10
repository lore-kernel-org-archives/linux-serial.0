From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [v2] serial_core:recognize invalid pointer from userspace
Date: Thu, 10 Mar 2016 13:46:47 +0000
Message-ID: <20160310134647.7053a520@lxorguk.ukuu.org.uk>
References: <1457579843-29676-1-git-send-email-lu.jiang@windriver.com>
	<1457579843-29676-2-git-send-email-lu.jiang@windriver.com>
	<20160310033435.GA28983@kroah.com>
	<56E0FE77.1020303@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56E0FE77.1020303@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lu.Jiang" <lu.jiang@windriver.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> When userspace get setting with TIOCGSERIAL,
> 
> 1.On 64bit kernel + 32bit rootfs, compat ioctl code use 0xffffffff to 
> mark invalid conversion.

Start at the beginning. What is being passed back and forth that causes
the problem. What memory address does your uart have ?

> 2.On 32bit kernel with 64bit physical address, uart_get_info() in 
> serial_core will truncate a 64bit address into 32bit pointer with 
> following code:
>      retinfo->iomem_base      = (void *)(unsigned long)uport->mapbase;
> 
> Then when setting with TIOCSSERIAL ioctl, application can not provide 
> original value for iomem_base, it leads setserial can not work on such 
> boards.

Yes - it's a legacy feature that isn't really needed on 64bit systems.

> I don't know why kernel should expose this value to userspace, and seems 
> no need for userspace application to update an physical address for driver.
> Can we consider drop this member in handle for TIOCSSERIAL ioctl. Please 
> see a rough patch in attachment.

There are old PC and embedded cases from the time before devicetree and
ACPI were the default. It's now an API people rely upon.

It would make sense I think to return 0 for the base address if it
exceeds 32bits, and also to ignore a TIOCSSERIAL that passes 0 as the
address back. Would that fix your use case ?

Alan
