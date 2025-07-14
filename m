Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA325EFBE
	for <linux-serial@vger.kernel.org>; Mon, 14 Jul 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509849; cv=none; b=lF9/yt1j3HgDv57c28sGEzIAVJ1KxbH7/RNi8kTeI0TdmIuPOYaFWoB6QMBgf6pfCj6G4HZdPnsYBCxFoD2ujdzc4xI76V1KHz0KvbSzSyaN/JUGn+6wECCv2JZ/y45f3iGC3kw+Jk972kp/aPIUVbPj0LmoSgfoDcpO4OEALhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509849; c=relaxed/simple;
	bh=vg4Oh6MH+0fma2aCD4vkfmcRFiED09zblF5ZveyabYw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VZZLiV1IwQSropBYpxaGMEUBDc296y4j7lSvt+0AfwfU8Q9BPvoAow/cmxdGbna/Fhbs5bm6QqwUKtPUNc3P4WRj97naP/ElJLpdWVg6g8P1nL7h3lSdTSC46y38QoCC2WTvMkkhhzAPirkzOD3MDd0mLQsDJ07EJQvzT+Et+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDX8cwRg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDX8cwRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752509846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IdkWORgQRX/v02euiHEounqm5FwbRCKcrBeNyY/I87o=;
	b=TDX8cwRgqlfYA1bx+pfy+H3qJZiBhiLpoyA5IrzvoBgZN4uEaEyTQoPtDqt2ICDLA0bppw
	ed1OyqzpcwBCUfN1baDWT6DWQP1cBwTo1qzxnBL6AtVgFPZiC5n6AMlqXXPS15l/npOLmA
	DVk74jpD6gdFBFrMfONRP3C0AxtV/bw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8--4Jk8XLIMU61Sn2Uz2NOeg-1; Mon,
 14 Jul 2025 12:17:22 -0400
X-MC-Unique: -4Jk8XLIMU61Sn2Uz2NOeg-1
X-Mimecast-MFC-AGG-ID: -4Jk8XLIMU61Sn2Uz2NOeg_1752509840
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A4151809C9D;
	Mon, 14 Jul 2025 16:17:20 +0000 (UTC)
Received: from [10.22.80.10] (unknown [10.22.80.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CFB719560A3;
	Mon, 14 Jul 2025 16:17:18 +0000 (UTC)
Date: Mon, 14 Jul 2025 18:17:15 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Guanghui Feng <guanghuifeng@linux.alibaba.com>
cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] tty: omit need_resched() before cond_resched()
Message-ID: <5a11ad09-5508-933c-f044-6a236bf00557@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There's no need to call need_resched() because cond_resched() will do
nothing if need_resched() returns false.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/tty/tty_buffer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/drivers/tty/tty_buffer.c
===================================================================
--- linux-2.6.orig/drivers/tty/tty_buffer.c	2024-03-30 20:07:03.000000000 +0100
+++ linux-2.6/drivers/tty/tty_buffer.c	2025-07-14 18:06:00.000000000 +0200
@@ -499,8 +499,7 @@ static void flush_to_ldisc(struct work_s
 		if (!rcvd)
 			break;
 
-		if (need_resched())
-			cond_resched();
+		cond_resched();
 	}
 
 	mutex_unlock(&buf->lock);

