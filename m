From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/7] serial/8250: move alchemy I/O handler to platform code
Date: Tue, 28 Jun 2011 19:07:23 +0200
Message-ID: <201106281907.24124.arnd@arndb.de>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de> <BANLkTin9=5Yp6W8S6hSuUZ8w08eUhRxxQw@mail.gmail.com> <BANLkTimnH81zys5Ab4XpsyuNXK2B+MqQrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53480 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759755Ab1F1RHl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 13:07:41 -0400
In-Reply-To: <BANLkTimnH81zys5Ab4XpsyuNXK2B+MqQrw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ralf Baechle <ralf@linux-mips.org>, linux-serial@vger.kernel.org

On Tuesday 28 June 2011, Manuel Lauss wrote:
> Okay, found it.  the Alchemy headers have definitions for UART_RX/TX/... with
> different values; they can be deleted safely since nothing depends on them.
> Here's an updated and tested patch.  I took the liberty to rename the functions
> a bit while at it.

Cool, thanks so much for tracking that down!

Please send me (in private) the Signed-off-by that you want me to add to the
patch, apparently you missed that.

I'll put your version in the series then.

	Arnd
