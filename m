From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3] serial: mxs-auart: keep the AUART unit in reset state
 when not in use
Date: Mon, 20 Jul 2015 09:00:21 -0400
Message-ID: <55ACF0E5.6040107@hurleysoftware.com>
References: <1437032458-8577-1-git-send-email-jbe@pengutronix.de> <55A8FEAE.9010502@hurleysoftware.com> <201507201004.02646.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201507201004.02646.jbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Borleis <jbe@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 07/20/2015 04:04 AM, Juergen Borleis wrote:
> Hi Peter,
> 
> On Friday 17 July 2015 15:10:06 Peter Hurley wrote:
>> On 07/16/2015 03:40 AM, Juergen Borleis wrote:
>>> Whenever the UART device driver gets closed from userland, the driver
>>> disables the UART unit and then stops its clock to save power.
>>>
>>> The bit which disabled the UART unit is described as:
>>>
>>>   "UART Enable. If this bit is set to 1, the UART is enabled. Data
>>>   transmission and reception occurs for the UART signals. When the
>>>   UART is disabled in the middle of transmission or reception, it
>>>   completes the current character before stopping."
>>>
>>> The important part is the "it completes the current character". Whenever
>>> a reception is ongoing when the UART gets disabled (including the clock
>>> off) the statemachine freezes and "remembers" this state on the next
>>> open() and re-enabling of the unit's clock.
>>>
>>> In this case we end up receiving an additional bogus character
>>> immediately.
>>>
>>> The solution in this change is to move the AUART unit into its reset
>>> state on close() and only release it from its reset state on the next
>>> open().
>>>
>>> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
>>> ---
>>>
>>> Notes:
>>>     v3:
>>>      - missing newline added to an error message
>>>
>>>     v2:
>>>      - rename mxs_auart_do_reset() to mxs_auart_keep_reset() to better
>>> reflect what it really does
>>>      - adapt the delay in mxs_auart_keep_reset() to wait for the reset of
>>> the AURAT unit to what is used in mxs_auart_reset()
>>
>> The function names and semantics are not clear. See below.
>>
>>>      - typo fixed
>>>
>>>  drivers/tty/serial/mxs-auart.c | 38
>>> ++++++++++++++++++++++++++++++-------- 1 file changed, 30 insertions(+),
>>> 8 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/mxs-auart.c
>>> b/drivers/tty/serial/mxs-auart.c index 13cf773..135ee6c 100644
>>> --- a/drivers/tty/serial/mxs-auart.c
>>> +++ b/drivers/tty/serial/mxs-auart.c
>>> @@ -858,6 +858,30 @@ static void mxs_auart_reset(struct uart_port *u)
>>>  	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
>>>  }
>>>
>>> +static void mxs_auart_keep_reset(struct uart_port *u)
>>> +{
>>> +	int i;
>>> +	u32 reg;
>>> +
>>> +	reg = readl(u->membase + AUART_CTRL0);
>>> +	/* if already in reset state, keep it untouched */
>>> +	if (reg & AUART_CTRL0_SFTRST)
>>> +		return;
>>> +
>>> +	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
>>> +	writel(AUART_CTRL0_SFTRST, u->membase + AUART_CTRL0_SET);
>>> +
>>> +	for (i = 0; i < 10000; i++) {
>>> +		reg = readl(u->membase + AUART_CTRL0);
>>> +		/* reset is finished when the clock is gated */
>>> +		if (reg & AUART_CTRL0_CLKGATE)
>>> +			return;
>>> +		udelay(3);
>>> +	}
>>> +
>>> +	dev_err(u->dev, "Failed to reset the unit.\n");
>>> +}
>>> +
>>>  static int mxs_auart_startup(struct uart_port *u)
>>>  {
>>>  	int ret;
>>> @@ -867,7 +891,10 @@ static int mxs_auart_startup(struct uart_port *u)
>>>  	if (ret)
>>>  		return ret;
>>>
>>> -	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
>>> +	/* reset the unit if not aleady done */
>>> +	mxs_auart_keep_reset(u);
>>
>> Why is this performing a soft-reset on open now? Didn't
>> mxs_auart_shutdown() already leave it in this state?
> 
> The probe function let the device left without reset. That is why I do a reset 
> here (which is skipped if the device is already in reset state).

So you're "fixing" something else (reset @ probe) without _any_
indication in the changelog?


>> Because if you're performing a soft-reset deliberately as part of the
>> initial condition, you make no mention of that in the changelog.
> 
> If I switch the device into the reset state immediately after the probe 
> function has finished, I could skip this additional reset.
> 
>>> +	/* bring it out of reset now */
>>> +	mxs_auart_reset(u);
>>
>> mxs_auart_reset() is really not resetting but simply performing a block
>> enable. Isn't there a generic block enable for the iMX.2x SoCs? (Maybe
>> there should be)
>>
>> The names of these functions don't match expected operations of startup().
>> Start up should be enabling the device, not keeping it in reset.
>>
>> And "keep reset" immediately followed by "reset" makes no sense.
> 
> mxs_auart_reset() is a bad name from the beginning. But I just wanted to keep 
> this change small and only change things that are really required.
> I will try with a V4.

ISTM this should be split into 2 or 3 separate patches:
1. Rename mxs_auart_reset()
2. Fix stale rx on re-open
3. Reset @ probe


Regards,
Peter Hurley
