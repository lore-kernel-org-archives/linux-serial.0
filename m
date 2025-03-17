Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B321A458;
	Mon, 17 Mar 2025 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194858; cv=none; b=G3ZnOMH9O5I7eGHpUqb5XzXunFb5xvnoYSb3aOrXl/hUJti+H5nK8rrAf8Cm131UcPfQvwz4jsNlMBQmClZBCF640++YHYsUNPLK9nDSMFiNiLKhikF6HYWcmZji3dGMMbJfsaGEUj33kSsa87foDcCL5wELmof5Au+zEGkRjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194858; c=relaxed/simple;
	bh=heoyOrgbbFmz7nxxRN+z8nbd3qdiXGzHhNH5YXrgRyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXnb9Mx+fR0LtjqOhC4lbGM3u1JC6wKGUcrUTrxw35h2W6sUIll0KeguGgYD904Wy4jsOfmsqNEQZI+8SFhUKVmChBTWKTrVp0x+dzXmsS1j1ry6CwJmjLbcEml0ITMCoiud+Ov3IhmmXUqi28cHkMU8K2+0flhS2TLciNYujYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE0thvIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE0thvIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30676C4CEF2;
	Mon, 17 Mar 2025 07:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194858;
	bh=heoyOrgbbFmz7nxxRN+z8nbd3qdiXGzHhNH5YXrgRyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eE0thvIfMROO0DH0N+yXkOIQeRWPWSXmtYGC4Iio3VcN3nAQ2lPw9EcsLN8l4fGDX
	 8ZiGstGFHG+Hfpc4CqN5RSc0s0an5OrahZo2z2Pw5kh1r9N4MheIISG0TCZBguOlvI
	 0vti60ezltCh8d1luu5vdlLcGZ1bvBUku0hMS+ojmAXHyySxLPLiHjvQ9Z5UzQXA5T
	 AmitiXTmK1shk3jAX7FRh/vrbPycLhjIbXKaqC5fcw/Cf+Mb3jBXKmD3+OWfSauozt
	 ruvt1HOZ3Al4Wv6cAdFgojSHxxbijeUR96LlDJto9WtZBcow7fg0jJEDAE99Cbshvo
	 6nM6d6u+GvyDw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 05/31] tty: n_tty: use uint for space returned by tty_write_room()
Date: Mon, 17 Mar 2025 08:00:20 +0100
Message-ID: <20250317070046.24386-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
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
2.49.0

