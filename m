From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/12] serial: 8250_pnp: add Intermec CV60 touchscreen device
Date: Fri, 26 Aug 2011 13:58:13 -0700
Message-ID: <1314392301-25140-4-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37772 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab1HZU6s (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:58:48 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jeff Chua <jeff.chua.linux@gmail.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Bjorn Helgaas <bhelgaas@google.com>

It would have been nice if Intermec had supplied a PNP0501 _CID for the
COM3 device, but they didn't, so we have to recognize it explicitly.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=40612
CC: Jeff Chua <jeff.chua.linux@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable <stable@kernel.org>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250_pnp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250_pnp.c b/drivers/tty/serial/8250_pnp.c
index fc301f6..a2f2365 100644
--- a/drivers/tty/serial/8250_pnp.c
+++ b/drivers/tty/serial/8250_pnp.c
@@ -109,6 +109,9 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	/* IBM */
 	/* IBM Thinkpad 701 Internal Modem Voice */
 	{	"IBM0033",		0	},
+	/* Intermec */
+	/* Intermec CV60 touchscreen port */
+	{	"PNP4972",		0	},
 	/* Intertex */
 	/* Intertex 28k8 33k6 Voice EXT PnP */
 	{	"IXDC801",		0	},
-- 
1.7.6.1

