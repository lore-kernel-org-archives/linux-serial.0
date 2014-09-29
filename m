From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: mxs-auart: add sysrq support
Date: Sun, 28 Sep 2014 21:41:29 -0400
Message-ID: <20140929014129.GA8687@kroah.com>
References: <1411740486-21687-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33834 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaI2GQ7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Sep 2014 02:16:59 -0400
Content-Disposition: inline
In-Reply-To: <1411740486-21687-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 26, 2014 at 04:08:05PM +0200, Janusz Uzycki wrote:
> This is rather obvious patch now.
> The patch is resent as cleaned independent from the patchset:
> "Re: [PATCH 1/4] serial: mxs-auart: use mctrl_gpio helpers for handling modem signals (v2.2c)"
> 
> Who could apply the patch?

I have so many patches from you for this driver in my inbox, yet almost
no idea which to apply.  Please always properly label which series
obsoletes previous ones, and what order the patches need to be applied
in (your latest patches lack this entirely.)

So I'm deleting all of these now, please resend the latest versions you
have, with properly versioning and order information.

thanks,

greg k-h
