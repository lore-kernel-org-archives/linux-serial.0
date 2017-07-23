From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/9] constify tty pci_device_id.
Date: Sun, 23 Jul 2017 15:31:00 +0530
Message-ID: <1500804069-11043-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jirislaby@gmail.com, jslaby@suse.com, gpiccoli@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Arvind Yadav (9):
  [PATCH 1/9] tty: mxser: constify pci_device_id.
  [PATCH 2/9] tty: isicom: constify pci_device_id.
  [PATCH 3/9] tty: synclinkmp: constify pci_device_id.
  [PATCH 4/9] tty: synclink: constify pci_device_id.
  [PATCH 5/9] tty: moxa: constify pci_device_id.
  [PATCH 6/9] tty: serial: pci: constify pci_device_id.
  [PATCH 7/9] tty: serial: exar: constify pci_device_id.
  [PATCH 8/9] tty: serial: jsm: constify pci_device_id.
  [PATCH 9/9] tty: synclink_gt: constify pci_device_id.

 drivers/tty/isicom.c                | 2 +-
 drivers/tty/moxa.c                  | 2 +-
 drivers/tty/mxser.c                 | 2 +-
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 drivers/tty/serial/8250/8250_pci.c  | 2 +-
 drivers/tty/serial/jsm/jsm_driver.c | 2 +-
 drivers/tty/synclink.c              | 2 +-
 drivers/tty/synclink_gt.c           | 2 +-
 drivers/tty/synclinkmp.c            | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.7.4
