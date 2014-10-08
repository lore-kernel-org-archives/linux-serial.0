From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 03/12] serial_core: Handle TIOC[GS]RS485 ioctls.
Date: Thu, 09 Oct 2014 00:29:22 +0100
Message-ID: <1412810962.28467.69.camel@acox1-desk.ger.corp.intel.com>
References: <1412798258-23655-1-git-send-email-ricardo.ribalda@gmail.com>
	 <1412798258-23655-4-git-send-email-ricardo.ribalda@gmail.com>
	 <1412799101.28467.68.camel@acox1-desk.ger.corp.intel.com>
	 <CAPybu_1vXc+=dVbradArvFYiFBy2c=0tTM7RAHDhycCkQQv_5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47501 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbaJHX3e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2014 19:29:34 -0400
In-Reply-To: <CAPybu_1vXc+=dVbradArvFYiFBy2c=0tTM7RAHDhycCkQQv_5g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, LKML <linux-kernel@vger.kernel.org>

On Wed, 2014-10-08 at 22:43 +0200, Ricardo Ribalda Delgado wrote:
> Hello Alan
> 
> This patchset adds no extra locking features, if the drivers did not
> implement a locking mechanism (and none did) there is chance of
> conflict.
> 
> I can add a call to lock/unlock around uart_[gs]et_rs485_config. And
> then, inside the drivers, use the lock when the structure is used.
> 
> I would prefer to add it as new patches in the patchset, so in case
> this adds some bugs they can be bisected easily.


Makes sense.


