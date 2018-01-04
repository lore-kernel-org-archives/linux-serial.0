From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH -next] serial: 8250_uniphier: fix error return code in
 uniphier_uart_probe()
Date: Thu, 4 Jan 2018 16:41:12 +0900
Message-ID: <CAK7LNASinqpJV+EfL2tKWW5cDMsabMHfCuuC-oARfLLAsQ-rqA@mail.gmail.com>
References: <1515051735-59992-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1515051735-59992-1-git-send-email-weiyongjun1@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

2018-01-04 16:42 GMT+09:00 Wei Yongjun <weiyongjun1@huawei.com>:
> Fix to return a negative error code from the port register error
> handling case instead of 0, as done elsewhere in this function.
>
> Fixes: 39be40ce066d ("serial: 8250_uniphier: fix serial port index in private data")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks!

-- 
Best Regards
Masahiro Yamada
