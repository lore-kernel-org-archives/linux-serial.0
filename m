From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v3] tty: pl011: Avoid spuriously stuck-off interrupts
Date: Mon, 23 Apr 2018 14:49:30 +0100
Message-ID: <CAFEAcA8Q97YNKomCgkujgoY0MoES3edHoFEk_jjXGMCdzBpd9w@mail.gmail.com>
References: <1524490888-849-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1524490888-849-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Andrew Jones <drjones@redhat.com>, Ciro Santilli <ciro.santilli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Wei Xu <xuwei5@hisilicon.com>, linux-serial@vger.kernel.org, arm-mail-list <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 23 April 2018 at 14:41, Dave Martin <Dave.Martin@arm.com> wrote:
> This is an update to a previous RFC v2 [1], to fix a problem observed by
> the qemu community that causes serial input to hang when booting a
> simulated system with data already queued in the UART FIFO [2].
>
> After discussion, I decided that the approach in [1] was over-
> engineered: it tries to preserve a guarantee that people shouldn't be
> relying on anyway, namely that data sent to the UART prior to kernel
> boot will be received by the kernel; or more generally that data
> received by the UART while the pl011 driver is not opened will be
> received (either intact or at all) by the driver.
>
> If anyone can please test the following and let me know the results,
> that would be much appreciated!
>
>  a) Check that you can still reproduce the bug on mainline without this
>     patch.
>
>  b) Check whether this patch fixes the problem.

Thanks. I'm cc'ing Ciro and Drew, who are the two people I
recall reporting this issue to me.
Link to the patch for their benefit:
 http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573120.html

-- PMM
