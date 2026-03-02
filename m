Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7C3016FA;
	Mon,  2 Mar 2026 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772426583; cv=none; b=H6c5VnQc/DuqMCInRQGZqyBhLi4Qx/dITe6RQtSc5a5i3ghpwpln3110dDPsNfEpsTwwFAvuvvxqT0CAScs6KUMfrF103iFDpY70PHRpwldfIMa9KSlB3leMBoy/DXfS9hC07Gl0S3WP+ynwFht+uweWhHj/VCIYcvtg012J3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772426583; c=relaxed/simple;
	bh=tvFh9t1S6t749AwBjlb006RoGDFpiyNgigKjAKRa5Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHOWtNiuSzWdjaqW6CBVH6rAPs+zCnSceSyQt0mQchrnpntUHkxXoO8PEH/KOxoACtZ9rbFIuZmMnhfo158hZ5IcHbm7Su8jXwv6gypc4P4E8UWJ9PKlL6H4cLItcgh2aK0y1v4U2dEirFwXXFxvXB/XvgfzvB3ZlU3oDlibmtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=g8i6Juca; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="g8i6Juca"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1772426579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C5HRcg8rTbnjX+sj2kq1iDOp0yQxgSP94sAtrD670bo=;
	b=g8i6JucaFTAi2JxE/FPflZrHvh/Xi+/+3esnDG53+DBSM45+E6hNurjCJecmgt0kdxdCIE
	ps6wwYkVrcSjh905dZTT5fiabBjyyE/cal99RAQepMk9GFAV6ViQxX5rtfaYazSBhjn9rX
	5XYTu6Sk0OC0ai0/oDQ2GNuSjTfhQTA=
From: Ronan Pigott <ronan@rjp.ie>
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH] vt: support ITU-T T.416 color subparameters
Date: Sun,  1 Mar 2026 21:42:39 -0700
Message-ID: <20260302044245.391943-1-ronan@rjp.ie>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The colon ("bit combination 03/10") is a valid character in parameter
substrings. ECMA-48 says:

  Each parameter sub-string consists of one or more bit combinations
  from 03/00 to 03/10; the bit combinations from 03/00 to 03/09
  represent the digits ZERO to NINE; bit combination 03/10 may be used
  as a separator in a parameter sub-string, for example, to separate
  the fractional part of a decimal number from the integer part of
  that number.

To my knowledge, the only codes where 03/10 is actually used as a
separator are the CSI-m SGR sequences. The colon separated format is
superior as an embedded string for software that doesn't wish to link
ncurses terminal database, because terminals that do not support the
requested SGR sequence can safely skip the sub-parameters rather than
misinterpret them as another sequence. Hence, some software have started
using this "modern" format [1]. We should support the colon separated
format as well.

[1] https://github.com/systemd/systemd/commit/6eabe9f2ff48c1b6924724d5afe64e7b661ccdbf

Signed-off-by: Ronan Pigott <ronan@rjp.ie>
---
 drivers/tty/vt/vt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c1f152d8b03b..3951bd49bc27 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1644,9 +1644,7 @@ static void rgb_background(struct vc_data *vc, const struct rgb *c)
 
 /*
  * ITU T.416 Higher colour modes. They break the usual properties of SGR codes
- * and thus need to be detected and ignored by hand. That standard also
- * wants : rather than ; as separators but sequences containing : are currently
- * completely ignored by the parser.
+ * and thus need to be detected and ignored by hand.
  *
  * Subcommands 3 (CMY) and 4 (CMYK) are so insane there's no point in
  * supporting them.
@@ -1703,6 +1701,7 @@ enum {
 	CSI_m_BG_COLOR_END		= 47,
 	CSI_m_BG_COLOR			= 48,
 	CSI_m_DEFAULT_BG_COLOR		= 49,
+	CSI_m_UNDERLINE_COLOR		= 58,
 	CSI_m_BRIGHT_FG_COLOR_BEG	= 90,
 	CSI_m_BRIGHT_FG_COLOR_END	= 97,
 	CSI_m_BRIGHT_FG_COLOR_OFF	= CSI_m_BRIGHT_FG_COLOR_BEG - CSI_m_FG_COLOR_BEG,
@@ -2699,6 +2698,14 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		fallthrough;
 	case ESgetpars: /* ESC [ aka CSI, parameters expected */
 		switch (c) {
+		case ':': /* ITU-T T.416 color subparameters */
+			if (vc->vc_par[0] != CSI_m_FG_COLOR &&
+			    vc->vc_par[0] != CSI_m_BG_COLOR &&
+			    vc->vc_par[0] != CSI_m_UNDERLINE_COLOR) {
+				vc->vc_state = EScsiignore;
+				return;
+			}
+			fallthrough;
 		case ';':
 			if (vc->vc_npar < NPAR - 1) {
 				vc->vc_npar++;
-- 
2.53.0

