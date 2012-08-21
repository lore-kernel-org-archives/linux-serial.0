From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHv4 1/1] [RFC] uartclk from serial_core exposed to sysfs
Date: Tue, 21 Aug 2012 14:44:39 +0100
Message-ID: <20120821144439.2bfcfc8d@pyramind.ukuu.org.uk>
References: <1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
	<1345401285-14473-1-git-send-email-tmshlvck@gmail.com>
	<CAEB7QLDBjUp9GswRB20KdFNVLJme3WeX2Xd79-ovP6SWxVORpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55273 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab2HUNkC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Aug 2012 09:40:02 -0400
In-Reply-To: <CAEB7QLDBjUp9GswRB20KdFNVLJme3WeX2Xd79-ovP6SWxVORpA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, marek.vasut@gmail.com

> I have updated the patch to a new v4 in order to remove the race in
> sysfs file creation and add sysfs file description to a Documentation
> directory. But still the patch creates the sysfs file separately for
> each serial TTY device by assigning attribute_groups to the struct
> device and not for the whole driver at once as Greg advised because I
> was unable to figure out how to do that (even though I tried pretty
> hard). Does it make sense like this? Or do you have any hint for a
> better way to do it, please?

I'm fine with it - dunno about GregKH. Given the way tty 'drivers' and
tty devices fit together I'm not 100% sure it makes sense to do it per
driver. Plus once we have the basis we can fix a lot of the detail
afterwards.

Alan
