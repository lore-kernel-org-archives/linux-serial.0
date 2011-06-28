From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/7] serial/8250: move DWAP support to arch/mips
Date: Tue, 28 Jun 2011 11:06:42 +0100
Message-ID: <20110628110642.3517cac8@lxorguk.ukuu.org.uk>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-5-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58755 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756496Ab1F1KEY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 06:04:24 -0400
In-Reply-To: <1309211120-2803-5-git-send-email-arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org

On Mon, 27 Jun 2011 23:45:17 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Only one board uses the UPIO_DWAP iotype, and nothing uses
> the UPIO_DWAP32 iotype. It seems much cleaner to handle the
> DWAP quirk as a new port type, and move the serial_out
> accessor into the platform code. If more platforms start
> using the DWAP port, that function can be moved into a
> common location.

Half of this patch appears to be unrelated work on HUB6

Both halves look right but did you accidentally fold two patches
together ?
