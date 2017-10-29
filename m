From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH 0/3] MIPS: AR7: assorted fixes
Date: Sun, 29 Oct 2017 16:27:18 +0100
Message-ID: <20171029152721.6770-1-jonas.gorski@gmail.com>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Florian Fainelli <f.fainelli@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: linux-serial@vger.kernel.org

This patchset fixes a few issues found in AR7 that accumulated in the
past few years. One was fixed for ages in OpenWrt/LEDE and never made
it upstream, the others weren't noticed until now.

Jonas Gorski (2):
  MIPS: AR7: defer registration of GPIO
  MIPS: AR7: ensure the port type's FCR value is used

Oswald Buddenhagen (1):
  MIPS: AR7: ensure that serial ports are properly set up

 arch/mips/ar7/platform.c | 5 +++++
 arch/mips/ar7/prom.c     | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.13.2
