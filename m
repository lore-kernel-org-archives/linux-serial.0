From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] serial: 8250_early: Setup divider when uartclk is passed
Date: Tue, 24 Apr 2018 14:27:47 +0200
Message-ID: <4e5e4f48-ec79-2c99-a321-83c0e383991a@xilinx.com>
References: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
 <f8c69fee-8889-f0aa-1235-b7a65068238b@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <f8c69fee-8889-f0aa-1235-b7a65068238b@mips.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Matt Redfearn <matt.redfearn@mips.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: stable <stable@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Douglas Anderson <dianders@chromium.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-serial@vger.kernel.org

Hi Matt,

On 23.4.2018 15:21, Matt Redfearn wrote:
> Hi Michal
> 
> On 23/04/18 10:18, Michal Simek wrote:
>> device->baud is always non zero value because it is checked already in
>> early_serial8250_setup() before init_port is called.
> 
> True, currently init_port is only called from the one location and so
> the test is a little redundant, though I don't see the harm in testing
> both inputs to the divisor calculation immediately before use such that
> any future call path avoids setting a bad divisor.

I will let others to decide.

> 
>>
>> Fixes: 0ff3ab701963 ("serial: 8250_early: Only set divisor if valid
>> clk & baud")
>> Cc: stable <stable@vger.kernel.org>
> 
> Even if the test is dropped going forward, I wouldn't consider it's
> presence a "bug" such that a fix needs to be backported.

Not a problem with not adding this to stable.

Thanks,
Michal
