From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 3/3] tty/serial: at91: fix hardware handshake when DMA is
 not used
Date: Wed, 7 Sep 2016 18:59:18 +0200
Message-ID: <20160907165918.xog3poqstw434r2j@piout.net>
References: <20160907161324.27774-1-richard.genoud@gmail.com>
 <20160907161324.27774-3-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160907161324.27774-3-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 07/09/2016 at 18:13:24 +0200, Richard Genoud wrote :
> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> hardware handshake is enabled") broke the hardware handshake when
> DMA is not used.
> 
> So, here's a summary:
> If DMA is NOT USED the mode should be ATMEL_US_USMODE_NORMAL because the
> controller can't drive the RTS pin (there's no way for it to know when
> we can't receive data anymore).
> 

You forgot that the PDC can properly drive the RTS pin so all the
platforms that are using the PDC will break after your patch.

Also, I believe the controller is able to drive the RTS and CTS pins
when simply using PIOs (it knows when one complete character has been
received and US_RHR has not yet been read). However, I didn't test.
Maybe someone at Atmel can confirm.

I think that 5be605ac9af9 is doing the right thing but I still can be
convince otherwise ;).

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
