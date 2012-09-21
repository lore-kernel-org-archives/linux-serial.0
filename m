From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: set correct baud_base for EXSYS EX-41092 Dual
 16950
Date: Fri, 21 Sep 2012 09:49:25 -0700
Message-ID: <20120921164925.GA10494@kroah.com>
References: <1347908021-13570-1-git-send-email-fbl@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347908021-13570-1-git-send-email-fbl@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Flavio Leitner <fbl@redhat.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Niels de Vos <niels.devos@wincor-nixdorf.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 17, 2012 at 03:53:41PM -0300, Flavio Leitner wrote:
> Apparently the same card model has two IDs, so this patch
> complements the commit 39aced68d664291db3324d0fcf0985ab5626aac2
> adding the missing one.
> 
> Signed-off-by: Flavio Leitner <fbl@redhat.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 7 +++++--
>  include/linux/pci_ids.h            | 3 ++-

Please read the top of the pci_ids.h file for why we don't want to add
new entries there.

Please fix that up and resend this.

thanks,

greg k-h
