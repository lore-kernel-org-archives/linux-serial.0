From: "Bollinger, Seth" <Seth.Bollinger@digi.com>
Subject: Re: Possible software flow problem in serial_core
Date: Fri, 21 Mar 2014 00:48:14 +0000
Message-ID: <CF50F620.6EC5%seth.bollinger@digi.com>
References: <CF505B08.6E64%seth.bollinger@digi.com>
 <532B743F.2030705@hurleysoftware.com>
 <CF50E0EB.6E95%seth.bollinger@digi.com> <532B891E.80705@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <532B891E.80705@hurleysoftware.com>
Content-Language: en-US
Content-ID: <0040CEEBC5F68448B2A7BF85A466E136@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


>Yeah, you're right; thanks for catching this.
>(I was busy looking at the ll driver and completely missed the bug in
>the serial core).
>
>uart_start() should not be conditioning the call to start_tx() on
>the ring buffer being empty; ll drivers should already be able to handle
>that because CTS flow control change will start_tx regardless of the ring
>buffer count.
>
>Will you send a patch?

Sure thing.  Just to be clear, you want to remove the ring buffer tests
and leave the tty tests, right?

This will have to wait for the morning though.  :)

Seth
