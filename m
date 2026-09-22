Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495DD374745;
	Tue, 22 Sep 2026 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040440; cv=none; b=LOsq4kftCiMM9OQi+a1Ls9p8nhefEv1Kbenj4RpQ3NKV1CIceFuq/EU0QMAfR7AqhRgFM2Nig936QBrWSACKComZ9YYJl+L9a9RnpPIMabDvXR5RpoVxZYyasbJtaqfVgiXgsef9RwJLjgjujZ7gkL3rEPO44QnJf7IGczg3Br0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040440; c=relaxed/simple;
	bh=7eA8feO7whFlNxG6uPOTpe0nEmA+jk1VeeJHVW+2aXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9ASsiW6gdc2c1hr+JAYKnrQcchvvSSvgv+E+q/ucI60FeUnBrL41REQeHZQfEIj/5VBxNR1tKBWXMJkyayhePImrn8J4OG6ichOGX4Zo3wJxuAe5J6h3N4GIV7ltd/PeZ0gjiQGyPtFsEeM9YxroNrU5VmMlc84r6iRRvsH3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwe9dTu/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwe9dTu/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8988C2BCF6;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040439;
	bh=7eA8feO7whFlNxG6uPOTpe0nEmA+jk1VeeJHVW+2aXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wwe9dTu/swGLGsZ2wZf2Qscxqta7e5/RjPS9NmfOXUOq9EIKsnzwe80PmmB0OVvRu
	 81utNjLQzfKGSYlJBraCMOETC+MD1C97NH3cGEf5ZETC9TfIiTZFwqaM5b1i1ymAPl
	 eGviwYzXb7N4A8nMXU1ejv5ga5CHUdzaFk+lx5MFqv+4RW/sy8v+Tor5YiYj6G4P7H
	 wC94lTJlo1D1P4SRkVPiRnkV/OjVQ0l7qdkTeF3i9WJ84rM5kg3d5C0XBFtlkSHaiJ
	 +yOdpDy+CB6yG7dY8qHIKbACaxAzd9lXcp4GTmgQkBy5gdyeyHOmiyblUwHOuRegt/
	 phpjo87JUdCVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC921C982FE;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:27:16 -0400
Subject: [PATCH 3/3] vt: order the vc_cons[] clear against
 console_callback()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-vt-v1-3-71b7990c26c1@vt.edu>
References: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
In-Reply-To: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040439; l=1520;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=n064wC3Fdt35/BuS9qHKcc8lilea0y9ChG1ooSTcVBk=;
 b=Cyt/0YbOQE8rFx7wYIzQ8vqzJBMtdzlsL/BBKnz9w9AzPzpGW72AsY5HktLYXJ+9ocVbqB4jJ
 XjrdM5P/lGsB+HepieQVYNFM54YzSadx3wlB5bHuRj/i0NXCxQAGUno
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

vc_deallocate() frees the console's screen buffer and unimap and then
clears vc_cons[currcons].d with a plain store. console_callback() reads
vc_cons[fg_console].d with a plain load.

Clear the slot with smp_store_release() and read it with
smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/vt/vt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 726402167..66aa089bf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1369,7 +1369,8 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 		put_pid(vc->vt_pid);
 		vc_uniscr_set(vc, NULL);
 		kfree(vc->vc_screenbuf);
-		vc_cons[currcons].d = NULL;
+		/* Pairs with the smp_load_acquire() in console_callback(). */
+		smp_store_release(&vc_cons[currcons].d, NULL);
 		if (vc->vc_saved_screen != NULL) {
 			kfree(vc->vc_saved_screen);
 			vc->vc_saved_screen = NULL;
@@ -3368,7 +3369,8 @@ static void console_callback(struct work_struct *ignored)
 		poke_blanked_console();
 	}
 	if (scrollback_delta) {
-		struct vc_data *vc = vc_cons[fg_console].d;
+		/* Pairs with the smp_store_release() in vc_deallocate(). */
+		struct vc_data *vc = smp_load_acquire(&vc_cons[fg_console].d);
 		clear_selection();
 		if (vc->vc_mode == KD_TEXT && vc->vc_sw->con_scrolldelta)
 			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);

-- 
2.43.0


