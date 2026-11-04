Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758502;
	b=VSBX95YF+0XKs18qqktbG54ISlJ08fjxFPJozcaX+MUIOMi00b1nE5K53FyuNPpNCXIS
	 8tYqo8Kqzjq+44sD8venVcUz2nJQZB1o+GLKnGlc4KO+Z+0GwinzP2kCXEbaPjivizcox
	 q0aJdZDkF7Bb5h4Z5jtS0Oy6nY2Nc0YqwjO7bPcRMx4dHgZIH0jHrSB1HCWFLsDvvuwY2
	 4X3dfUDJH1Eo9mavmsSbJA4xCNG1EHLjR5M9NYjPPqCyBd73VFZjoYHOlhLfFbY4B60P7
	 RnrAFp0xaTjUxhBWrFHaMLRx+GlSL39ayG7XFqtTlUgFzdS/Am1g1iH/1875MeZpaVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758502;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=pHQjbN59zRPBjypb+Shrn1xR32MkNoduP0egHowJlH0=;
	b=SSy97vJtB2y2dbri0K75epdzsAQZI36GNEAdvx8LvftMu5JlFM+W1hbHiyXfToNL9TmH
	 pdmyKm6M1X7zR3AKbG4rjftGD4iC6oX2Kj6ZjH6vHz6Y2nLt1T4+nf0ejdcibyUzwviX2
	 k0snkmdOfw6ADZDK4/vD9Ve4bpEZGJheNwIYgeNR2DjUVRVX0ifMX1PjwiWg5iAHSEszQ
	 1ZXeTxScOz5MfMwXXticT6HhZIK6G/lgSnhkxOlduqbnoF+y49dQcut+QmJImNP2VwsHe
	 lCfzLhadyKa3tUcJMFgeze4clLOR97mzh8gJJD7ZMLpkJF1lwd+IGHpKjUijjCX+I8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F974606A326
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 02:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F974606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABHcfsklepqrHY+AA--.42263S2;
	Wed, 04 Nov 2026 10:15:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Subject: [PATCH] tty: n_gsm: release the control channel if device registration fails
Date: Wed,  4 Nov 2026 02:15:09 +0000
Message-Id: <20261104021509.1468558-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHcfsklepqrHY+AA--.42263S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtr17JrWkGryrJryDur4DJwb_yoW8Jryxp3
	9rurWv9Fy5CF47Ja1qqw15Aay3W3yIyayxCr1qy3y3ury3Jry2k3sIqa4Y9r1DCrW8Xa1U
	trsrJF18XFsrAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
	6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU02iiDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMBA2rqY+S6YgAAsS

gsm_activate_mux() allocates the DLCI 0 control channel before
registering the mux tty devices. If gsm_register_devices() fails, the
function returns without dropping the reference held by gsm->dlci[0].

The mux is left in the dead state, so a later reconfiguration allocates
a new control channel and overwrites gsm->dlci[0], leaking the previous
one together with its tty port and fifo. Release the control channel on
the error path.

Fixes: 734966043860 ("tty: n_gsm: fix resource allocation order in gsm_activate_mux()")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e55779ff0af2..8ef2c711b2aa 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3195,8 +3195,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 		gsm->receive = gsm1_receive;
 
 	ret = gsm_register_devices(gsm_tty_driver, gsm->num);
-	if (ret)
+	if (ret) {
+		dlci_put(dlci);
 		return ret;
+	}
 
 	gsm->has_devices = true;
 	gsm->dead = false;		/* Tty opens are now permissible */
-- 
2.34.1

