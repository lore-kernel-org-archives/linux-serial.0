Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957E1F9406;
	Thu, 20 Feb 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050185; cv=none; b=WIBR5pEDH7aPQpreX72e1d6g6etrEIrxxTSHlB5p3KpOR4USq51BRhxlzbeownsKZAboYcXsvPiJoPbtv5veTOaLTwzuhDDLpu127heRsIaRqH45pLFjlSTOvpJT7LMp7saXL2Wk1t2vvascT524Wjc82NZ1i1VK2izTsvQxqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050185; c=relaxed/simple;
	bh=9R/axZV7gpmcyf96eMWRUh493VM9wPytpd/Af5AfIDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0RuWsxiICLvced/28jyLfsgIOkthENVCAPcJ693PzyG3zACU+w94+7fT0MPMQhjpNzRaA2Z3DvfBpWsHbyjYGwfKpjsj/2B8VOTlRTJ6bTpp291OpP0kWj+wlLgrffNGFRWQOEvVGNT0FK3Y62CHNf2MUipsaW5viWfutmlg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fluI+Scy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fluI+Scy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EE0C4CEDD;
	Thu, 20 Feb 2025 11:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050184;
	bh=9R/axZV7gpmcyf96eMWRUh493VM9wPytpd/Af5AfIDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fluI+ScyyM2JROMH6Flyi2SllHZ4MQOJq/Ra0mHGuohHf0ISCUCwybxUkvWtbXVgB
	 JF/+I/L40BPcTx0bVMM0qTCCD292f3vd84YyvoJEBQyMNbwcw4t4xqKz600EeDEC/4
	 DyqePSDnP2jMkgjexb3l9p/dwCn2aZei8LHp6vQDQo166r9fw19+3PTu6nm4a3ujuq
	 dTXlTfVx8o1ByJ2ZwhLPtuFUTZ8zqr93XJnD2SZEE/RHF9rrRhGq5BR4HFn5aG2e0C
	 B6x8akhXbklqGL5nXObEAIVzDimhMfot+uzBPOqpI7/NX5yoW7lKay2f5VZRA69aKA
	 /4U7jOvhempFw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/29] tty: n_tty: clean up process_output_block()
Date: Thu, 20 Feb 2025 12:15:44 +0100
Message-ID: <20250220111606.138045-8-jirislaby@kernel.org>
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

* Use guard(mutex), which results in:
  - the function can return directly when "space == 0".
  - "i" can now be "unsigned" as it is no longer abused to hold a retval
    from tty->ops->write(). Note the compared-to "nr" is already
    "unsigned".
* The end label is now dubbed "do_write" as that is what happens there.
  Unlike the uncertain "break_out" name.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index df52aae5f71a..5d172edbb03c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -519,17 +519,15 @@ static ssize_t process_output_block(struct tty_struct *tty,
 				    const u8 *buf, unsigned int nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	unsigned int space;
-	int i;
+	unsigned int space, i;
 	const u8 *cp;
 
-	mutex_lock(&ldata->output_lock);
+	guard(mutex)(&ldata->output_lock);
 
 	space = tty_write_room(tty);
-	if (space == 0) {
-		mutex_unlock(&ldata->output_lock);
+	if (space == 0)
 		return 0;
-	}
+
 	if (nr > space)
 		nr = space;
 
@@ -541,18 +539,18 @@ static ssize_t process_output_block(struct tty_struct *tty,
 			if (O_ONLRET(tty))
 				ldata->column = 0;
 			if (O_ONLCR(tty))
-				goto break_out;
+				goto do_write;
 			ldata->canon_column = ldata->column;
 			break;
 		case '\r':
 			if (O_ONOCR(tty) && ldata->column == 0)
-				goto break_out;
+				goto do_write;
 			if (O_OCRNL(tty))
-				goto break_out;
+				goto do_write;
 			ldata->canon_column = ldata->column = 0;
 			break;
 		case '\t':
-			goto break_out;
+			goto do_write;
 		case '\b':
 			if (ldata->column > 0)
 				ldata->column--;
@@ -560,18 +558,15 @@ static ssize_t process_output_block(struct tty_struct *tty,
 		default:
 			if (!iscntrl(c)) {
 				if (O_OLCUC(tty))
-					goto break_out;
+					goto do_write;
 				if (!is_continuation(c, tty))
 					ldata->column++;
 			}
 			break;
 		}
 	}
-break_out:
-	i = tty->ops->write(tty, buf, i);
-
-	mutex_unlock(&ldata->output_lock);
-	return i;
+do_write:
+	return tty->ops->write(tty, buf, i);
 }
 
 static int n_tty_process_echo_ops(struct tty_struct *tty, size_t *tail,
-- 
2.48.1

