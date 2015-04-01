From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH REPOST v4 0/2] serial/amba-pl011: Refactor and simplify TX
 FIFO handling
Date: Wed,  1 Apr 2015 12:05:40 +0100
Message-ID: <1427886345-8507-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Jakub=20Kici=C5=84ski?= <moorray3@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Patches are based on
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next

This is a repost to add Jakub's S-o-B only.

There is no code change compared with v3.


Note that I'll be mostly offline for a week or so from tomorrow.

Andre depends on this series for his SBSA UART stuff, so I recommend
to coordinate with him if there are still issues that need to be
resolved in the meantime.  There are no outstanding issues that I'm
aware of.

Thanks
---Dave

Dave Martin (2):
  Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is
    not open"
  serial/amba-pl011: Refactor and simplify TX FIFO handling

 drivers/tty/serial/amba-pl011.c |  118 +++++++++------------------------------
 1 file changed, 27 insertions(+), 91 deletions(-)

-- 
1.7.10.4
