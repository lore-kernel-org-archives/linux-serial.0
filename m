From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH V1] serial:bfin-uart:Remove 'struct timeval'
Date: Thu, 12 Nov 2015 14:49:56 +0100
Message-ID: <4649363.jeEbMAWnTU@wuerfel>
References: <1447335947-14877-1-git-send-email-chao.deng@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447335947-14877-1-git-send-email-chao.deng@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: y2038@lists.linaro.org
Cc: DengChao <chao.deng@linaro.org>, sonic.zhang@analog.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday 12 November 2015 21:45:47 DengChao wrote:
> The bfin-uart code uses real time with struct timeval. This will
> cause problems on 32-bit architectures in 2038 when time_t
> overflows.
> Since the code just needs delta value of time, it is not
> necessary to record them in real time.
> This patch changes the code to use the monotonic time instead,
> replaces struct timeval and do_gettimeofday() with u64 and
> ktime_get_ns().
> 
> Signed-off-by: DengChao <chao.deng@linaro.org>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
