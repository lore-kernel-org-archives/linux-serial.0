From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [REGRESSION next-20170321] acbdad8dd1ab ("serial: 8250_dw: simplify
 optional reset handling") causes silent kernel.
Date: Wed, 22 Mar 2017 15:24:45 +0100
Message-ID: <20170322152445.0b25f78c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Philipp,

Commit acbdad8dd1ab ("serial: 8250_dw: simplify optional reset
handling") causes the kernel to no longer print anything to the serial
console on a Linksys WRT3200ACM (Armada-385, a similar board would
be ./arch/arm/boot/dts/armada-385-linksys-cobra.dts). The last message
from uboot is "Starting kernel ..." and then silence. The device boots
all the way nonetheless.

Reverting the above commit gets the console output back.

Ralph


Bisect log:

  git bisect start
  # bad: [50eff530518ae89e25d09ec1aa41a7aea6a7d51c] Add linux-next specific files for 20170321
  git bisect bad 50eff530518ae89e25d09ec1aa41a7aea6a7d51c
  # good: [97da3854c526d3a6ee05c849c96e48d21527606c] Linux 4.11-rc3
  git bisect good 97da3854c526d3a6ee05c849c96e48d21527606c
  # good: [445775520e021af86ee95b76eecca2df8203ce93] Merge remote-tracking branch 'drm/drm-next'
  git bisect good 445775520e021af86ee95b76eecca2df8203ce93
  # good: [9f18c54f1a491ed2ff42354352fa72949ce21622] Merge remote-tracking branch 'usb-serial/usb-next'
  git bisect good 9f18c54f1a491ed2ff42354352fa72949ce21622
  # good: [cfd23945be7413351ef57ff5b07c5b037a7f9995] staging: media: Remove unused function atomisp_set_stop_timeout()
  git bisect good cfd23945be7413351ef57ff5b07c5b037a7f9995
  # bad: [b8e4c398ad2f0c005b76298e6492a20804af5bf3] Merge remote-tracking branch 'gpio/for-next'
  git bisect bad b8e4c398ad2f0c005b76298e6492a20804af5bf3
  # bad: [1e0dec03559e0a6f57398d46167dcac5514e28cc] Merge remote-tracking branch 'staging/staging-next'
  git bisect bad 1e0dec03559e0a6f57398d46167dcac5514e28cc
  # bad: [1e0dec03559e0a6f57398d46167dcac5514e28cc] Merge remote-tracking branch 'staging/staging-next'
  git bisect bad 1e0dec03559e0a6f57398d46167dcac5514e28cc
  # bad: [b93a6959856081a440ca98debbbf81fd5828014f] Merge remote-tracking branch 'extcon/extcon-next'
  git bisect bad b93a6959856081a440ca98debbbf81fd5828014f
  # good: [1d3b2af213902059d9f4b35eb15b53f8062dc3b3] auxdisplay: charlcd: Add support for displays with more than two lines
  git bisect good 1d3b2af213902059d9f4b35eb15b53f8062dc3b3
  # good: [22077b091a4720d4336bd806e9c93b2a81fcc38a] tty: serial_core, remove state checks in uart_poll*
  git bisect good 22077b091a4720d4336bd806e9c93b2a81fcc38a
  # good: [16b11f258b4563a8d18b9e35344540ca41a5550b] extcon: int3496: Set the id pin to direction-input if necessary
  git bisect good 16b11f258b4563a8d18b9e35344540ca41a5550b
  # good: [5ce689f2e4b83363750c8dda46042f9332b37cc1] Merge remote-tracking branch 'phy-next/next'
  git bisect good 5ce689f2e4b83363750c8dda46042f9332b37cc1
  # good: [d47d88361feea2ce11f39bd70467ffc19a61d2d3] auxdisplay: Add HD44780 Character LCD support
  git bisect good d47d88361feea2ce11f39bd70467ffc19a61d2d3
  # bad: [76e00cb026f0afe6f62072dbb57c20a69e3427c8] Merge remote-tracking branch 'tty/tty-next'
  git bisect bad 76e00cb026f0afe6f62072dbb57c20a69e3427c8
  # bad: [acbdad8dd1abd98b216d8c37ff9c6de4aa595534] serial: 8250_dw: simplify optional reset handling
  git bisect bad acbdad8dd1abd98b216d8c37ff9c6de4aa595534
  # first bad commit: [acbdad8dd1abd98b216d8c37ff9c6de4aa595534]
  serial: 8250_dw: simplify optional reset handling
