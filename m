From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] serial: core: Preserve termios c_cflag for console
 resume
Date: Wed, 9 Jul 2014 14:28:21 +0100
Message-ID: <20140709142821.7cd9bb15@alan.etchedpixels.co.uk>
References: <1404912074-9729-1-git-send-email-peter@hurleysoftware.com>
	<1404912074-9729-2-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:39299 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbaGIN2e (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jul 2014 09:28:34 -0400
In-Reply-To: <1404912074-9729-2-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed,  9 Jul 2014 09:21:14 -0400
Peter Hurley <peter@hurleysoftware.com> wrote:

> When a tty is opened for the serial console, the termios c_cflag
> settings are inherited from the console line settings.
> However, if the tty is subsequently closed, the termios settings
> are lost. This results in a garbled console if the console is later
> suspended and resumed.
> 
> Preserve the termios c_cflag for the serial console when the tty
> is shutdown; this reflects the most recent line settings.
> 
> Fixes: Bugzilla #69751, 'serial console does not wake from S3'
> Reported-by: Valerio Vanni <valerio.vanni@inwind.it>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Acked-by: Alan Cox <alan@linux.intel.com>
