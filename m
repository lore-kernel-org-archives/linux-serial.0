From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v2 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
Date: Wed, 19 Aug 2015 17:48:04 -0400
Message-ID: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
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
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joachim Eastwood <manabian@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

[v2: drop dead module code removal from 8250_lpc18xx.c ; instead convert it
 from bool to tristate ; also add ack to hvc_console commit.]

This second set of patches to drivers/tty steps outside of the serial
dir, and an improved auditing finds two more serial drivers pretending
to be modular that really are not.

The reasoning for doing this is the same as the first set[1] of patches
and is largely copied below:

  In the previous merge window, we made changes to allow better
  delineation between modular and non-modular code in commit
  0fd972a7d91d6e15393c449492a04d94c0b89351 ("module: relocate module_init
  from init.h to module.h").  This allows us to now ensure module code
  looks modular and non-modular code does not accidentally look modular
  without suffering build breakage.
  
  Here we target code that is, by nature of their Kconfig settings, only
  available to be built-in, but implicitly presenting itself as being
  possibly modular by way of using modular headers, macros, and functions.
  
  The goal here is to remove that illusion of modularity from these
  drivers, but in a way that leaves the actual runtime unchanged.
  In doing so, we remove code that has never been tested and adds
  no value to the tree.  And we begin the process of expecting a
  level of consistency between the Kconfig of a driver and the code
  that the driver uses.
  
Build tested for allyesconfig on x86_64, and ARM for lpc81xx, and powerpc
for hvc_console and mpsc, layered onto tty/tty-next as a baseline.

Paul.

[1] https://lkml.kernel.org/r/1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com
--

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-serial@vger.kernel.org

Paul Gortmaker (5):
  drivers/tty: make pty.c slightly more explicitly non-modular
  drivers/tty: make sysrq.c slightly more explicitly non-modular
  drivers/tty: make hvc_console.c explicitly non-modular
  drivers/tty: make serial/mpsc.c driver explicitly non-modular
  drivers/tty: make serial 8250_lpc18xx.c Kconfig a tristate

 drivers/tty/hvc/hvc_console.c   | 18 +-----------------
 drivers/tty/pty.c               |  7 +++++--
 drivers/tty/serial/8250/Kconfig |  2 +-
 drivers/tty/serial/mpsc.c       | 36 +++---------------------------------
 drivers/tty/sysrq.c             |  6 +++++-
 5 files changed, 15 insertions(+), 54 deletions(-)

-- 
2.5.0
