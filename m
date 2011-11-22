From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 0/2] KT serial controller IIR workaround
Date: Tue, 22 Nov 2011 13:41:19 -0800
Message-ID: <20111122213859.13786.7738.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

Changes since v2 [1]:
* reflowed on tty-next (commit: 161e773c "UART: add CSR SiRFprimaII..."
* add a quirk to turn on msi to try to prevent shared interrupts

[1]: https://lkml.org/lkml/2011/11/15/264

---

Dan Williams (2):
      serial/8250_pci: setup-quirk workaround for the kt serial controller
      serial/8250_pci: init-quirk msi support for kt serial controller


 drivers/tty/serial/8250.c     |    4 +++-
 drivers/tty/serial/8250_pci.c |   31 ++++++++++++++++++++++++++++++-
 include/linux/serial_core.h   |    1 +
 3 files changed, 34 insertions(+), 2 deletions(-)
