From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] tty: ar933x_uart: move devicetree binding documentation
Date: Sat, 31 Aug 2013 09:15:44 +0200
Message-ID: <1377933344-10910-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:42165 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab3HaHQO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 31 Aug 2013 03:16:14 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org

Commit 'tty: ar933x_uart: add device tree support
and binding documentation' introduced a new doc in
bindins/tty/serial.

According to a recent thread [1] on the linux-serial
list, the binding documentation of serial drivers
should be added into bindings/serial.

Move the documentation of qca,ar9330-uart to the
correct place.

  1. http://marc.info/?l=linux-serial&m=137771295411517

Cc: devicetree@vger.kernel.org
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
The patch is agains the 'tty-next' branch of the
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
---
 Documentation/devicetree/bindings/{tty => }/serial/qca,ar9330-uart.txt |    0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{tty => }/serial/qca,ar9330-uart.txt (100%)

diff --git a/Documentation/devicetree/bindings/tty/serial/qca,ar9330-uart.txt b/Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt
similarity index 100%
rename from Documentation/devicetree/bindings/tty/serial/qca,ar9330-uart.txt
rename to Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt
-- 
1.7.10
