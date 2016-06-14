From: Bhhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH 2/8] tty: serial: fsl_lpuart: support suspend/resume
Date: Tue, 14 Jun 2016 00:18:19 +0000
Message-ID: <cdeb3e9b-92c5-77d9-78ec-3af3954e8e16@toradex.com>
References: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
 <20160609151039.20817-3-bhuvanchandra.dv@toradex.com>
 <20160611140341.GT20243@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160611140341.GT20243@tiger>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de, jslaby@suse.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bhuvanchandra.dv@toradex.com
List-Id: linux-serial@vger.kernel.org

Hi Shawn,

On 06/11/2016 02:03 PM, Shawn Guo wrote:

> On Thu, Jun 09, 2016 at 08:40:33PM +0530, Bhuvanchandra DV wrote:
>> From: Stefan Agner <stefan@agner.ch>
>>
>> In order to allow wake support in STOP sleep mode, clocks are
>> needed. Use imx_clk_gate2_cgr to disable automatic clock gating
>> in low power mode STOP. This allows to enable wake by UART using:
>> echo enabled > /sys/class/tty/ttyLP0/power/wakeup
>>
>> However, if wake is not enabled, the driver should disable the
>> clocks explicitly to save power.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>   drivers/clk/imx/clk-vf610.c     | 12 ++++++------
> Please send clock driver changes in a separate patch.

How about splitting this patchset to two? few patches are having minor
fixes and the few patches might need some review and discussions.
May be some thing like DMA fixes and the other minor fixes.
