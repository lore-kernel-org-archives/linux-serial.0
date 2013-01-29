From: Chanho Min <chanho.min@lge.com>
Subject: Re: [PATCH v2] ARM: PL011: Add support for Rx DMA buffer polling
Date: Tue, 29 Jan 2013 11:41:07 +0900
Message-ID: <CAOAMb1CCoOWgab7NYYYRVjoQBoBx4XDeeLOBjJ4RzsBwRpXv6Q@mail.gmail.com>
References: <CAOAMb1AsetjcNa_K6g=6K_s=0+tTH1aGLuX8emYrfgJOcx54cw@mail.gmail.com>
	<CACRpkdaECZ5qtUVS=28eDyzLWvxx=mP6dWML5mYs9kwqnhEoJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaECZ5qtUVS=28eDyzLWvxx=mP6dWML5mYs9kwqnhEoJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-serial@vger.kernel.org, Chanho Min <chanho0207@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 28, 2013 at 5:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jan 28, 2013 at 9:15 AM, Chanho Min <chanho.min@lge.com> wrote:
>> [Russell]
>>>Well, I thought I had explained that I'd prefer to see the poll rate
>>>adjusted with the baud rate, but maybe I wasn't explicit enough.
>>>Instead, what we seem to have ended up with are two new entries in
>>>platform data (which we're trying to get away from with DT):
>>>
>>>+       unsigned int dma_rx_poll_rate;
>>>+       unsigned int dma_rx_poll_timeout;

>>>Should we scale the polling interval according to baud
>>>rate?
>>
>> It is also our concern, I will suggest the proper way.

It was thought a way to reduce unnecessary cpu usage,
but, now we add dma_rx_poll_timeout to stop polling during idle.
I thought it is preferred  the poll rate is decided by it's user than
auto scale.
because The required response to tty can be differ from platform to platform.
Some platform need fast response even if more cpu usage is needed,
but other platform will be enough to handle  with slow response.

Any opinion will be appreciated.

Thanks
Chanho
