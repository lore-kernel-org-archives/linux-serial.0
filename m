From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v4] tty: pl011: Avoid spuriously stuck-off interrupts
Date: Thu, 26 Apr 2018 13:11:41 +0100
Message-ID: <CAFEAcA9aVWC2M4cExTgPdwGqAOofWgm-61FUuZHNFWvFeNiHJA@mail.gmail.com>
References: <1524740081-4979-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1524740081-4979-1-git-send-email-Dave.Martin@arm.com>
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

On 26 April 2018 at 11:54, Dave Martin <Dave.Martin@arm.com> wrote:
> This is an update to a previous RFC v3 [1], to fix a problem observed by
> the qemu community that causes serial input to hang when booting a
> simulated system with data already queued in the UART FIFO [2].
>
> RFC v3 did not solve the problem by itself, due to the problem being
> triggered again in pl011_enable_interrupts() after working around it
> in pl011_hwinit().  See the updated commit message in the patch for
> details.
>
> This patch is intended to supersede the previous RFCs, so please test
> _without_ RFC v2 (or 3) applied.
>
> If you can, please:
>
>  a) Check that you can still reproduce the bug on mainline without this
>     patch.
>
>  b) Check whether this patch fixes the problem.

Adding back to the CC list the people who might be able to do
this testing...
Link to v4 patch:
https://patchwork.kernel.org/patch/10365551/

thanks
-- PMM
