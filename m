From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V3] tty: serial: imx.c: Reset UART before activating
 interrupts
Date: Fri, 31 Jul 2015 09:04:09 -0300
Message-ID: <CAOMZO5DwHWjTsW4v01Tc0WoXKE5hk1-1dwCgPrg9_hNOd7XiKg@mail.gmail.com>
References: <1438343953-31679-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438343953-31679-1-git-send-email-david@protonic.nl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Jander <david@protonic.nl>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <sascha@saschahauer.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Baker <tyler.baker@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 31, 2015 at 8:59 AM, David Jander <david@protonic.nl> wrote:
> If the UART has been in use before this driver was loaded, IRQs might be
> active and get fired as soon as we set the handler, which will crash
> in the spin_lock_irqsave(&sport->port.lock, flags) because port.lock is
> not initialized until the port is added at the end of probe.
>
> Signed-off-by: David Jander <david@protonic.nl>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
