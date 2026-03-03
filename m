Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A71A7264
	for <linux-serial@vger.kernel.org>; Tue,  3 Mar 2026 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500052; cv=none; b=gaYc6TJLzbjVVg/YTWvJmLomkxfbWo0hubK3SNG+hzetj7k05jPpbVkiBP/avHffgOqIlsqiWgcL+gMSw3yfEkXGhc7tMbBLRUGeKlZuxqA18EFvtrUQSEtfLa53bShfBeH7V9cDmWU9rMAYYXWWCo1e71XOCOt1pqZTc1VS4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500052; c=relaxed/simple;
	bh=2nkaS8PZ0k1FYabRJZFg66fqZVxGU+7Vqarf4IBr34k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKB4sOVYdx+AwE1OOi8B5dsRIhekNt6RF+ChOcixlf2ik2zslcxu5bMLuzK7cS5TIM8E3n9SCRNGMUmEDM7bP26H9sEEyAnDcAq5UqZ+qy5N86SY8ZFWC3Y1K9l0njG+crRfB08uoOKP1631T8f/s4+4b8D/a2hK2IhZgUImJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=MJzESmbl; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="MJzESmbl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1772500039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uz9n64OcT1mtsQFRPmQ8nt7+7hbjSGgB4S5BOvIMIDU=;
	b=MJzESmblBVPdlDsZcGuEB5ZQJYFl0gVk3N8XXCy8fdnIhkTPPqPTqdrc9zZjVOECV0zCMj
	a0JJ6WnBIpf5eq5wNJDofJi7EI7WiwhSdgGQ5uEfMxcXBAdQcQBLZyQYMv10gEG86wNjWx
	IXTEXZGzVvoN8T3UhQmA/vUMpicFb30=
From: Ronan Pigott <ronan@rjp.ie>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH v2] vt: support ITU-T T.416 color subparameters
Date: Mon,  2 Mar 2026 18:02:22 -0700
Message-ID: <20260303010701.631022-1-ronan@rjp.ie>
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
Changes in v2:
 - v1 of this patch only checked for the T.416 codes in the first
   parameter position. Now it uses a new vc_state for the subparameters,
   so hopefully it's correct in all cases now. Works properly with
   systemd in qemu for me.
---
 drivers/tty/vt/vt.c | 48 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c1f152d8b03b..16010bbc76d7 100644
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
@@ -2160,6 +2159,7 @@ static void restore_cur(struct vc_data *vc)
  * @ESesc:		ESC parsed
  * @ESsquare:		CSI parsed -- modifiers/parameters/ctrl chars expected
  * @ESgetpars:		CSI parsed -- parameters/ctrl chars expected
+ * @ESgetsubpars:	CSI m parsed -- subparameters expected
  * @ESfunckey:		CSI [ parsed
  * @EShash:		ESC # parsed
  * @ESsetG0:		ESC ( parsed
@@ -2180,6 +2180,7 @@ enum vc_ctl_state {
 	ESesc,
 	ESsquare,
 	ESgetpars,
+	ESgetsubpars,
 	ESfunckey,
 	EShash,
 	ESsetG0,
@@ -2699,6 +2700,47 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		fallthrough;
 	case ESgetpars: /* ESC [ aka CSI, parameters expected */
 		switch (c) {
+		case ':': /* ITU-T T.416 color subparameters */
+			if (vc->vc_par[vc->vc_npar] == CSI_m_FG_COLOR ||
+			    vc->vc_par[vc->vc_npar] == CSI_m_BG_COLOR ||
+			    vc->vc_par[vc->vc_npar] == CSI_m_UNDERLINE_COLOR)
+				vc->vc_state = ESgetsubpars;
+			else
+				break;
+			fallthrough;
+		case ';':
+			if (vc->vc_npar < NPAR - 1) {
+				vc->vc_npar++;
+				return;
+			}
+			break;
+		case '0' ... '9':
+			vc->vc_par[vc->vc_npar] *= 10;
+			vc->vc_par[vc->vc_npar] += c - '0';
+			return;
+		}
+		if (c >= ASCII_CSI_IGNORE_FIRST && c <= ASCII_CSI_IGNORE_LAST) {
+			vc->vc_state = EScsiignore;
+			return;
+		}
+
+		/* parameters done, handle the control char @c */
+
+		vc->vc_state = ESnormal;
+
+		switch (vc->vc_priv) {
+		case EPdec:
+			csi_DEC(tty, vc, c);
+			return;
+		case EPecma:
+			csi_ECMA(tty, vc, c);
+			return;
+		default:
+			return;
+		}
+	case ESgetsubpars: /* ESC [ 38/48/58, subparameters expected */
+		switch (c) {
+		case ':':
 		case ';':
 			if (vc->vc_npar < NPAR - 1) {
 				vc->vc_npar++;
-- 
2.53.0

