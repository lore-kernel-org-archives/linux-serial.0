From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v4 2/2] serial: mxs-auart: keep the AUART unit in reset
 state when not in use
Date: Fri, 07 Aug 2015 11:30:27 -0400
Message-ID: <55C4CF13.90206@hurleysoftware.com>
References: <1438944424-9053-1-git-send-email-jbe@pengutronix.de> <1438944424-9053-2-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438944424-9053-2-git-send-email-jbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Borleis <jbe@pengutronix.de>, linux-kernel@vger.kernel.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 08/07/2015 06:47 AM, Juergen Borleis wrote:
> Whenever the UART device driver gets closed from userland, the driver
> disables the UART unit and then stops the clocks to save power.
> 
> The bit which disabled the UART unit is described as:
> 
>  "UART Enable. If this bit is set to 1, the UART is enabled. Data
>   transmission and reception occurs for the UART signals. When the
>   UART is disabled in the middle of transmission or reception, it
>   completes the current character before stopping."
> 
> The important part is the "it completes the current character". Whenever
> a reception is ongoing when the UART gets disabled (including the clock
> off) the statemachine freezes and "remembers" this state on the next
> open() when re-enabling the unit's clock.
> 
> In this case we end up receiving an additional bogus character
> immediately.
> 
> The solution in this change is to switch the AUART unit into its reset
> state on close() and only release it from its reset state on the next
> open().
> 
> Note: when the unit is also used as system console it is always 'in use',
> so we cannot reset it on close().

The code is still a bit ackward but looks functional, so

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>


PS - This mxs driver has the same problem as the i.MX driver.
     The irq request and hardware init should be done in startup().
