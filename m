From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RS485 communicatio
Date: Sat, 15 Mar 2003 20:46:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030315194646.GB367@elf.ucw.cz>
References: <11E89240C407D311958800A0C9ACF7D1A33DDF@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DDF@EXCHANGE>
To: Ed Vance <EdV@macrolink.com>
Cc: 'Linux PPP' <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org, 'linux-kernel' <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi!

> > I will be grateful if anybody of them could help me with my 
> > current problem.
> > 
> 
> I believe Point-to-Point Protocol only supports point-to-point symmetric
> links. Don't think there is any multi-point support in the protocol. IIRC,
> PPP also requires a full duplex link, which is not available on an RS-485
> link with more than two stations, even if it is a 4-wire link. 

Get scarabd (I don't know *where* it is), it can run TCP/IP over slip over
half-duplex link. Performance is not too good.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
