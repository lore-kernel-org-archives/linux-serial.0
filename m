From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH] drivers: char: hvc: add Blackfin
 JTAG console support
Date: Thu, 3 Feb 2011 19:14:54 -0500
Message-ID: <AANLkTikAsEMrZYz+yTpiTNv16B_0dtLHJBaXu3jvUPtW@mail.gmail.com>
References: <1294713837-4929-1-git-send-email-vapier@gentoo.org> <20110203222006.GA12859@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57612 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab1BDAPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Feb 2011 19:15:15 -0500
In-Reply-To: <20110203222006.GA12859@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, Feb 3, 2011 at 17:20, Greg KH wrote:
> On Mon, Jan 10, 2011 at 09:43:57PM -0500, Mike Frysinger wrote:
>> This converts the existing bfin_jtag_comm TTY driver to the HVC laye=
r so
>> that the common HVC code can worry about all of the TTY/polling crap=
 and
>> leave the Blackfin code to worry about the Blackfin bits.
>
> This patch no longer applies to the linux-next tree. =C2=A0Can you re=
do it
> and resend it?

guessing it's due to the tty reorg.  np.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
