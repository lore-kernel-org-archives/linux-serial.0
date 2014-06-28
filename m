From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH] serial: 8250_dw: support high baudrates if possible
Date: Sat, 28 Jun 2014 15:15:56 -0500
Message-ID: <53AF227C.3000102@linaro.org>
References: <1403889920-1127-1-git-send-email-elder@linaro.org> <20140628163608.0c5536a9@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140628163608.0c5536a9@alan.etchedpixels.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, david.daney@cavium.com, loic.poulain@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/28/2014 10:36 AM, One Thousand Gnomes wrote:
> On Fri, 27 Jun 2014 12:25:20 -0500
>> +		rate = 16 * max(115200U, (unsigned int)baud);
>> +
> 
> This assumes an arbitarily configurable clock, which is not I think the
> usual case. 

If the clock's rate can't change, this will return an error,
and the recorded rate (p->uartclk) will not be changed.

This should only matter when attempting to set a baud rate higher
than 115200.  It *is* possible that some particular high rate
will realize a better signal rate than whatever results from
requesting 16 times the baud (or even 16 * 115200).

I could make this work *only* for my particular part(s) by
relying on a different device tree compatible string and
setting a flag.  It would be nice if other implementations
could benefit from this though.

					-Alex

>> +		/*
>> +		 * Request a different clock rate if necessary, and
>> +		 * record it if successful.
>> +		 */
>> +		if (rate != p->uartclk) {
>> +			BUG_ON(!data->clk);
>> +			if (!clk_set_rate(data->clk, (unsigned long)rate))
>> +				p->uartclk = rate;
>> +		}
> 
> 
