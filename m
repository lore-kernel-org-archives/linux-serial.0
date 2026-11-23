Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428724;
	b=e7ZylcIJ9/3aa1kHG8QyDct0EXwbk8EMcp08k02tPsQrKl2diCPngIDM/1AEMHFJz2Vy
	 mKZOvY3Km6uHCqxLwOP03BpRZhx7IOrLpEHYKA/vHAPrQsfqxfashM3tpPhlt3wfDK4Y/
	 VlL1XJQwEwoebTflcnnQrH4auuBJETAnVqIH2ItUxI2tAkkAQzpOMQ9Caz/MeCg9syAGN
	 rp0TMOwjxgNgp2e2+fnFmkvcRJMUydoDgi7u9gP8HIeiXhro5qEZqXbbD3dbNQqEOjO05
	 +dEK1B5cZ/v1ThybqApVucFmiDTvCN0Ppi3yeshhH7j1VxtBybFZikEtOQKYNDTwsjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428724;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NO0x74vFEbFRFk1Ud+R7tW+jyS24/LF/j/409ZNv2N8=;
	b=Ch0YB7zUZEJGAlaGLNBcAZFYy+CMhmPLQvVyYrbYGaMsTxW1Vq4CJg4G/tnIQn2/fnzk
	 HMVyfHYf0/nuPyy7ExPBaQBMnhcWxNOAKgla+DLDMwJPB+lvbWso8YTtuOwSiWMAMI9eJ
	 VEJJBW3tpScc2yDmq0OJzjGfFJP9AEw86wuAdltEGvPLKLn72rIltJDowhGAYkw1JFZ9B
	 YwappWRQ9zceDFVXNFf8do7b8idbmmjej9GtqGCLQ8458HaWavq5LU3KhRtdnCu4io/7j
	 e0Cmi84Ck6F8uc/3cfuucRRTVuzFnUIoSdDo+L9b5rc+poNDOyv1/2AnpOQ4pY3I/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACA606A33E;
	Mon, 23 Nov 2026 10:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70ACA606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4ed9c192e72611f19a56ed5b684f684d-20261123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9026a8a2-b792-4f5a-9c6b-aa1809da5366,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:08f9c6b08b8bae52e26abe2fa9450a67,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4ed9c192e72611f19a56ed5b684f684d-20261123
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 682078225; Mon, 23 Nov 2026 18:11:54 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Ronan Pigott <ronan@rjp.ie>,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] vt: Skip hardware scrolling while blanked and fix VESA blanking
Date: Mon, 23 Nov 2026 18:11:51 +0800
Message-Id: <20261123101151.414436-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

When vgacon is blanked without palette blanking (!vga_palette_blanked),
vgacon_set_origin() rejects VRAM so vc->vc_origin points to the heap
buffer vc->vc_screenbuf. Calling hardware scroll callbacks while blanked
then treats vc->vc_screenbuf as VRAM and causes out-of-bounds accesses.

Use con_should_update() to skip hardware scrolling and scrollback while
blanked, allowing con_scroll() to fall back to software scrolling.
In vgacon_blank(), return !vga_palette_blanked for VESA blanking so
direct VESA blanking switches vc->vc_origin to vc->vc_screenbuf
immediately instead of losing output on unblank.

Assisted-by: LLM
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 drivers/tty/vt/vt.c            | 7 ++++---
 drivers/video/console/vgacon.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6a6eb8b2a6dec..39be682645097 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -726,8 +726,8 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
 		return;
 
 	vc_uniscr_scroll(vc, top, bottom, dir, nr);
-	if (con_is_visible(vc) &&
-			vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
+	if (con_should_update(vc) &&
+	    vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
 		return;
 
 	src = clear = (u16 *)(vc->vc_origin + vc->vc_size_row * top);
@@ -3488,7 +3488,8 @@ static void console_callback(struct work_struct *ignored)
 	if (scrollback_delta) {
 		struct vc_data *vc = vc_cons[fg_console].d;
 		clear_selection();
-		if (vc->vc_mode == KD_TEXT && vc->vc_sw->con_scrolldelta)
+		if (con_should_update(vc) && vc->vc_mode == KD_TEXT &&
+		    vc->vc_sw->con_scrolldelta)
 			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);
 		scrollback_delta = 0;
 	}
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 09f7c376b4689..3a706c1f1cb28 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -796,7 +796,7 @@ static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
 			vga_vesa_blank(&vgastate, blank);
 			vga_vesa_blanked = blank;
 		}
-		return false;
+		return !vga_palette_blanked;
 	}
 }
 
-- 
2.43.0

