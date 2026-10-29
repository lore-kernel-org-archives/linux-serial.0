Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233265;
	b=vpgNNX80gMh/+YAiwUk8c9c1ph4tPDDim60Y+b8NzNCRKF2EDZpdQ/JCMCxaD9+49HvT
	 AGPnMZIHWv1oxHfajYOWjF8LKrH1vTlpQyicBGAR5qGr6ZseEZvBZ2f06iZaAUQhjTuo1
	 aBCwij8HHzxQzDDn5i40zT5AcmH/zIs/hxg1BQLHZfufRQQ9aUEl9gX8u8mXal0mDNqRo
	 kwCBOxJIPVad+MxU333d4WHIfnY0cdL8Wj79NUe6SaGuZoogMj1V7rXnYe1SZ8EE/lB4Q
	 u2ugFFUIkMkIfrA5jKv59QPDpyakPqXxolP7V+2Cf/pneKwXARxm51kkQIwZEfRf41A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vIq9wiAZmB+1KmS/yZYktHfXkQOvd/D+bv9o1qwC8Og=;
	b=MvRPMRo0C3muQbNLh37alb6YDhClvSmKGr16eGusuaz1M3AqTMW0VHUzOlc/1QfMxu8g
	 TotxqJmSPrSTOx7CiRXJBPXZYhg6osWn0ZBte1TEbyQPZNuSb7h1mkYpR83q1WsPa1uBX
	 4hl1MoM7QWVhszTEDoOVOy8+tSEihhSw+MLZuefpMvPHizlaREwySJcqaVe7Mk7TFyNFu
	 rRc2+GVuTDHTavYZN/gNmFjkwyn6TZ0FuFjOrSzFaafN0VN0IU97VIoaeUSnPv4h1w6Ul
	 MJv1dgEp/89K3m/iUTMiGtG/4/eh13l0HnticXcOvs37wxGXgsnm59RGTQ8qRDGYBRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BU67W5xi;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CEA606A31D
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 00:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7CEA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BU67W5xi
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a24f47293so652971eec.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793233264; x=1793838064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIq9wiAZmB+1KmS/yZYktHfXkQOvd/D+bv9o1qwC8Og=;
        b=BU67W5xi9WiPfZIoOW1HWWnGmpeWpYPpZggpKZfHCTykN1g782C8BjhTQMVA3K6zHa
         4DwIy9vU8jzHTrw8Un9xwJ+iqTZUCrEJFw3U/V3wjXUA75VYAqP4IzzNM5iZdxWvNMSN
         8kuYeWIjYXGVrVQfRKUf1iuPy4D+/GgsprAc6LvxCZ06Wqp9DfdVHNxtxGSDtikG9khB
         K5YpbZEaT/+TaizkUa/SJmBAav8ydqUPNTESboVpTgkLg1ksdYAio+d6eEo759vbqNhy
         eBq6o+8pljY66j59LVMf0otTeswh5VLedbMOQ0WKrnQzm4BK7gaN5hXShIZynOj8T/dC
         zZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233264; x=1793838064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIq9wiAZmB+1KmS/yZYktHfXkQOvd/D+bv9o1qwC8Og=;
        b=SUfPYS3vT7lvDRAVE0WMJ1GTpn4ny+xiCgtnBJTxfEPv+iNeNsKjjXtDRtI6LY/78j
         YT9aaVfv3nagXFnGpngD9ii+Fr2aTKybl/mh0au1A+syZM5aRTPk0WaUlV5tzYRJBYiT
         Wu7dto2fGvxS0YNPHecMtidJYbgDU5HGG1y+s9IFjhsSwpwTIP5l+1iq5may4oQVW2pG
         QPtlGzsdxQ0koVWP8deWLfsc6IzecpNSsLa8PUbEVEC4YR83B2cOXDdXYzOF0GqJsv2R
         pXgEnoDP11Vz4CxCW8CEC9OT00wx0nD6oMN7wmxaPYAauZL9HnnY1xfedsEiAMmYW2gM
         vfSA==
X-Forwarded-Encrypted: i=1; AKwUvBwWiuL9aL8MoBeyS/dS7bmNQoqnSdjX6MO61rSP6MtMbeLvyEUzk5BCInYcqK2U1e0D6w2beXBy1hSR/kk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIj/w59b6J/2jjp2eElDMFyC4aJEStjabAhXd1ZZXHA6quVKWbq
	nPY8xdDllG/mscwOuJoacqYuCkGM2YTU9Tk80Dzo0tLF0KCWNjoNqUhR
X-Gm-Gg: AYBFou3rkI1O2BlnEFJYYcKNZFb9DwnWWdrhm8Fw9DNmCDCoVb/G22g1Pnja3NGgdU2
	L2aLmnuY6oDvIZrWoTKcYNMZX6KcLpDWzX88f2fCMBrDnrda5SliFtzyiOEIZCLDs5syXT6/cjp
	yGYzXvj9+bSdkVLQIndNMQYITDS+AmVWLW2ZorDsjBiM/yG+b3g2ZuxEu8wxGNck8VjkNxoGRqV
	r9a1HKthlq4FziD/OZpRA9xZbZv16OMOXZ5eRxN3L2Z+OghFB8AJVfpDdeu7eKo7wtvjq480XqK
	FYmPd8OXsQzO24T9qQymFnS77Ryu0iLtNH7ntHDX3COaPuPO76+/711/aw2ChTjuCSClClFJiqG
	DvkvY4jGrUNvOxnkfJckNm8brAK5kUgvmBfh1XM+2Q0cbwEwXcLB3+w2hTA0qVhKfLtIUBLC6Yd
	B0VoXZtxd9tyVNkTJ9smy0PohMjCXya6H+dDWXzv+uNP5osLGyLBZ8SgeLqYn6+zShgB1+Dg6/f
	icSm3gey7QNPip1rbEjYWu3c9J6zmMas4HnrBzMx127br1r9u4tsGbf+8NjMgBcjjuuO0s4ltRP
	TuwNo+QS+xJBS5VMFnO6qdnGfYqhrpfzVMEZzHgwEtrBWHwpyoeYbbxe
X-Received: by 2002:a05:701a:c945:b0:144:eaa7:2763 with SMTP id a92af1059eb24-1a6ce01d2c1mr4046362c88.16.1793233263061;
        Wed, 28 Oct 2026 17:21:03 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a7549528ebsm8845495c88.0.2026.10.28.17.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:21:02 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] tty: n_tty: convert the full VTIME interval to jiffies
Date: Thu, 29 Oct 2026 00:20:52 +0000
Message-ID: <20261029002052.54117-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VTIME specifies a timeout in tenths of a second, but n_tty_read() divides
HZ by 10 before multiplying by VTIME. For supported HZ values that are
not divisible by 10, this truncates each decisecond and shortens the
requested interval. For example, HZ=128 and VTIME=40 produce 480 ticks
instead of 512 ticks for four seconds.

Convert the full interval to milliseconds before calling
msecs_to_jiffies(), for both the read and inter-byte timeouts. This
preserves zero VTIME and avoids accumulating the initial division's
rounding loss.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40d0a..e485cf36dfa1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2219,9 +2219,9 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 	if (!ldata->icanon) {
 		minimum = MIN_CHAR(tty);
 		if (minimum) {
-			time = (HZ / 10) * TIME_CHAR(tty);
+			time = msecs_to_jiffies(100 * TIME_CHAR(tty));
 		} else {
-			timeout = (HZ / 10) * TIME_CHAR(tty);
+			timeout = msecs_to_jiffies(100 * TIME_CHAR(tty));
 			minimum = 1;
 		}
 	}
-- 
2.43.0

