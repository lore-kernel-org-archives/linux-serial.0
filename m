From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 38/48] ASoC: Update cx20442 for TTY API change
Date: Mon, 23 May 2011 12:10:44 -0700
Message-ID: <1306177854-18172-38-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42115 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932346Ab1EWTL7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:59 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

receive_buf() was recently changed to return the number of bytes
received but the cx20442 driver wasn't updated to match the new API.
I don't have any hardware but since we don't actually appears to be
listening to the data at all just report that we accepted all the data
that was offered to us.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 sound/soc/codecs/cx20442.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 0bb424a..64f863d 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -274,14 +274,14 @@ static int v253_hangup(struct tty_struct *tty)
 }
 
 /* Line discipline .receive_buf() */
-static void v253_receive(struct tty_struct *tty,
-				const unsigned char *cp, char *fp, int count)
+static unsigned int v253_receive(struct tty_struct *tty,
+				 const unsigned char *cp, char *fp, int count)
 {
 	struct snd_soc_codec *codec = tty->disc_data;
 	struct cx20442_priv *cx20442;
 
 	if (!codec)
-		return;
+		return count;
 
 	cx20442 = snd_soc_codec_get_drvdata(codec);
 
@@ -293,6 +293,8 @@ static void v253_receive(struct tty_struct *tty,
 		codec->hw_write = (hw_write_t)tty->ops->write;
 		codec->card->pop_time = 1;
 	}
+
+	return count;
 }
 
 /* Line discipline .write_wakeup() */
-- 
1.7.4.2

