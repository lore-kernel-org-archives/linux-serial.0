From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: hci_ldsic nested locking problem
Date: Thu, 20 Mar 2014 13:34:57 -0400
Message-ID: <532B26C1.8080806@hurleysoftware.com>
References: <20140320163435.GH32692@saruman.home> <1395333736.22077.32.camel@acox1-desk.ger.corp.intel.com> <20140320171621.GA2827@saruman.home> <20140320172920.GC2827@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140320172920.GC2827@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Alan Cox <alan@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>, Greg KH <gregkh@linuxfoundation.org>, Muralidharan Karicheri <m-karicheri2@ti.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Huang Shijie <b32955@freescale.com>
List-Id: linux-serial@vger.kernel.org

[ +cc Huang Shijie ]

On 03/20/2014 01:29 PM, Felipe Balbi wrote:
> then we need updates to Documentation:
>
> Documentation/serial/tty.txt::
>
> |  Driver Side Interfaces:
> |
> |  receive_buf()	-	Hand buffers of bytes from the driver to the ldisc
> |  			for processing. Semantics currently rather
> |  			mysterious 8(
> |
> |  write_wakeup()	-	May be called at any point between open and close.
> |  			The TTY_DO_WRITE_WAKEUP flag indicates if a call
> |  			is needed but always races versus calls. Thus the
> |  			ldisc must be careful about setting order and to
> |  			handle unexpected calls. Must not sleep.
> |
> |  			The driver is forbidden from calling this directly
> |  			from the ->write call from the ldisc as the ldisc
> |  			is permitted to call the driver write method from
> |  			this function. In such a situation defer it.
>
> documentation says ldisc is allowed to call ->write() from
> ->write_wakeup(). huh ?

Patch submitted but never applied.

http://www.spinics.net/lists/linux-serial/msg11144.html

Regards,
Peter Hurley
