From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] TTY: serial, add pm function
Date: Tue, 15 Jan 2013 23:05:21 -0800
Message-ID: <20130116070521.GB2527@kroah.com>
References: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36818 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251Ab3APHEd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 02:04:33 -0500
Content-Disposition: inline
In-Reply-To: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rickard Andersson <rickard.andersson@stericsson.com>
Cc: linux-serial@vger.kernel.org, linus.walleij@stericsson.com, alan@linux.intel.com, daniel.lezcano@linaro.org

On Wed, Dec 12, 2012 at 01:40:51PM +0100, Rickard Andersson wrote:
> Add power management function to tty driver interface
> and add implementation for serial core.
> 
> Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
> ---
> ChangeLog v1->v2
> - add mutex handling

As no one is using this, why add it?

greg k-h
