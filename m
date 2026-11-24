Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488507;
	b=bbrYSd7eaFZnZTSAbuBN83+cjxRq7hTODEp1zTTZlgEYbxufMaAhvO489CZzVklmbEMR
	 PjNa/2BE8cB05Skm3QKMAqYMe7ZxL5ua1G4QKGp72jnDsf2n4/cN8EgBK9VDnN6XFHG8P
	 KAgnuiLBiziDe9KPtVEl8BexYESDTT4qU09/dGWCsZphp+NWuecW3FToiRSgxKWaAAdmz
	 Zrzz5RVdiH6fXLeC8IEd8LrN+oOzARJvApljyehaZp7IWtNSsRX6d0KaK6fZAJFynPA8f
	 wkfVNTCiahCEPXZzpb3cLcmnueyeZtGeagQ+aLNK2EW42CuLD+bHtAEAZS4dQC2f70w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488507;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VcuhlDWFwptNtU5EPYvKB2UiOSa56xdrOoYTZ/VqEGw=;
	b=lmFWZh1BEI/zSCxuAKaiOHRYxlFJB0Xeyrrlhj2P71lWbB6SZkjS8+bkiNDupK9AthXv
	 USzObR43Fxe8pcMhYzG9uKiZHNgoVWVqO34zqMWCU1n2g0lFSDfhnBF8vR0dzbXLkhmNH
	 gqW19q7M74y80LNvHU9/EQ7lZ5qulRGFKokyE9+x8naXNcQT377YfbehzKcoe9jbc4KT7
	 aqAohnHG3bporRc4LsGjZaG6QPIqcivuNUPAcpCoI2wgpkf3HYZbdqTf2U2N7d2rSRZ0V
	 CARPlGJGiHQOOIhfF9TurSrL1csfUw3ozP6xNLsWxw7CrvKjmURgcDqOdRZay7kNLKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5F606A332;
	Tue, 24 Nov 2026 02:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E5F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 82425a9ae7b111f19a56ed5b684f684d-20261124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f1b76896-b85a-49b1-af9c-3a98e0389119,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:9fa807bca2035454e9706d1697975e4f,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 82425a9ae7b111f19a56ed5b684f684d-20261124
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 34953608; Tue, 24 Nov 2026 10:48:20 +0800
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
Subject: [PATCH v2 2/2] vgacon: Switch to screenbuf on direct VESA blanking
Date: Tue, 24 Nov 2026 10:48:11 +0800
Message-ID: <20261124024811.305592-3-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124024811.305592-1-pengyu@kylinos.cn>
References: <20261124024811.305592-1-pengyu@kylinos.cn>
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

vgacon_blank() returns false for VESA blanking even when
!vga_palette_blanked, so do_blank_screen() leaves vc->vc_origin in VRAM.
On unblank, vgacon_unblank() returns true and overwrites VRAM with the
stale vc->vc_screenbuf, losing output written while blanked.

Return !vga_palette_blanked so direct VESA blanking switches to
vc->vc_screenbuf immediately while palette blanking keeps VRAM.

Assisted-by: LLM
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 drivers/video/console/vgacon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

