Received: from smtpout02-ext4.partage.renater.fr (smtpout02-ext4.partage.renater.fr [194.254.241.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA13B1AB;
	Mon, 25 Aug 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.241.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126623; cv=none; b=RVP2/9XSgrtbipMM6e9ddbpqrhOO29PeBrRoCtM4M0kTLTsh7uGMjdQLiJE3lF7b+BKQqmJM0MysG1sqOOA6d2QbhZ+lqkmbkuUYsR/5v/v28WA3cu741kg+YSYbv6caMhfsdRAoBe0GDTgno2I+RQfx8D1xraq+xDvnX++N4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126623; c=relaxed/simple;
	bh=I8cOqQy1NyXSD/iFLWsedTfAdOjAm5LeF61aWjQoCUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY/PjvbkJlkUJesgn3eXGt70KEetv2Vbq1eInxsHDkVOm/4pbVxTML/zCd2wuSVTRpSdVhrc97EhrQImuF+KdaLbR91GDgaUv5K/gI9r6T5kE3DPZpOD/qSioTp0bdbm7Lp5eMn6/2u8FtAfoMYt56+EyzdfqyMRe8wO1uVhn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org; spf=none smtp.mailfrom=grenoble-inp.org; dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b=AsFUaFZ1; arc=none smtp.client-ip=194.254.241.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=grenoble-inp.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b="AsFUaFZ1"
Received: from zmtaauth04.partage.renater.fr (zmtaauth04.partage.renater.fr [194.254.241.26])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id 2873BBFA4E;
	Mon, 25 Aug 2025 14:56:54 +0200 (CEST)
Received: from zmtaauth04.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth04.partage.renater.fr (Postfix) with ESMTPS id 147B41C0925;
	Mon, 25 Aug 2025 14:56:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth04.partage.renater.fr (Postfix) with ESMTP id EF9501C0832;
	Mon, 25 Aug 2025 14:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth04.partage.renater.fr EF9501C0832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
	s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1756126614;
	bh=p7nZSFFPKI8nw4Et45knVxi5z/6xU+HLAyoavG1fZV0=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=AsFUaFZ1XkzxJSgw/fxcDcJ2A6b9ZMmngwcSZM675OJT/ea+lBV4fEBTqstD9yGWn
	 vIHq195RF5VorAsFlrzOnxLwC1MmMfioNTBWvELftHH0juIM/wV2p5uRjq594XqXSa
	 9ddqFXP869y7S6oh0W6EgEqUWIhox6kHM857JeyWWKQo3jfTphQ8Qa7kfDwqzbtNVs
	 ZqMU0B1U913JiMLrI+PqX3YYUcx9TyrV6LtQczVeoWkXDV3GHXMtSJoOt9C0JRbkgT
	 bQPqSgB7uRNmE3+J33oecthWD3dArfedAoPNRcADSZl+dRyREEi5HQhgp8GZ9+hq07
	 ran0OT4PJWAjw==
Received: from zmtaauth04.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth04.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LAO-yyCAx0mS; Mon, 25 Aug 2025 14:56:53 +0200 (CEST)
Received: from 91.166.147.41 (unknown [194.254.241.251])
	by zmtaauth04.partage.renater.fr (Postfix) with ESMTPA id 753F71C0925;
	Mon, 25 Aug 2025 14:56:53 +0200 (CEST)
From: Calixte Pernot <calixte.pernot@grenoble-inp.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>
Subject: [PATCH v2] vt: add support for smput/rmput escape codes
Date: Mon, 25 Aug 2025 14:56:09 +0200
Message-ID: <20250825125607.2478-3-calixte.pernot@grenoble-inp.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <e5f75c37-30a5-4c4e-aae5-a72060be24da@kernel.org>
References: <e5f75c37-30a5-4c4e-aae5-a72060be24da@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.12 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvgeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvegrlhhigihtvgcurfgvrhhnohhtuceotggrlhhigihtvgdrphgvrhhnohhtsehgrhgvnhhosghlvgdqihhnphdrohhrgheqnecuggftrfgrthhtvghrnhepvedvjeehgedvgfffvefhgfeitdfhffejgffgueduveetudevueeuheeukeetjeejnecukfhppeduleegrddvheegrddvgedurddvhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelgedrvdehgedrvdeguddrvdehuddphhgvlhhopeeluddrudeiiedrudegjedrgedupdhmrghilhhfrhhomheptggrlhhigihtvgdrphgvrhhnohhtsehgrhgvnhhosghlvgdqihhnphdrohhrghdpnhgspghrtghpthhtohephedprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
 phhtthhopegtrghlihigthgvrdhpvghrnhhothesghhrvghnohgslhgvqdhinhhprdhorhhg
Content-Transfer-Encoding: quoted-printable

Support "\e[?1049h" and "\e[?1049l" escape codes.
This patch allows programs to enter and leave alternate screens.
This feature is widely available in graphical terminal emulators and most=
ly
used by fullscreen terminal-based user interfaces such as text editors.
Most editors such as vim and nano assume this escape code in not supporte=
d
and will not try to print the escape sequence if TERM=3Dlinux.
To try out this patch, run `TERM=3Dxterm-256color vim` inside a VT.

Signed-off-by: Calixte Pernot <calixte.pernot@grenoble-inp.org>
---
 drivers/tty/vt/vt.c            | 58 ++++++++++++++++++++++++++++++++++
 include/linux/console_struct.h |  3 ++
 2 files changed, 61 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 62049ceb3..bda2a6f76 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -141,6 +141,7 @@ static const struct consw *con_driver_map[MAX_NR_CONS=
OLES];
 static int con_open(struct tty_struct *, struct file *);
 static void vc_init(struct vc_data *vc, int do_clear);
 static void gotoxy(struct vc_data *vc, int new_x, int new_y);
+static void restore_cur(struct vc_data *vc);
 static void save_cur(struct vc_data *vc);
 static void reset_terminal(struct vc_data *vc, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
@@ -1344,6 +1345,10 @@ struct vc_data *vc_deallocate(unsigned int currcon=
s)
 		kfree(vc->vc_screenbuf);
 		vc_cons[currcons].d =3D NULL;
 	}
+	if (vc->vc_saved_screen !=3D NULL) {
+		kfree(vc->vc_saved_screen);
+		vc->vc_saved_screen =3D NULL;
+	}
 	return vc;
 }
=20
@@ -1878,6 +1883,45 @@ static int get_bracketed_paste(struct tty_struct *=
tty)
 	return vc->vc_bracketed_paste;
 }
=20
+/* console_lock is held */
+static void enter_alt_screen(struct vc_data *vc)
+{
+	unsigned int size =3D vc->vc_rows * vc->vc_cols * 2;
+
+	if (vc->vc_saved_screen !=3D NULL)
+		return; /* Already inside an alt-screen */
+	vc->vc_saved_screen =3D kmemdup((u16 *)vc->vc_origin, size, GFP_KERNEL)=
;
+	if (vc->vc_saved_screen =3D=3D NULL)
+		return;
+	vc->vc_saved_rows =3D vc->vc_rows;
+	vc->vc_saved_cols =3D vc->vc_cols;
+	save_cur(vc);
+	/* clear entire screen */
+	csi_J(vc, CSI_J_FULL);
+}
+
+/* console_lock is held */
+static void leave_alt_screen(struct vc_data *vc)
+{
+	unsigned int rows =3D min(vc->vc_saved_rows, vc->vc_rows);
+	unsigned int cols =3D min(vc->vc_saved_cols, vc->vc_cols);
+	u16 *src, *dest;
+
+	if (vc->vc_saved_screen =3D=3D NULL)
+		return; /* Not inside an alt-screen */
+	for (unsigned int r =3D 0; r < rows; r++) {
+		src =3D vc->vc_saved_screen + r * vc->vc_saved_cols;
+		dest =3D ((u16 *)vc->vc_origin) + r * vc->vc_cols;
+		memcpy(dest, src, 2 * cols);
+	}
+	restore_cur(vc);
+	/* Update the entire screen */
+	if (con_should_update(vc))
+		do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
+	kfree(vc->vc_saved_screen);
+	vc->vc_saved_screen =3D NULL;
+}
+
 enum {
 	CSI_DEC_hl_CURSOR_KEYS	=3D 1,	/* CKM: cursor keys send ^[Ox/^[[x */
 	CSI_DEC_hl_132_COLUMNS	=3D 3,	/* COLM: 80/132 mode switch */
@@ -1888,6 +1932,7 @@ enum {
 	CSI_DEC_hl_MOUSE_X10	=3D 9,
 	CSI_DEC_hl_SHOW_CURSOR	=3D 25,	/* TCEM */
 	CSI_DEC_hl_MOUSE_VT200	=3D 1000,
+	CSI_DEC_hl_ALT_SCREEN	=3D 1049,
 	CSI_DEC_hl_BRACKETED_PASTE =3D 2004,
 };
=20
@@ -1944,6 +1989,12 @@ static void csi_DEC_hl(struct vc_data *vc, bool on=
_off)
 		case CSI_DEC_hl_BRACKETED_PASTE:
 			vc->vc_bracketed_paste =3D on_off;
 			break;
+		case CSI_DEC_hl_ALT_SCREEN:
+			if (on_off)
+				enter_alt_screen(vc);
+			else
+				leave_alt_screen(vc);
+			break;
 		}
 }
=20
@@ -2182,6 +2233,13 @@ static void reset_terminal(struct vc_data *vc, int=
 do_clear)
 	vc->vc_deccm		=3D global_cursor_default;
 	vc->vc_decim		=3D 0;
=20
+	if (vc->vc_saved_screen !=3D NULL) {
+		kfree(vc->vc_saved_screen);
+		vc->vc_saved_screen =3D NULL;
+		vc->vc_saved_rows =3D 0;
+		vc->vc_saved_cols =3D 0;
+	}
+
 	vt_reset_keyboard(vc->vc_num);
=20
 	vc->vc_cursor_type =3D cur_default;
diff --git a/include/linux/console_struct.h b/include/linux/console_struc=
t.h
index 59b4fec5f..13b35637b 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -159,6 +159,9 @@ struct vc_data {
 	struct uni_pagedict *uni_pagedict;
 	struct uni_pagedict **uni_pagedict_loc; /* [!] Location of uni_pagedict=
 variable for this console */
 	u32 **vc_uni_lines;			/* unicode screen content */
+	u16		*vc_saved_screen;
+	unsigned int	vc_saved_cols;
+	unsigned int	vc_saved_rows;
 	/* additional information is in vt_kern.h */
 };
=20
--=20
2.50.1

