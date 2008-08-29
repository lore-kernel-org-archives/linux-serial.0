From: Christopher Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH v1] 8250: add support for DTR/DSR hardware flow control
Date: Sat, 30 Aug 2008 01:33:40 +1000
Message-ID: <1220024020.2506.79.camel@thetriton.toftronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:35016 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751359AbYH2Pco (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Aug 2008 11:32:44 -0400
Received: from localhost ([127.0.0.1] ident=chris)
	by thetriton.toftronix.com.au with esmtp (Exim 4.69)
	(envelope-from <chris@toftronix.com.au>)
	id 1KZ5ym-0000za-Ra
	for linux-serial@vger.kernel.org; Sat, 30 Aug 2008 01:33:40 +1000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

I've had a look at the asm-cris rs485 implementation, as JP Tosoni
suggested, and say that that interface would satisfy my requirements,
and would also provide a suitable interface for controlling out dated
radio modems.  I would say though that some additional consideration
should be given to the interface.

I had assumed that the rts_on_send, and rts_after_send were time delay
figures until I read the suggested rework by Alan Cox, then read through
the crisv10.c code.  In the crisv10 serial driver code the rts_on_send
specifies the state that the RTS line should change to when a call to
the TIOCSERWRRS485 ioctl is made the rts_after_send is the state that
RTS is changed to after the transmission has completed.  So in two of
the four possible combinations user space control of RTS is still
required in order to get any directional control activity out of the RTS
line.  I would be so bold as to say that this combination of user /
automatic direction control would be unlikely to be ever used by anyone.
If this is correct then the two flags could be replaced with one
rts_tx_level indicating if RTS should be high or low during a
transmission, and pre-transmission delay.  Would this be clearer?

The other observation about the crsv10.c implementation is that the call
to TIOCSERWRRS485 ioctl, or write() if the enabled flag is set, does not
return until the transmission has completed and the line has been turned
around.  This functionality could be restrictive in some situations
(single threaded user applications that wish to do other stuff during
transmission).

My suggestion would be to scrap the TIOCSERWRRS485 ioctl, in favour of
using the standard write(fd) and drain(fd) function calls, but to stick
with the TIOCSERSETRS485 ioctl for automatic direction control port
setup.  I would be suggesting a control structure (based on Alan Cox's
suggested modifications of the include/asm-cris/rs485.h) as follows:

/*
 * Serial interface for controlling RS485 settings on chips with suitable
 * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by your
 * platform. The set function returns the new state, with any unsupported bits
 * reverted appropriately.
 */

struct serial_rs485 {
	__u32	flags;			/* RS485 feature flags */
#define SER_RS485_MODES			(7 << 0)	/* Mask for mode bits. */
#define SER_RS485_MODE_DISABLED		(0 << 0)
#define SER_RS485_MODE_RTS_TX_HIGH	(2 << 0)
#define SER_RS485_MODE_RTS_TX_LOW	(3 << 0)
#define SER_RS485_MODE_DTR_TX_HIGH	(4 << 0)
#define SER_RS485_MODE_DTR_TX_LOW	(5 << 0)
	__u16	delay_rts_before_send;	/* Milliseconds */
	__u16	delay_rts_after_send;	/* Milliseconds */
	__u32	padding[6];		/* Memory is cheap, new structs
					   are a royal PITA .. */
};

Any comments?

The above would allow for RTS and DTR direction control as well as
settings for lead in and lead out timing.

-- 
Christopher Gibson <chris@toftronix.com.au>

