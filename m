From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Possible software flow problem in serial_core
Date: Thu, 20 Mar 2014 20:34:38 -0400
Message-ID: <532B891E.80705@hurleysoftware.com>
References: <CF505B08.6E64%seth.bollinger@digi.com> <532B743F.2030705@hurleysoftware.com> <CF50E0EB.6E95%seth.bollinger@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CF50E0EB.6E95%seth.bollinger@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Bollinger, Seth" <Seth.Bollinger@digi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 03/20/2014 07:34 PM, Bollinger, Seth wrote:
> Do you have a driver that would be a good example of this?  From look=
ing
> at serial_core.c:uart_start(), is seems that start_tx() is only calle=
d if
> the serial_core ring buffer is not empty.  If we don=C2=B9t stop the
> transmitter, we slew too many characters.

Yeah, you're right; thanks for catching this.
(I was busy looking at the ll driver and completely missed the bug in
the serial core).

uart_start() should not be conditioning the call to start_tx() on
the ring buffer being empty; ll drivers should already be able to handl=
e
that because CTS flow control change will start_tx regardless of the ri=
ng
buffer count.

Will you send a patch?

Regards,
Peter Hurley
