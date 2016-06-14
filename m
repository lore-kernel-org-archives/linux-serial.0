From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/8] tty: serial: fsl_lpuart: support suspend/resume
Date: Mon, 13 Jun 2016 19:42:10 -0700
Message-ID: <AF70EE92-9B41-4ECE-AB5F-E829E611B7C6@agner.ch>
References: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com> <20160609151039.20817-3-bhuvanchandra.dv@toradex.com> <20160611140341.GT20243@tiger> <cdeb3e9b-92c5-77d9-78ec-3af3954e8e16@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <cdeb3e9b-92c5-77d9-78ec-3af3954e8e16@toradex.com>
Sender: linux-clk-owner@vger.kernel.org
To: Bhhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Shawn Guo <shawnguo@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, jslaby@suse.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On June 13, 2016 5:18:19 PM PDT, Bhhuvanchandra DV <bhuvanchandra.dv@toradex.com> wrote:
>Hi Shawn,
>
>On 06/11/2016 02:03 PM, Shawn Guo wrote:
>
>> On Thu, Jun 09, 2016 at 08:40:33PM +0530, Bhuvanchandra DV wrote:
>>> From: Stefan Agner <stefan@agner.ch>
>>>
>>> In order to allow wake support in STOP sleep mode, clocks are
>>> needed. Use imx_clk_gate2_cgr to disable automatic clock gating
>>> in low power mode STOP. This allows to enable wake by UART using:
>>> echo enabled > /sys/class/tty/ttyLP0/power/wakeup
>>>
>>> However, if wake is not enabled, the driver should disable the
>>> clocks explicitly to save power.
>>>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>   drivers/clk/imx/clk-vf610.c     | 12 ++++++------
>> Please send clock driver changes in a separate patch.

The changes are dependet on each other, hence I put it in a single patch. But since it is a new feature it shouldn't really matter...

>
>How about splitting this patchset to two? few patches are having minor
>fixes and the few patches might need some review and discussions.
>May be some thing like DMA fixes and the other minor fixes.

I don't think that splitting up the patchset is necessary, with the current order it is possible to pick up the fixes independently...

--
Stefan

>
>--
>Bhuvan
>
>>
>> Shawn
>>
>>>   drivers/tty/serial/fsl_lpuart.c | 16 ++++++++++++++--
>>>   2 files changed, 20 insertions(+), 8 deletions(-)

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
