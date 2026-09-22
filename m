Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835B37269A;
	Tue, 22 Sep 2026 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040440; cv=none; b=gFoJJ1mwOrHdqt5dy9+1axE1mRyqhDB2JCojwzTl6j1CpIM9Phe+820SweljOC4O27YHuH6KCoW65M025xtowlRb4sb+fa7sSWnB/Nx8umOxjv3D+LlskeX0Qrs964N66jZdPEpdZQXWjpzHUxSWyK3JhFcr58UjUEflMZLSDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040440; c=relaxed/simple;
	bh=k6PVgik6pJNUc/FKNT3s50C9vrgLpeG7Wr/Mobsafz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhGJzhtDod2qtJ/xVqOGHuSnXYECBCSDNiZDooDo2khhD6l0+wfSjlbW2dWLo/Lbv+H/ZzpQIzBYw/pvjtnt5XPONEbkkWb150yFluxCzPq6lsDeg0VcZGPlN3fPfH5qKg3ns5Ey+T/VEu2DjthzcqFcKIlfngK/tr/5yr3Y9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khRHjdk0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khRHjdk0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1F85C2BCFC;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040439;
	bh=k6PVgik6pJNUc/FKNT3s50C9vrgLpeG7Wr/Mobsafz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=khRHjdk0sgCDQ5qo8S6U9G59INoG9jIsnUGOFKWVgGYDYAWD7gwzZPQIFvKBanOQ4
	 bUSJ1vKgqNZGSSVZOI5mxKCksbknXBlDRhGetU+c0eP3SXNjdYwlVUjsQeLknu9Sm5
	 SXSAAJzIFXiRaePF9R5Fc/z+pVcnCV+wrJ8Ase9Hysi38P+zjNi/P9yFkhZU0e2MfZ
	 Bdx6vm3u8c4xcHQlICrikCCOn8k6zAGDRwJfMo2HIFje9FznUrsone2rQr/XGx7L13
	 /FoiBzavWayjKA1KSRUnTVugJLofJhBwzggTkfaqt3aIQaR85l8TDc7KUPbgkJxvo2
	 Or+pOUQnrlJVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DDDC982FC;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:27:14 -0400
Subject: [PATCH 1/3] vt: order the fg_console switch against
 vt_console_print()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-vt-v1-1-71b7990c26c1@vt.edu>
References: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
In-Reply-To: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040439; l=1552;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=t3w49a+qfe39Dk2oPAqqzDMPS4oixsoA4+DLTHcPzWQ=;
 b=gREHg8oU0b+2dX6YOKClDz3gXZ9k/R+gxQhItKMJW2tnsE2PJTZ9ViDqHLlkcePX7de3mQ0bE
 iSvsIHnZs09BQ4GN1h2RKFDPWKvx2K7i80tCVWpsRFySn/Gr+nJmEiw
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

redraw_screen() switches fg_console with a plain store once the new
console's state is set up. vt_console_print(), the printk console
callback, indexes vc_cons[] with fg_console before it takes
printing_lock.

Store the new index with smp_store_release() and read it with
smp_load_acquire(), so that the printk path cannot reach the slot before
the console it denotes is complete.

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/vt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57edf3749..3abbd6cf9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -973,7 +973,8 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 		if (!con_is_visible(vc))
 			redraw = 1;
 		*vc->vc_display_fg = vc;
-		fg_console = vc->vc_num;
+		/* Pairs with the smp_load_acquire() in vt_console_print(). */
+		smp_store_release(&fg_console, vc->vc_num);
 		hide_cursor(old_vc);
 		if (!con_is_visible(old_vc)) {
 			save_screen(old_vc);
@@ -3447,7 +3448,8 @@ int vt_kmsg_redirect(int new)
 
 static void vt_console_print(struct console *co, const char *b, unsigned count)
 {
-	struct vc_data *vc = vc_cons[fg_console].d;
+	/* Pairs with the smp_store_release() in redraw_screen(). */
+	struct vc_data *vc = vc_cons[smp_load_acquire(&fg_console)].d;
 	unsigned char c;
 	static DEFINE_SPINLOCK(printing_lock);
 	const ushort *start;

-- 
2.43.0


