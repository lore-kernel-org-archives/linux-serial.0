From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RS485 communicatio
Date: 16 Mar 2003 19:57:06 +0000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1047844625.21346.1.camel@irongate.swansea.linux.org.uk>
References: <11E89240C407D311958800A0C9ACF7D1A33DDF@EXCHANGE>
	 <20030315194646.GB367@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030315194646.GB367@elf.ucw.cz>
List-Id: linux-serial@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ed Vance <EdV@macrolink.com>, 'Linux PPP' <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org, 'linux-kernel' <linux-kernel@vger.kernel.org>

On Sat, 2003-03-15 at 19:46, Pavel Machek wrote:
> > I believe Point-to-Point Protocol only supports point-to-point symmetric
> > links. Don't think there is any multi-point support in the protocol. IIRC,
> > PPP also requires a full duplex link, which is not available on an RS-485
> > link with more than two stations, even if it is a 4-wire link. 
> 
> Get scarabd (I don't know *where* it is), it can run TCP/IP over slip over
> half-duplex link. Performance is not too good.

Robin O'Leary wrote most of it, so its probably somewhere like
caderus.co.uk

Half duplex performance is fine at a sensible speed and with decent
reliability. On radio will collisions its a lot less pretty

