Received: from smtpout02-ext4.partage.renater.fr (smtpout02-ext4.partage.renater.fr [194.254.241.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEE14F70;
	Sun, 24 Aug 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.241.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045700; cv=none; b=BvZarRB3zR6WLX0VRkzmXMZ9ZRkAQUek4/wTn1Z5Xcnyf+PT6a6szObfU3GxbfGJOP+B7pzbFgf5WQLm5QZHpvcnisAm4Ee20VCwx+cyksaJNUQ6OhjYe5XUc2csiUaWtt28/aXfY477ALwS/0YIeE+QdM5HvMKieeNjxYprAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045700; c=relaxed/simple;
	bh=vJDTBLt5vdPr1M74pbae//5I1NtfxD6Q2JwehZPGN+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxbxY+Pl3SLtQsqsJ8QDjcJvcXXF6ZYeqDty8yPT1srFJjoROGOgagUK+PGpWmlnsqWqKETITbzvjf2xvM/jdpAOoeawotR6S8UZwR7WANnV/InHnj7kM4DLAGuH5nWRxhq1IwIiTwuD+SInvp9LHhLVZA13RjZGmkZEvLxoMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org; spf=none smtp.mailfrom=grenoble-inp.org; dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b=vO2r5Jag; arc=none smtp.client-ip=194.254.241.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=grenoble-inp.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b="vO2r5Jag"
Received: from zmtaauth02.partage.renater.fr (zmtaauth02.partage.renater.fr [194.254.241.25])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id A2756BFB38;
	Sun, 24 Aug 2025 16:21:37 +0200 (CEST)
Received: from zmtaauth02.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTPS id 980C1A05E5;
	Sun, 24 Aug 2025 16:21:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTP id 861F7A0AFC;
	Sun, 24 Aug 2025 16:21:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth02.partage.renater.fr 861F7A0AFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
	s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1756045297;
	bh=xbCDonW6R7cqSTW7wbWCW9zlxOi7k9J2nlQQ4grlsAk=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=vO2r5JagMVzjuNUlUhXayKHO9hAjnG+b/OWkJ1o1LyUXdOneUK9Pj9tjlAHgts3db
	 9U/CudN1h3QfY62Ecor5n2poBWY9dbDKXQTvxkbPFGsPKh6WkFb/t6MPUuNIb9FTS/
	 qT9PFgoWBMSyElLmnbgJcvftd0ZVDTPmwbru7i3ZZD7fN3tIrQAOh8gdD+qhybbajg
	 kPgxzCyGfGEkGTGIjasmgNR311DVkExhGuSZXR0b+OwvDw24n9J2OD5PDco6K8Ax1M
	 3JRfTkHjJBdCg6BWp072OTGX23eIjeEM7jQpx5kBFzkQ+p6eu6iLAqBvh2OFoKRZqt
	 jcq6hA/ZTtj2A==
Received: from zmtaauth02.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth02.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xs9vMi_pJ7JY; Sun, 24 Aug 2025 16:21:37 +0200 (CEST)
Received: from 91.166.147.41 (unknown [194.254.241.251])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTPA id 3DC35A05E5;
	Sun, 24 Aug 2025 16:21:37 +0200 (CEST)
From: Calixte Pernot <calixte.pernot@grenoble-inp.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>
Subject: [PATCH] vt: add support for smput/rmput escape codes
Date: Sun, 24 Aug 2025 16:20:16 +0200
Message-ID: <20250824142016.47219-1-calixte.pernot@grenoble-inp.org>
X-Mailer: git-send-email 2.50.1
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
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeljeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvegrlhhigihtvgcurfgvrhhnohhtuceotggrlhhigihtvgdrphgvrhhnohhtsehgrhgvnhhosghlvgdqihhnphdrohhrgheqnecuggftrfgrthhtvghrnheptdevhedugfeufefgvdeivdeufffgudelveeigeejgfegheegheduhfetteekudegnecukfhppeduleegrddvheegrddvgedurddvhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelgedrvdehgedrvdeguddrvdehuddphhgvlhhopeeluddrudeiiedrudegjedrgedupdhmrghilhhfrhhomheptggrlhhigihtvgdrphgvrhhnohhtsehgrhgvnhhosghlvgdqihhnphdrohhrghdpnhgspghrtghpthhtohephedprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
 thhopegtrghlihigthgvrdhpvghrnhhothesghhrvghnohgslhgvqdhinhhprdhorhhg
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
 drivers/tty/vt/vt.c            | 59 ++++++++++++++++++++++++++++++++++
 include/linux/console_struct.h |  3 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 62049ceb3..0e3632aa1 100644
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
@@ -1878,6 +1883,46 @@ static int get_bracketed_paste(struct tty_struct *=
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
+	vc->vc_saved_screen =3D kzalloc(size, GFP_NOWAIT);
+	if (vc->vc_saved_screen =3D=3D NULL)
+		return;
+	memcpy(vc->vc_saved_screen, (u16 *)vc->vc_origin, size);
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
+	unsigned short *src, *dest;
+
+	if (vc->vc_saved_screen =3D=3D NULL)
+		return; /* Not inside an alt-screen */
+	for (int r =3D 0; r < rows; r++) {
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
@@ -1888,6 +1933,7 @@ enum {
 	CSI_DEC_hl_MOUSE_X10	=3D 9,
 	CSI_DEC_hl_SHOW_CURSOR	=3D 25,	/* TCEM */
 	CSI_DEC_hl_MOUSE_VT200	=3D 1000,
+	CSI_DEC_hl_ALT_SCREEN	=3D 1049,
 	CSI_DEC_hl_BRACKETED_PASTE =3D 2004,
 };
=20
@@ -1944,6 +1990,12 @@ static void csi_DEC_hl(struct vc_data *vc, bool on=
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
@@ -2182,6 +2234,13 @@ static void reset_terminal(struct vc_data *vc, int=
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
index 59b4fec5f..f9aabc3cf 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -159,6 +159,9 @@ struct vc_data {
 	struct uni_pagedict *uni_pagedict;
 	struct uni_pagedict **uni_pagedict_loc; /* [!] Location of uni_pagedict=
 variable for this console */
 	u32 **vc_uni_lines;			/* unicode screen content */
+	unsigned short	*vc_saved_screen;
+	unsigned int	vc_saved_cols;
+	unsigned int	vc_saved_rows;
 	/* additional information is in vt_kern.h */
 };
=20
--=20
2.50.1

