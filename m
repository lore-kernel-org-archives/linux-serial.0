From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.24: Serial disabled in BIOS but serial modules still loaded
 (probably PnP related)
Date: Sun, 25 Nov 2007 12:39:24 -0600
Message-ID: <4749C15C.6020805@shaw.ca>
References: <fa.P01QcmUf2f3DN4etI8KJYFdaLnE@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:59163 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbXKYSj7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Nov 2007 13:39:59 -0500
In-reply-to: <fa.P01QcmUf2f3DN4etI8KJYFdaLnE@ifi.uio.no>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Andrey Borzenkov wrote:
> I have no COM port on notebook (without port replicator which I do not have)
> so COM is disabled in BIOS. No ttyS* is detected during boot (and no device
> created) but I just noticed that serial modules are still loaded. Well, this
> partially defeats the purpose of disabling COM port - the intention was to
> free resources by *not* loading unneeded modules ...
> 
> This may have something to do with (ACPI) PnP which apparently believes COM is alive.
> Notebook is Toshiba Portege 4000.

Probably a BIOS bug. It still lists the port in PnP data even though the 
hardware is disabled, so the kernel still tries to load the serial 
driver for it, which finds there's no port there.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

