From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] n_tty: Protect minimum_to_wake reset for concurrent
 readers
Date: Mon, 25 Nov 2013 08:36:02 -0800
Message-ID: <20131125163602.GA19071@kroah.com>
References: <1383850917-24416-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46691 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687Ab3KYQgE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Nov 2013 11:36:04 -0500
Content-Disposition: inline
In-Reply-To: <1383850917-24416-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Nov 07, 2013 at 02:01:57PM -0500, Peter Hurley wrote:
> With multiple, concurrent readers (each waiting to acquire the
> atomic_read_lock mutex), a departing reader may mistakenly reset
> minimum_to_wake after a new reader has already set a new value.
> 
> Protect the minimum_to_wake reset with the atomic_read_lock critical
> section.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/n_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This patch doesn't apply to Linus's tree anymore (and hence, mine.)  Is
it needed for 3.13-final?  Or just 3.14-rc1?  Either way, can you
refresh it and resend?

thanks,

greg k-h
