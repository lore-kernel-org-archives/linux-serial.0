From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: A new serial baud rate
Date: Thu, 25 Jul 2002 22:35:38 +0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020725223538.A1237@mea-ext.zmailer.org>
References: <200207251522.49383.henrique@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200207251522.49383.henrique@cyclades.com>; from henrique@cyclades.com on Thu, Jul 25, 2002 at 03:22:49PM -0300
List-Id: linux-serial@vger.kernel.org
To: henrique <henrique@cyclades.com>
Cc: linux-serial@vger.kernel.org

On Thu, Jul 25, 2002 at 03:22:49PM -0300, henrique wrote:
> Hello !!!
> 
> I want to use the 14400 baud rate on a serial port (I have a lot of modems 
> configured to this baud rate) but the define B14400 doesn't exist. What 
> should I do. Is it a matter of simply insert the new define into termbits.h ?

  There seem to exist two different approaches to the speed
  parameter.  The classical is to have  Bnnnnn  constant in
  the <termios.h> POSIX tc{get|set}attr().

  Another is to supply the speed, or at least the divisor explicitely.
  This is done via  TIO[GS]SERIAL  ioctl.  See  setserial(8) for more
  pointers.

  Entirely separate issue is that modem speed of 14400 bauds is
  roughly 18000 bauds of async speed, without considering any of
  possible modem link compression effects.  Modems do adapt to
  your computer serial port speed, and to get full modem speed
  bandwidth into use, your modem-computer link speed needs to
  more capacitous, than what the modem can feed into it.

> thanks in advance
> ---
> Henrique Gobbi

/Matti Aarnio
