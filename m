Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45401F76C0;
	Thu, 20 Feb 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050182; cv=none; b=cFt2osVaDlJ5t/9kQUA4BYXxl6kWc0J+CrHlKO5MKk0HhAuEsVQRrZ/IuRhFSwhDZqZfrupw7CRf6j9gCbNz4SDkMsRaHuPsGhLwQEuPo2ZziqAZ2IWaQUWsEuMMh0oTaf4TG4xSYJsF7/S2T9oCEM6CFazcZuMW1nNt5Ye9RU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050182; c=relaxed/simple;
	bh=g/xpmM3Fe7B6ZiGr/t3gDZeq/cT5LL/Gr4ylSKdLgr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3+aqsDTp6Ma36KlQWu3xpyXO9oGUNnlyLrCbL66WGMxyBGZDpF988XvB7BZNHs1Qbt4O1SmXRlNj4LxN8U2kvncOPTEDs1f3FEw1Qh349IVDUgL+a4KDa18z5NAkFqbYPkN6aNQm1pYNrkhlQ0kHQ2CdiNZpYUjxQvEUJRbeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT/otRUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT/otRUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F23C4CED1;
	Thu, 20 Feb 2025 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050181;
	bh=g/xpmM3Fe7B6ZiGr/t3gDZeq/cT5LL/Gr4ylSKdLgr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KT/otRUl/OfpRsrrQHV4MVEVEi0K/zCSmd8s+ENW+ma6hkc3OELGlNlfEBsXYd6f/
	 6XRaADo29YtodxbyewD23+55qxTQByf5+CkCz7H52wixB+TEhcsubhp9b8MtcnFfdj
	 v+wEZ8IQcJn6+YmpD+1kNOzEZ0PALTvrH0Lh1BQnx6s8FCVVq3lgMC2cOnwGJ9BbKg
	 2RtBcvfEuE40wV2egx6okO9f4EuPWKeT/k1P3YjOdsyrzthH/jDC5UpbAblikckghe
	 atVJiGKHYO5TAGQ9UY2OQaukG5ccxxHaOJg/tcklxZKEtjUIoyVIifpLQOeA2nMeDs
	 AzyrJJruqeJWw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/29] tty: n_tty: use uint for space returned by tty_write_room()
Date: Thu, 20 Feb 2025 12:15:42 +0100
Message-ID: <20250220111606.138045-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_write_room() returns an "unsigned int". So in case some insane
driver (like my tty test driver) returns (legitimate) UINT_MAX from its
tty_operations::write_room(), n_tty is confused on several places.

For example, in process_output_block(), the result of tty_write_room()
is stored into (signed) "int". So this UINT_MAX suddenly becomes -1. And
that is extended to ssize_t and returned from process_output_block().
This causes a write() to such a node to receive -EPERM (which is -1).

Fix that by using proper "unsigned int" and proper "== 0" test. And
return 0 constant directly in that "if", so that it is immediately clear
what is returned ("space" equals to 0 at that point).

Similarly for process_output() and __process_echoes().

Note this does not fix any in-tree driver as of now.

If you want "Fixes: something", it would be commit 03b3b1a2405c ("tty:
make tty_operations::write_room return uint"). I intentionally do not
mark this patch by a real tag below.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 2c5995019dd1..765d24268d75 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -488,7 +488,8 @@ static int do_output_char(u8 c, struct tty_struct *tty, int space)
 static int process_output(u8 c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int	space, retval;
+	unsigned int space;
+	int retval;
 
 	mutex_lock(&ldata->output_lock);
 
@@ -524,16 +525,16 @@ static ssize_t process_output_block(struct tty_struct *tty,
 				    const u8 *buf, unsigned int nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int	space;
-	int	i;
+	unsigned int space;
+	int i;
 	const u8 *cp;
 
 	mutex_lock(&ldata->output_lock);
 
 	space = tty_write_room(tty);
-	if (space <= 0) {
+	if (space == 0) {
 		mutex_unlock(&ldata->output_lock);
-		return space;
+		return 0;
 	}
 	if (nr > space)
 		nr = space;
@@ -698,7 +699,7 @@ static int n_tty_process_echo_ops(struct tty_struct *tty, size_t *tail,
 static size_t __process_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int	space, old_space;
+	unsigned int space, old_space;
 	size_t tail;
 	u8 c;
 
-- 
2.48.1

