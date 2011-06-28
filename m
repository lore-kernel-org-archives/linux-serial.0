From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/7] serial/8250: move DWAP support to arch/mips
Date: Tue, 28 Jun 2011 12:48:25 +0200
Message-ID: <201106281248.25230.arnd@arndb.de>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de> <1309211120-2803-5-git-send-email-arnd@arndb.de> <20110628110642.3517cac8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58543 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab1F1Ks2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 06:48:28 -0400
In-Reply-To: <20110628110642.3517cac8@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org

On Tuesday 28 June 2011, Alan Cox wrote:
> On Mon, 27 Jun 2011 23:45:17 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Only one board uses the UPIO_DWAP iotype, and nothing uses
> > the UPIO_DWAP32 iotype. It seems much cleaner to handle the
> > DWAP quirk as a new port type, and move the serial_out
> > accessor into the platform code. If more platforms start
> > using the DWAP port, that function can be moved into a
> > common location.
> 
> Half of this patch appears to be unrelated work on HUB6
> 
> Both halves look right but did you accidentally fold two patches
> together ?

Right, Jamie also pointed this out. When I re-send, I'll use Jamie's
version of the patch and make a proper patch for HUB6.

	Arnd
