From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Tue, 22 May 2012 17:27:00 +0100
Message-ID: <20120522172700.02d7915d@pyramind.ukuu.org.uk>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com>
	<4FBB8742.7050504@fastmail.fm>
	<20120522151033.33ef577a@pyramind.ukuu.org.uk>
	<1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55677 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab2EVQYG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 May 2012 12:24:06 -0400
In-Reply-To: <1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitriy Alekseev <alexeev6@yahoo.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, 22 May 2012 07:38:28 -0700 (PDT)
Dmitriy Alekseev <alexeev6@yahoo.com> wrote:

> This is driver source I found:
> http://www.codeforge.com/read/118181/st16c554_serial.c__html
> 
> It was written for quad uart st16c554 for arm chip s3c2410, which I tried to adapt for at91rm9200 board and newer kernel version.

Why not use the in kernel 8250 driver (which will drive a stamdard
16540/550/554 as well ?)

To ressurect one you'll need to add kref handling, rework the termios code
and maybe some other bits too.

Take a look how other arm boards use struct plat_serial8250_port and the
serial8250 platform driver. You should just be able to declare the
structures and register the platform device.

Alan

