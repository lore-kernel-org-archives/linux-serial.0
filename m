Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0342C433F5
	for <linux-serial@archiver.kernel.org>; Sat, 18 Dec 2021 09:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhLRJGD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 18 Dec 2021 04:06:03 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:60679 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLRJGD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 18 Dec 2021 04:06:03 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3C8C0300097C6;
        Sat, 18 Dec 2021 10:06:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2DC602E6705; Sat, 18 Dec 2021 10:06:01 +0100 (CET)
Date:   Sat, 18 Dec 2021 10:06:01 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ulrich Teichert <krypton@ulrich-teichert.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] serial: 8250: Move alpha-specific quirk out of the core
Message-ID: <20211218090601.GA1016@wunner.de>
References: <af967f273724aff4cff3c49470110a48f790794e.1639676574.git.lukas@wunner.de>
 <202112162036.1BGKaKGI003165@valdese.nms.ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112162036.1BGKaKGI003165@valdese.nms.ulrich-teichert.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 16, 2021 at 09:36:20PM +0100, Ulrich Teichert wrote:
> > struct uart_8250_port contains mcr_mask and mcr_force members whose
> > sole purpose is to work around an alpha-specific quirk.  This code
> > doesn't belong in the core where it is executed by everyone else,
> > so move it to a proper ->set_mctrl callback which is used on alpha only.
[...]
> > The quirk applies to non-PCI alphas and arch/alpha/Kconfig specifies
> > "select FORCE_PCI if !ALPHA_JENSEN".  So apparently the only affected
> > machine is the EISA-based Jensen that Linus was working on back then:
[...]
> > Up until now the quirk is not applied unless CONFIG_PCI is disabled.
> > If users forget to do that, the serial ports aren't usable on Jensen
> > and the machine may not boot in the first place.  Avoid by confining
> > the quirk to CONFIG_ALPHA_JENSEN instead.
> 
> Wouldn't that mean that you can't use a generic Alpha kernel on the Jensen
> anymore? CONFIG_ALPHA_JENSEN is only set if you specifically select the
> Jensen as target, not when you build a generic kernel. That would be a step
> back in my opinion, as the Debian generic kernel from debian-ports did
> as least boot up on real hardware and the serial console worked just fine

The generic Alpha kernel has CONFIG_PCI=y, so the quirk is not applied,
both with and without the present patch.

You should be able to trigger the lockup that the quirk seeks to avoid
by closing the tty of either of the serial ports.  E.g., if you're using
the serial console, "cat" something to the other serial port's tty.
That will clear TIOCM_OUT2 in serial8250_do_shutdown() and should thus
provoke the lockup.  Alternatively, compile and run the little program
below on the Jensen.  (Pass a serial port tty as argument.)

Should you not be able to reproduce the lockup, then the quirk wouldn't
be necessary anymore and could be removed.

Thanks!

Lukas

-- >8 --

#include <unistd.h>
#include <termios.h>
#include <fcntl.h>
#include <sys/ioctl.h>

#define TIOCM_OUT1	0x2000
#define TIOCM_OUT2	0x4000

int main(int argc, char* argv[]) {
	int fd, ret, flags;

	if (argc < 2)
		return 1;

	fd = open(argv[1], O_RDWR);
	if (fd < 0)
		return 2;

	ret = ioctl(fd, TIOCMGET, &flags);
	if (ret < 0)
		goto close;

	flags &= ~(TIOCM_OUT1 | TIOCM_OUT2);
	ret = ioctl(fd, TIOCMSET, &flags);

close:
	close(fd);

	return ret;
}
