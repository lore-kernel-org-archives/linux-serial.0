From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 0/3] serial: lantiq: Update driver to support new SoC
Date: Thu,  8 Aug 2019 18:02:05 +0800
Message-ID: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, jslaby@suse.com, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

There is a new Intel Atom based Lightning Mountain(LGM) network processor SoC
which reuses Lantiq ASC serial controller IP. This patch series updates the
driver design and code to add support for LGM SoC as well.

These patches are baselined upon Linux 5.3-rc2 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

Patch 1 modifies devicetree compatible string to a use explicit string instead
of a fixed macro because this patch series adds support for multiple SoCs.

Patch 2 modifies driver design to support dynamic assignment of IRQ resources
& ISRs based on devicetree node compatible entries. This is because new LGM SoC
supports single IRQ for all tx/rx/err interrupts while older SoCs support three
separate IRQs for tx/rx/err interrupts.

Patch 3 adds LGM SoC specific IRQ/ISR support.

v2:
* Address review concerns.
* Separate dt binding document from this patch series. Will try to push it
  separately by first converting existing txt file to YAML and then add new
  properties.
* Omit resending one patch in this series which is already reviewed & added
  to tty-next.


Rahul Tanwar (3):
  serial: lantiq: Use proper DT compatible string
  serial: lantiq: Make IRQ & ISR assignment dynamic
  serial: lantiq: Add support for Lightning Mountain SoC

 drivers/tty/serial/lantiq.c | 214 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 168 insertions(+), 46 deletions(-)

-- 
2.11.0
