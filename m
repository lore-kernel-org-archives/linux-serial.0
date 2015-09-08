From: Richard Watts <rrw@kynesim.co.uk>
Subject: Re: [PATCH] tty: don't leak cdev in tty_cdev_add()
Date: Tue, 08 Sep 2015 11:32:07 +0100
Message-ID: <55EEB927.1080508@kynesim.co.uk>
References: <1441631317-6238-1-git-send-email-chianglungyu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441631317-6238-1-git-send-email-chianglungyu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leon Yu <chianglungyu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 07/09/15 14:08, Leon Yu wrote:
> Commit a3a10ce3429e ("Avoid usb reset crashes by making tty_io cdevs truly
> dynamic") which mixes using cdev_alloc() and cdev_init() is problematic.
> Subsequent call to cdev_init() after cdev_alloc() sets kobj release method
> from cdev_dynamic_release() to cdev_default_release() and thus makes it
> impossible to free allocated cdev.
>
> This patch also consolidates error path of cdev_add() as cdev can also leak
> here if things went wrong.
>
> Signed-off-by: Leon Yu <chianglungyu@gmail.com>
> Fixes: a3a10ce3429e ("Avoid usb reset crashes by making tty_io cdevs truly dynamic")

  Oops! Apologies. Looks good to me - thank you.

Acked-by: Richard Watts <rrw@kynesim.co.uk>



Richard.
