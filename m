From: Jon Medhurst <tixy@linaro.org>
Subject: [PATCH 0/3] serial: amba-pl011: fix race conditions during
 initialisation
Date: Tue, 10 Dec 2013 10:18:57 +0000
Message-ID: <1386670740-16914-1-git-send-email-tixy@linaro.org>
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
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When a UART that is being used for a kernel console is also opened
by user-side, e.g. for use as a terminal, then there are race conditions
which can lead to terminal input being disabled and console output being
corrupted. This small patch series fixes these.

Jon Medhurst (3):
      serial: amba-pl011: use port lock to guard control register access
      serial: amba-pl011: factor out code for writing LCR_H register
      serial: amba-pl011: preseserve hardware settings during initialisation

 drivers/tty/serial/amba-pl011.c |   59 ++++++++++++++++++++++++++++++++++------------------------
