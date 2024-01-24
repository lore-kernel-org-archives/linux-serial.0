Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB761862A
	for <linux-serial@vger.kernel.org>; Wed, 24 Jan 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090775; cv=none; b=XVSY6jXDEXHSFLmyxIZ4gv5PCKXWhxIU32upZHOwo16dlhaNe8d7q5GXt6L0ao74Xnqi5EY8vhdTyA3QU1T2l2zEyvi2I4ijeFUIZtCHyGedSiwY2Jn7Z3aOKr27jAEP+J0khvyA5F2VYT0FulE5MQwdV8aPa9gIdFe6a2v7ZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090775; c=relaxed/simple;
	bh=tge2BaLdjdaFGZrfm77y3RHFGp3ee6D6Qs2RCPl4sYA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qql59gGd81k5uL39Xv6VG5o9tIfspolkJrOBrWr3WXJAiAPFATsSoJsy/w9dNYrW8Vd6SJjheR8ATzUua05aOjX3i6SxfO1xPduignmi1hohMkx2Ex6YrIhYY8dBDf2fHr/pMnXVTDE7vZvlCzTbNFu81HhS88COUWtbF8DBLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40OA6436043714;
	Wed, 24 Jan 2024 19:06:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Wed, 24 Jan 2024 19:06:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40OA64Mq043710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 24 Jan 2024 19:06:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <42d17017-1d30-4c54-9c28-9d9ba2494e07@I-love.SAKURA.ne.jp>
Date: Wed, 24 Jan 2024 19:06:04 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] tty: n_gsm: restrict tty devices to attach
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jiri Slaby <jirislaby@kernel.org>,
        syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Starke, Daniel" <daniel.starke@siemens.com>,
        Lee Jones <lee@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>
Cc: linux-kernel@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>
References: <00000000000039f237060f354ef7@google.com>
 <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
 <9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp>
 <82aa07d4-13ac-4b1d-80cd-0970c71752a5@kernel.org>
 <7dc23b9d-5120-4966-b47b-fcabe270d498@I-love.SAKURA.ne.jp>
In-Reply-To: <7dc23b9d-5120-4966-b47b-fcabe270d498@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting sleep in atomic context, for gsmld_write() is calling
con_write() with spinlock held and IRQs disabled.

Since n_gsm is designed to be used for serial port, reject attaching to
virtual consoles and PTY devices, by checking tty's device major/minor
numbers at gsmld_open().

Link: https://www.kernel.org/doc/html/v6.7/driver-api/tty/n_gsm.html
Reported-by: syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=06fa1063cca8163ea541
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/n_gsm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4036566febcb..14581483af78 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3623,6 +3623,7 @@ static void gsmld_close(struct tty_struct *tty)
 static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
+	int major;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -3630,6 +3631,17 @@ static int gsmld_open(struct tty_struct *tty)
 	if (tty->ops->write == NULL)
 		return -EINVAL;
 
+	major = tty->driver->major;
+	/* Reject Virtual consoles */
+	if (major == 4 && tty->driver->minor_start == 1)
+		return -EINVAL;
+	/* Reject Unix98 PTY masters/slaves */
+	if (major >= 128 && major <= 143)
+		return -EINVAL;
+	/* Reject BSD PTY masters/slaves */
+	if (major >= 2 && major <= 3)
+		return -EINVAL;
+
 	/* Attach our ldisc data */
 	gsm = gsm_alloc_mux();
 	if (gsm == NULL)
-- 
2.18.4


