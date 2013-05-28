From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/5] ARM: davinci: fix UART clock enabling
Date: Tue, 28 May 2013 13:58:01 +0530
Message-ID: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Patch series addresses below issues:
1) Do clk_get on dev_id when there is single clock for a module
2) Fix garbled UART log with DT kernel on da850-evm.
3) Cleanup of serila platform code.

Applies on top of v3.9-rc9 of Linus's.
Tested on da850-evm. Able to see proper bootup log and console on UART2.

Since v1:
Change names of platform data names appropriately.
Added 5/5: platform code cleanup.

Manjunathappa, Prakash (5):
  ARM: davinci: uart: move to devid based clk_get
  ARM: davinci: da850: override device name of UART in DT kernel
  ARM: davinci: da850: do not specify clock_frequency for UART DT node
  ARM: davinci: da8xx: remove da8xx_uart_clk_enable
  ARM: davinci: serial: platform code cleanup

 arch/arm/boot/dts/da850.dtsi                   |    3 -
 arch/arm/mach-davinci/board-da830-evm.c        |    6 +--
 arch/arm/mach-davinci/board-da850-evm.c        |    6 +--
 arch/arm/mach-davinci/board-dm355-evm.c        |    6 +--
 arch/arm/mach-davinci/board-dm355-leopard.c    |    6 +--
 arch/arm/mach-davinci/board-dm365-evm.c        |    6 +--
 arch/arm/mach-davinci/board-dm644x-evm.c       |    6 +--
 arch/arm/mach-davinci/board-dm646x-evm.c       |    6 +--
 arch/arm/mach-davinci/board-mityomapl138.c     |    6 +--
 arch/arm/mach-davinci/board-neuros-osd2.c      |    6 +--
 arch/arm/mach-davinci/board-omapl138-hawk.c    |    6 +--
 arch/arm/mach-davinci/board-sffsdr.c           |    7 +--
 arch/arm/mach-davinci/da830.c                  |    7 +--
 arch/arm/mach-davinci/da850.c                  |    7 +--
 arch/arm/mach-davinci/da8xx-dt.c               |   11 +----
 arch/arm/mach-davinci/devices-da8xx.c          |   41 +++++++++++++-----
 arch/arm/mach-davinci/devices-tnetv107x.c      |   36 +++++++++++-----
 arch/arm/mach-davinci/dm355.c                  |   48 ++++++++++++++-------
 arch/arm/mach-davinci/dm365.c                  |   36 ++++++++++------
 arch/arm/mach-davinci/dm644x.c                 |   48 ++++++++++++++-------
 arch/arm/mach-davinci/dm646x.c                 |   47 ++++++++++++++-------
 arch/arm/mach-davinci/include/mach/common.h    |    1 -
 arch/arm/mach-davinci/include/mach/da8xx.h     |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h    |   14 ++++---
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    3 +-
 arch/arm/mach-davinci/serial.c                 |   54 +++++++++---------------
 arch/arm/mach-davinci/tnetv107x.c              |    8 ++--
 27 files changed, 227 insertions(+), 206 deletions(-)

-- 
1.7.4.1
