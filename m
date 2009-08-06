From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 1/2] ASoC: CX20442: add some debugging
Date: Thu, 6 Aug 2009 12:24:54 +0200
Message-ID: <200908061224.55284.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, e3-hacking@earth.li, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

This patch adds debugging statement that can help in tracing 
how the driver is trying to control the codec device.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
--- linux-2.6.31-rc5/sound/soc/codecs/cx20442.c.orig	2009-08-04 
23:41:03.000000000 +0200
+++ linux-2.6.31-rc5/sound/soc/codecs/cx20442.c	2009-08-05 00:56:30.000000000 
+0200
@@ -203,6 +201,7 @@ static int cx20442_write(struct snd_soc_
 	if (unlikely(len > (ARRAY_SIZE(buf) - 1)))
 		return -ENOMEM;
 
+	dev_dbg(codec->dev, "%s: %s\n", __func__, buf);
 	if (codec->hw_write(codec->control_data, buf, len) != len)
 		return -EIO;
