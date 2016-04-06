From: cprundea@codeaurora.org
Subject: RE: [PATCH] tty: serial: msm: Support more bauds
Date: Wed, 06 Apr 2016 10:44:18 -0500
Message-ID: <c512f9d889da37f1228f15060a6543bb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Ivan T. Ivanov" <iivanov.xz@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <andy.gross@linaro.org>, mmcclint@codeaurora.org
List-Id: linux-serial@vger.kernel.org

On 25/03/16 21:35, Stephen Boyd wrote:
> The msm_find_best_baud() function is written with the assumption
> that the port->uartclk rate is fixed to a particular rate at boot
> time, but now this driver changes that clk rate at runtime when
> the baud is changed.
> 
> The way the hardware works is that an input clk rate comes from
> the clk controller into the uart hw block. That rate is typically
> 1843200 or 3686400 Hz. That rate can then be divided by an
> internal divider in the hw block to achieve a particular baud on
> the serial wire. msm_find_best_baud() is looking for that divider
> value.
> 
> A few things are wrong with the way the code is written. First,
> it assumes that the maximum baud that the uart can support if the
> clk rate is fixed at boot is 460800, which would correspond to an
> input clk rate of 230400 * 16 == 3686400 Hz.  Except some devices
> have a boot rate of 1843200 Hz or max baud of 115200, so
> achieving 230400 on those devices doesn't work at all because we
> don't increase the clk rate unless max baud is 460800.
> 
> Second, we can't achieve bauds higher than 460800 that require
> anything besides a divisor of 1, because we always call
> msm_find_best_baud() with a fixed port->uartclk rate that will
> eventually be changed after we calculate the divisor. So if we
> need to get a baud of 500000, we'll just multiply that by 16 and
> hope that the clk can give us 500000 * 16 == 8000000 Hz, which it
> typically can't do. To really achieve 500000 baud, we need to get
> an input clk rate of 24000000 Hz and then divide that by 3 inside
> the uart hardware.
> 
> Finally, we return success for bauds even when we can't actually
> achieve them. This means that when the user asks for 500000 baud,
> we actually get 921600 right now, but the user doesn't know that.
> 
> Fix all of this by searching through the divisor and clk rate
> space with a combination of clk_round_rate() and baud
> calculations, keeping track of the best clk rate and divisor we
> find if we can't get an exact match. Typically we can get an
> exact match with a divisor of 1, but sometimes we need to keep
> track and try more frequencies. On my msm8916 device, this
> results in all standard bauds in baud_table being supported
> except for 1800, 576000, 1152000, and 4000000.
> 
> Fixes: 850b37a71bde ("tty: serial: msm: Remove 115.2 Kbps maximum baud 
> rate limitation")
> Cc: "Ivan T. Ivanov" <iivanov.xz@gmail.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Matthew McClintock <mmcclint@codeaurora.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

tested on DK04

Tested-by: Cristian Prundeanu <cprundea@codeaurora.org>
