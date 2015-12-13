From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] drivers/tty/serial: make tegra_serial_handle_break()
 static
Date: Sat, 12 Dec 2015 22:51:25 -0800
Message-ID: <20151213065125.GA25181@kroah.com>
References: <1448473803-9691-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448473803-9691-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 25, 2015 at 11:50:03PM +0600, Alexander Kuleshov wrote:
> There are no callers of the tegra_serial_handle_break() function
> outside of drivers/tty/serial/of_serial.c. So let's make it static.
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> Forgot Signed-off-by line
> 
>  drivers/tty/serial/of_serial.c | 2 +-

This file is not in my tree anymore :(
