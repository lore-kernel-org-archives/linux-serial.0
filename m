From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] tty: Use raw spin lock to protect RX flip buffer
Date: Thu, 20 Sep 2012 17:37:31 +0100
Message-ID: <20120920173731.657cd2b2@bob.linux.org.uk>
References: <1348150080-4794-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54532 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787Ab2ITQTZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Sep 2012 12:19:25 -0400
In-Reply-To: <1348150080-4794-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ivo Sieben <meltedpianoman@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>

On Thu, 20 Sep 2012 16:08:00 +0200
Ivo Sieben <meltedpianoman@gmail.com> wrote:

> The "normal" spin lock that guards the RX flip buffer is replaced by
> a raw spin lock.

Our current goal is to get the buffers into the tty_port structure so
we can try and get rid of some of the locks entirely. We have lockless
kfifos and the port lifetime is the device lifetime plus so hopefully
it'll go away entirely eventually.

In the meantime I've no real opinion on the spin/raw_spin choices as
it's basically an RT question not a tty one so if the rt folks are
happy with it so am I.


Alan
