Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC73AAF64;
	Fri, 31 Jul 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484608; cv=none; b=s9UjxWyWerGjDCDnPnT2TYhER8x0PPjCWq2M02sBWu9kJSKg5/XvAFB2oqYYiM0DPWR96Gsy8+gBYH90jy3VnhyWqzuLmG5VGQeuI4xRJX88iwdrKME8rFP3U74bFsRAi4JssCHW/vL/BoP0kV5CpBk+A2Bg/oTRVfiaML8K15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484608; c=relaxed/simple;
	bh=vuu4yi+Ch+4YBtvqdb0qaT+V3buKa9JSxUmYrc3SimQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0FM7dL9nLp67jHOWpq88f8OozbKNPCQXnmT2vwN+EixRnSp31nLBs9oncTzjpzJjTWTT3CwR3jeSb/rDImmCnp5M/vr7B2ITZ0lQcTr6ZgERt4W8/abhXzeQnuuW7OTMeW4Ayh2FWygC9x4ohyZMWpuTOEYzpFnZctmuvbSXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8x1QPbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8x1QPbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DB21F000E9;
	Fri, 31 Jul 2026 07:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785484606;
	bh=P+0f3FRwGuc3iVlmRv9G6z9YCsWFSVFsIX1I41Peutg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e8x1QPbLzWEsSmZTL7HNWViJzFi7JE93a+cRZgNAZZN9ZF7TuWXq/KDxnLfVoSZ8C
	 uFgirH/8oozEv581TYkP2X3Zr1BPOQOWSXnfwX3crX1xOmOxG2YNTl49eMdKPcN0ky
	 nF1efwBan4qXA6G1qJFEOIxvT/rB4ODoPUkPxRQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2026 09:56:16 +0200
Subject: [PATCH 1/2] vt: stabilize tty reference in kbd_keycode with
 tty_port_tty_get
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-tty-vt-stuff-v1-1-be99b9da8e30@linuxfoundation.org>
References: <20260731-tty-vt-stuff-v1-0-be99b9da8e30@linuxfoundation.org>
In-Reply-To: <20260731-tty-vt-stuff-v1-0-be99b9da8e30@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Joshua Rogers <linux@joshua.hu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=2Y4dwKFZsFE0B6a6UuQTZ9/hGIojB3XdtZDmwBQxBmY=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5oTplp7I9oth/WivVpl2bZi/gGR+7IWTTFPdXTZGJh
 4T3xy/uiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIkcsWVYsC57bayMSz9D1P6T
 gdfqilZtTskKZZgft2bp74d3kzS0K56nXHXdfldeZJsdAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

kbd_keycode() reads vc->port.tty without acquiring a tty reference,
racing against con_shutdown() which clears port.tty under a different
lock. Use tty_port_tty_get()/tty_kref_put() to hold a proper reference
for the duration the tty pointer is needed.

Assisted-by: AISLE:Snapshot
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/keyboard.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 763a3f1b7be0..c41d850b29c6 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1437,7 +1437,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	struct keyboard_notifier_param param = { .vc = vc, .value = keycode, .down = down };
 	int rc;
 
-	tty = vc->port.tty;
+	tty = tty_port_tty_get(&vc->port);
 
 	if (tty && (!tty->driver_data)) {
 		/* No driver data? Strange. Okay we fix it then. */
@@ -1497,9 +1497,12 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		 * characters get aren't echoed locally. This makes key repeat
 		 * usable with slow applications and under heavy loads.
 		 */
+		tty_kref_put(tty);
 		return;
 	}
 
+	tty_kref_put(tty);
+
 	param.shift = shift_final = (shift_state | kbd->slockstate) ^ kbd->lockstate;
 	param.ledstate = kbd->ledflagstate;
 	key_map = key_maps[shift_final];

-- 
2.55.0

