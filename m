From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 24/30] isicom: isicom kref leak fix
Date: Tue, 24 Mar 2009 14:05:51 +0000
Message-ID: <20090324140548.12735.37948.stgit@localhost.localdomain>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48993 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755980AbZCXOFv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 10:05:51 -0400
In-Reply-To: <20090324135930.12735.7827.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

The isicom driver leaks a kref on the shutdown path. Drop the additional
kref we took

Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

 drivers/char/isicom.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 24aa6e8..a59eac5 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -925,6 +925,7 @@ static void isicom_shutdown_port(struct isi_port *port)
 		if (!card->count)
 			isicom_shutdown_board(card);
 	}
+	tty_kref_put(tty);
 }
 
 static void isicom_flush_buffer(struct tty_struct *tty)

