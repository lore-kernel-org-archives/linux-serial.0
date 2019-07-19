From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 0/2] serial: pl011: Fix TX dropping race
Date: Fri, 19 Jul 2019 14:35:23 +0100
Message-ID: <1563543325-12463-1-git-send-email-Dave.Martin@arm.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Phil Elwell <phil@raspberrypi.org>, linux-rpi-kernel@lists.infradead.org, Jiri Slaby <jslaby@suse.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

When serial_core pushes some new TX chars via a call to
pl011_start_tx(), it can race with irqs triggered by ongoing
transmission, overfilling the FIFO and causing characters to be silently
dropped.

This was originally reported by Phil Elwell [1], who proposed an initial
fix.

This series aims for a simpler and more robust solution to the problem.

Any testing much appreciated!  If all looks good, I can repost this on
v5.3-rc1 when that arrives.


As noted in the patches, I'm not sure that the second patch is necessary
(or even desirable).  Please test both with and without the second
patch, and please comment if you have any thoughts on it :)


[1] [PATCH] tty: amba-pl011: Make TX optimisation conditional
http://lists.infradead.org/pipermail/linux-rpi-kernel/2019-July/008832.html


Dave Martin (2):
  serial: pl011: Fix dropping of TX chars due to irq race
  serial: pl011: Don't bother pushing more TX data while TX irq is
    active

 drivers/tty/serial/amba-pl011.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.1.4
