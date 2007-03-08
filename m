From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Thu, 08 Mar 2007 15:16:08 +0100
Message-ID: <45F01AA8.7010608@gmx.net>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com> <200703071019.55896.rgetz@blackfin.uclinux.org> <57354eff0703071330k2395e9c8n58e12f2111dcb25a@mail.gmail.com> <200703080844.32157.rgetz@blackfin.uclinux.org> <20070308134800.GA30023@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:33363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751884AbXCHOQN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2007 09:16:13 -0500
In-Reply-To: <20070308134800.GA30023@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>, Oleksiy Kebkal <kebkal@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

Hi,

On 08.03.2007 14:48, Russell King wrote:
> As I've said already, having a console on the same port as your application
> program is just asking for trouble.  All bets are off - the kernel _will_
> corrupt your data stream in random places.
> 
> Don't do it - it will _NEVER_ be reliable.
> 
> Never, ever, mix kernel consoles with application serial ports.

Unless you want two machines to monitor each other via serial console and
each of them has only one serial port. It's not perfect, but it works well
enough despite all claims to the contrary.

Regards,
Carl-Daniel
