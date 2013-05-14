From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 01/15] serial: altera: remove unnecessary
 platform_set_drvdata()
Date: Tue, 14 May 2013 09:13:32 +0200
Message-ID: <20130514071331.GE25205@distanz.ch>
References: <007301ce4af2$a72676e0$f57364a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:41714 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756163Ab3ENHWu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 May 2013 03:22:50 -0400
Content-Disposition: inline
In-Reply-To: <007301ce4af2$a72676e0$f57364a0$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org

On 2013-05-07 at 09:15:28 +0200, Jingoo Han <jg1.han@samsung.com> wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks a lot
