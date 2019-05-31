From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: [PATCH 0/6] Convert sa1100 serial to use mctrl gpios
Date: Fri, 31 May 2019 12:12:57 +0100
Message-ID: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

This series takes the next step along the path of cleaning up and
modernising the sa11x0 code, concentrating on the sa1100 serial
driver.  At the end of this conversion, we are left with collie
being the only platform that uses the old platform data get_mctrl
and set_mctrl methods.  As the locomo code is also used with PXA,
this is left for a future cleanup.

The first patch was previously acked quite some time ago.

I'm intending to send this to arm-soc.

 arch/arm/mach-sa1100/assabet.c  |  91 +++++++++++----------------------
 arch/arm/mach-sa1100/badge4.c   |   2 -
 arch/arm/mach-sa1100/h3xxx.c    |  64 ++++-------------------
 arch/arm/mach-sa1100/hackkit.c  |  48 ------------------
 arch/arm/mach-sa1100/neponset.c | 109 +++++++++++-----------------------------
 drivers/tty/serial/Kconfig      |   1 +
 drivers/tty/serial/sa1100.c     |  42 ++++++++++++++--
 7 files changed, 106 insertions(+), 251 deletions(-)


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
