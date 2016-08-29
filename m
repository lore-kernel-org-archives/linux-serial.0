From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/6] SA11x0 serial updates
Date: Mon, 29 Aug 2016 13:05:31 +0100
Message-ID: <20160829120531.GG1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
 <20160829110157.GE1041@n2100.armlinux.org.uk>
 <20160829112540.GF1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160829112540.GF1041@n2100.armlinux.org.uk>
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

This series converts SA11x0 serial to make use of the mctrl helpers
where appropriate.  This allows us to remove several board-specific
callbacks.

As serial is critical for console output, we report but otherwise
ignore any error except probe deferral from mctrl initialisation.

Obviously, as this is part of a larger series (and has dependencies
on the previous series) this can not be applied to individual
subsystem maintainer trees.  Please ack.

 arch/arm/mach-sa1100/assabet.c  |  91 +++++++++++----------------------
 arch/arm/mach-sa1100/badge4.c   |   2 -
 arch/arm/mach-sa1100/h3xxx.c    |  64 ++++-------------------
 arch/arm/mach-sa1100/hackkit.c  |  48 ------------------
 arch/arm/mach-sa1100/neponset.c | 109 +++++++++++-----------------------------
 drivers/tty/serial/Kconfig      |   1 +
 drivers/tty/serial/sa1100.c     |  42 ++++++++++++++--
 7 files changed, 106 insertions(+), 251 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
