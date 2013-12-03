From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: sh-sci: Fix warnings due to improper casts
 and printk formats
Date: Tue, 3 Dec 2013 10:45:15 -0800
Message-ID: <20131203184515.GD23280@kroah.com>
References: <1385547037-13422-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385547037-13422-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 27, 2013 at 11:10:37AM +0100, Laurent Pinchart wrote:
> Use the %zu printk specifier to print size_t variables, and cast
> pointers to uintptr_t instead of unsigned int where applicable. This
> fixes warnings on platforms where pointers and/or dma_addr_t have a
> different size than int.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/tty/serial/sh-sci.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
