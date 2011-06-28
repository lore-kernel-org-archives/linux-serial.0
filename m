From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 2/7] serial/8250: move alchemy I/O handler to platform code
Date: Tue, 28 Jun 2011 10:06:40 +0200
Message-ID: <BANLkTimDo7x5MmnNKoopLZNM7RBeNp=Fsg@mail.gmail.com>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57250 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab1F1IGm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 04:06:42 -0400
In-Reply-To: <1309211120-2803-3-git-send-email-arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ralf Baechle <ralf@linux-mips.org>, linux-serial@vger.kernel.org

Hi Arnd,

On Mon, Jun 27, 2011 at 11:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Only one platform ever sets the UPIO_AU iotype, so it's
> cleaner to define the handlers in the code that actually
> requires it, rather than building the same logic into
> every 8250 driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Manuel Lauss <manuel.lauss@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: linux-serial@vger.kernel.org
> ---
> =A0arch/mips/alchemy/common/platform.c | =A0 50 +++++++++++++++++++++=
+++++++++
> =A0drivers/tty/serial/8250.c =A0 =A0 =A0 =A0 =A0 | =A0 58 -----------=
------------------------
> =A02 files changed, 50 insertions(+), 58 deletions(-)

This breaks serial console on all my Alchemy test system.  I'll try to
figure out why.

Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
