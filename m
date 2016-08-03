From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH RESEND v2 0/8] Improve Rx/Tx DMA implementation
Date: Wed, 3 Aug 2016 10:09:22 +0530
Message-ID: <e4084260-be57-8f30-a016-c75e57237392@toradex.com>
References: <20160719074310.16872-1-bhuvanchandra.dv@toradex.com>
 <a5d420fa-0837-f0af-dee9-a61562d473c2@toradex.com>
 <20160802152835.GC21602@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160802152835.GC21602@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: kernel@pengutronix.de, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, linux-serial@vger.kernel.org, jslaby@suse.com, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Andrew,

On 08/02/16 20:58, Andrew Lunn wrote:

> On Tue, Aug 02, 2016 at 01:23:32PM +0530, Bhuvanchandra DV wrote:
>> Hello,
>>
>> Any comments on this patchset?
> I tested v1 on my Vybrid board and it fixed the corruption issues i
> was seeing with the console on a serial port. I will try to test this
> version.

Thanks! for testing it. As such there is nothing much changed w.r.t
code, we only split the suspend/resume patch in v2.

--
Bhuvan

>
>      Andrew
>
>> On 07/19/16 13:13, Bhuvanchandra DV wrote:
>>
>>> Drop the clock change patch from v2 patchset[1] since it is applied.
>>>
>>> Changes since v1:
>>> Split suspend/resume patch.
>>>
>>> [1] https://lkml.org/lkml/2016/6/28/124
>>>
>>> Bhuvanchandra DV (5):
>>>    tty: serial: fsl_lpuart: Fix broken 8m/s1 support
>>>    tty: serial: fsl_lpuart: Use cyclic DMA for Rx
>>>    tty: serial: fsl_lpuart: Use scatter/gather DMA for Tx
>>>    tty: serial: fsl_lpuart: Update suspend/resume for DMA mode
>>>    tty: serial: fsl_lpuart: Add support for RS-485
>>>
>>> Stefan Agner (3):
>>>    tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
>>>    tty: serial: fsl_lpuart: support suspend/resume
>>>    tty: serial: fsl_lpuart: fix clearing of receive flag
>>>
>>>   drivers/tty/serial/fsl_lpuart.c | 810 +++++++++++++++++++++++-----------------
>>>   1 file changed, 476 insertions(+), 334 deletions(-)
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
