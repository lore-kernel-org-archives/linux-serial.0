From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 1/4] msm_serial: Fix NUL byte output on UARTDM
Date: Wed, 24 Jul 2013 13:29:44 -0700
Message-ID: <20130724202944.GB10926@codeaurora.org>
References: <1374691051-28544-1-git-send-email-sboyd@codeaurora.org>
 <1374691051-28544-2-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374691051-28544-2-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 24, 2013 at 11:37:28AM -0700, Stephen Boyd wrote:
>UARTDM serial devices require us to wait for the entire TX fifo
>to drain before we can change the contents of the NCF_TX
>register. Furthermore, if we write any characters to the TX fifo
>within the same clock cycle of changing the NCF_TX register the
>NCF_TX register won't latch properly.
>
>To fix these issues we should read back the NCF_TX register to
>delay any TX fifo accesses by a clock cycle and we should wait
>for the TX fifo to drain (instead of just waiting for the fifo to
>be ready to receive more characters). Failure to do so leads to
>random NUL bytes interspersed in the output.
>
>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>---
> drivers/tty/serial/msm_serial.c | 14 +++++++++-----
> drivers/tty/serial/msm_serial.h |  1 +
> 2 files changed, 10 insertions(+), 5 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
