From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3] serial: mxs-auart: keep the AUART unit in reset
 state when not in use
Date: Fri, 17 Jul 2015 16:35:28 +0200
Message-ID: <1437143728.3254.10.camel@pengutronix.de>
References: <1437032458-8577-1-git-send-email-jbe@pengutronix.de>
	 <55A8FEAE.9010502@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A8FEAE.9010502@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Juergen Borleis <jbe@pengutronix.de>, Stefan Wahren <stefan.wahren@i2se.com>, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Am Freitag, den 17.07.2015, 09:10 -0400 schrieb Peter Hurley:
> Hi Juergen,
> 
> On 07/16/2015 03:40 AM, Juergen Borleis wrote:
> > Whenever the UART device driver gets closed from userland, the driver
> > disables the UART unit and then stops its clock to save power.
> > 
> > The bit which disabled the UART unit is described as:
> > 
> >   "UART Enable. If this bit is set to 1, the UART is enabled. Data
> >   transmission and reception occurs for the UART signals. When the
> >   UART is disabled in the middle of transmission or reception, it
> >   completes the current character before stopping."
> > 
> > The important part is the "it completes the current character". Whenever
> > a reception is ongoing when the UART gets disabled (including the clock
> > off) the statemachine freezes and "remembers" this state on the next
> > open() and re-enabling of the unit's clock.
> > 
> > In this case we end up receiving an additional bogus character
> > immediately.
> > 
> > The solution in this change is to move the AUART unit into its reset
> > state on close() and only release it from its reset state on the next
> > open().
> > 
> > Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> > ---
> > 
> > Notes:
> >     v3:
> >      - missing newline added to an error message
> >     
> >     v2:
> >      - rename mxs_auart_do_reset() to mxs_auart_keep_reset() to better reflect
> >        what it really does
> >      - adapt the delay in mxs_auart_keep_reset() to wait for the reset of the
> >        AURAT unit to what is used in mxs_auart_reset()
> 
> The function names and semantics are not clear. See below.
[...]
> > +	/* bring it out of reset now */
> > +	mxs_auart_reset(u);
> 
> mxs_auart_reset() is really not resetting but simply performing a block enable.
> Isn't there a generic block enable for the iMX.2x SoCs? (Maybe there should be)
> 
> The names of these functions don't match expected operations of startup().
> Start up should be enabling the device, not keeping it in reset.
> 
> And "keep reset" immediately followed by "reset" makes no sense.

I'd call the pair mxs_auart_reset_assert and mxs_auart_reset_deassert.

regards
Philipp
