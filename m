From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: A new serial baud rate
Date: Thu, 25 Jul 2002 22:45:07 +0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020725224507.B1237@mea-ext.zmailer.org>
References: <1779CCD227485B49A825718AAAA90E3E406CD1@tpsmail01.turbopower.net> <200207251614.08681.henrique@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200207251614.08681.henrique@cyclades.com>; from henrique@cyclades.com on Thu, Jul 25, 2002 at 04:14:08PM -0300
List-Id: linux-serial@vger.kernel.org
To: henrique <henrique@cyclades.com>
Cc: Gary Frerking <garyf@turbopower.com>, linux-serial@vger.kernel.org

On Thu, Jul 25, 2002 at 04:14:08PM -0300, henrique wrote:
> Hello Gary !!!
> 
> Thanks for your answer. Please see comments no the text.
...
> That's the problem. I can't change the modem configuration cause this modem 
> are provided by the Telco. I have to use this baud rate. And I wanna use it 
> with Linux.

  If the interface is asynchronous, the device will adapt to well-known
  asynchronous baud-rates.  If the interface is SYNCHRONOUS, your hardware
  will be quite special, and it will receive the serial clock from the
  modem  ->  DTE (computer) does not define the speed at all.

  You are not giving details with the modem, and what you have tried
  previously -- e.g. using it with 19200 baud speed, and observing it
  to react on async serial port.

> I just wanna know what is the procedure to insert this new baud rate in
> the linux kernel

  A discussion at this forum, and getting maintainers (Ted Ts'o) 
  attention.

> regards
> Henrique

/Matti Aarnio
