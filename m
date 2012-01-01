From: Shawn Guo <shawn.guo@freescale.com>
Subject: [GIT PULL] tty: serial: imx changes for 3.3
Date: Sun, 1 Jan 2012 09:04:12 +0800
Message-ID: <20120101010411.GB13061@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:54777
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750773Ab2AAAu0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 31 Dec 2011 19:50:26 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Hi Greg,

I collected a few imx tty/serial changes below for 3.3.  Can you please
take a look and consider to pull the branch for 3.3 if it looks all
good to you?

Regards,
Shawn

The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f=
593b:

  Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/serial

Dirk Behme (1):
      imx: Add save/restore functions for UART control regs

Eric Miao (1):
      tty: serial: imx: move del_timer_sync() to avoid potential deadlo=
ck

=46abio Estevam (1):
      tty: serial: imx: Allow UART to be a source for wakeup

Saleem Abdulrasool (1):
      imx: add polled io uart methods

Uwe Kleine-K=F6nig (2):
      serial/imx: propagate error from of_alias_get_id instead of using=
 -ENODEV
      serial/imx: let probing fail for the dt case without a valid alia=
s

 drivers/tty/serial/imx.c |  146 ++++++++++++++++++++++++++++++++++++++=
+++-----
 1 files changed, 132 insertions(+), 14 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
