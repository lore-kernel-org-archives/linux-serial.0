From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: [PATCH v1] 8250: add support for DTR/DSR hardware flow control
Date: Mon, 1 Sep 2008 10:23:27 +0200
Message-ID: <000a01c90c0c$031ca6c0$2e01a8c0@acksys.local>
References: <1220024020.2506.79.camel@thetriton.toftronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp04.msg.oleane.net ([62.161.4.4]:42620 "EHLO
	smtp04.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbYIAIZz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Sep 2008 04:25:55 -0400
In-Reply-To: <1220024020.2506.79.camel@thetriton.toftronix.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Christopher Gibson' <chris@toftronix.com.au>, 'linux-serial' <linux-serial@vger.kernel.org>

Your analysis and the new struct are fine to me.

Maybe 'delay_rts_before_send' should be named simply 'delay_before_send'
since it applies to dtr as well. Same for delay_rts_after_send.

Jean-Pierre Tosoni

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Christopher
> Gibson
> Sent: Friday, August 29, 2008 5:34 PM
> To: linux-serial
> Subject: Re: [PATCH v1] 8250: add support for DTR/DSR hardware flow
> control
>
>
> I've had a look at the asm-cris rs485 implementation, as JP Tosoni
> suggested, and say that that interface would satisfy my requirements,
> and would also provide a suitable interface for controlling out dated
> radio modems.  I would say though that some additional consideration
> should be given to the interface.
>
> I had assumed that the rts_on_send, and rts_after_send were time delay
> figures until I read the suggested rework by Alan Cox, then
> read through
> the crisv10.c code.  In the crisv10 serial driver code the rts_on_send
> specifies the state that the RTS line should change to when a call to
> the TIOCSERWRRS485 ioctl is made the rts_after_send is the state that
> RTS is changed to after the transmission has completed.  So in two of
> the four possible combinations user space control of RTS is still
> required in order to get any directional control activity out
> of the RTS
> line.  I would be so bold as to say that this combination of user /
> automatic direction control would be unlikely to be ever used
> by anyone.
> If this is correct then the two flags could be replaced with one
> rts_tx_level indicating if RTS should be high or low during a
> transmission, and pre-transmission delay.  Would this be clearer?
>
> The other observation about the crsv10.c implementation is
> that the call
> to TIOCSERWRRS485 ioctl, or write() if the enabled flag is
> set, does not
> return until the transmission has completed and the line has
> been turned
> around.  This functionality could be restrictive in some situations
> (single threaded user applications that wish to do other stuff during
> transmission).
>
> My suggestion would be to scrap the TIOCSERWRRS485 ioctl, in favour of
> using the standard write(fd) and drain(fd) function calls,
> but to stick
> with the TIOCSERSETRS485 ioctl for automatic direction control port
> setup.  I would be suggesting a control structure (based on Alan Cox's
> suggested modifications of the include/asm-cris/rs485.h) as follows:
>
> /*
>  * Serial interface for controlling RS485 settings on chips
> with suitable
>  * support. Set with TIOCSRS485 and get with TIOCGRS485 if
> supported by your
>  * platform. The set function returns the new state, with any
> unsupported bits
>  * reverted appropriately.
>  */
>
> struct serial_rs485 {
> 	__u32	flags;			/* RS485 feature flags */
> #define SER_RS485_MODES			(7 << 0)
> /* Mask for mode bits. */
> #define SER_RS485_MODE_DISABLED		(0 << 0)
> #define SER_RS485_MODE_RTS_TX_HIGH	(2 << 0)
> #define SER_RS485_MODE_RTS_TX_LOW	(3 << 0)
> #define SER_RS485_MODE_DTR_TX_HIGH	(4 << 0)
> #define SER_RS485_MODE_DTR_TX_LOW	(5 << 0)
> 	__u16	delay_rts_before_send;	/* Milliseconds */
> 	__u16	delay_rts_after_send;	/* Milliseconds */
> 	__u32	padding[6];		/* Memory is cheap, new structs
> 					   are a royal PITA .. */
> };
>
> Any comments?
>
> The above would allow for RTS and DTR direction control as well as
> settings for lead in and lead out timing.
>
> --
> Christopher Gibson <chris@toftronix.com.au>
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

