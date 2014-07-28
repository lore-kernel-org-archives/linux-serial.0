From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: serial_core.c: printk replacement
Date: Mon, 28 Jul 2014 08:21:11 -0700
Message-ID: <20140728152111.GA13149@kroah.com>
References: <1406559481-14084-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46515 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbaG1PVl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Jul 2014 11:21:41 -0400
Content-Disposition: inline
In-Reply-To: <1406559481-14084-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 28, 2014 at 08:28:01PM +0530, Sudip Mukherjee wrote:
> printk replaced with corresponding pr_* 
> fixed two broken user-visible strings used by the printk

Can you change to use dev_err() instead?  That would help identify the
device and driver causing this problem better.

thanks,

greg k-h
