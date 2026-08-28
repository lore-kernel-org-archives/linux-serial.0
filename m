Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6E3C768E
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896421; cv=pass; b=YyjZn0NAp3tab35SJ7LVmopBt7IKZb+TvPMu5SY+BGn/6q3KWxx3hyitFV56RPF5MD8kjB212T8dzlbPZzxrVcbAMHz3Pa7Q8Gi4FdGvppue5MGG1n+g965IV3o64RLeE0VUVH7n/0n/vZb3JzB5fIFHQWJFXmiGUrBxu4eg3n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896421; c=relaxed/simple;
	bh=ITQFmS+Ozzm1nDF/1jQt0yIIZCz76SW4Fa3oHsE5RIk=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=nBIBMyG1b9TapfOzPWg70Dtv9MiwFuajL9XOCPSfVrlZgpCcbwqdyN6aJL3UONKAVylsG3TriVlROuf5gSFNUsiljVZRwaL2/hzSYVmd80eRDurZKdr2WZp+HJ6rnZjoooDlKg1k6APRo6FaImCO4Hb0zLAzaD+OdJ5Elq7xD5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=qHpjmFQ7; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="qHpjmFQ7"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1431042a12.1
        for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 22:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896419; cv=none;
        d=google.com; s=arc-20260327;
        b=dbYgu3HT8iXKMdfPBy4Ui2ddG4tvEmUGzaUPTMc6AhAZFWq7lMpjKH2kwktCuhZEA+
         74If2czusl/SAfilgb2siyvB4Ywppn9H3XWx6XK7qKRaBy/zZyFIV2aqELKyX9U3iNZz
         KU144JqfYFNHnEdTt++uYJedMZKgEgM609iZKp9PDXGBuYtPRV3BpF20fFFs4/YB2Bui
         MFv9pV0vii61iGLKMAxHaygJDkADyc9ZPNHiXAloyVaUzx1y/XTjac+gKaJueyMI4EXc
         3fu2F4F7CWnxk5Yyw0jUILMiKfzpCSe0iVzV+noyK3bTYtirID3bxCYEqlpfBWnIyfYk
         8ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=8Ajix6pSP3dD5mSuyEhKRU4hsb+gmrjX44fsDah3OII=;
        fh=D7Q5GEuvfT32T69l/m/0iM4MNOs00kK6+wwjQB/M9sQ=;
        b=rsbiCWaPdH47drmvrZFjbJoLQDYPWu+N42bndXJZeWdBmcb/DDED1f/u8JktJrF6pH
         wnTsXLzBMA7AfdYZJSBIRMxrpyhplVEqeiq4angwXlEZ6ty06pVSrHnNZ1VTKqrzDvBr
         9d33FJIGbXqKgTrrOkuAMgdB7ycoh4ryb+cg6cJS4O0D+rcBNiGo6Rasg/xjUs6miSrC
         2+AmNdyGF0nR/cJm/0ctrWwMvTC/N7xhI88hP7xFZHiY1gjSLH9GiA13P7uxNqTKtPhT
         8fCHcv5/L56xBYrgVaczs4Pavj2nFBeaUA0CS7OgKAjllcs/Af3ZK2nnhi7bQqOuQpMh
         it8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896419; x=1788501219; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Ajix6pSP3dD5mSuyEhKRU4hsb+gmrjX44fsDah3OII=;
        b=qHpjmFQ7TDrymsSYhshbzNjcdlY2uH9HRb4fpdmMEJt05kWY/QFzLAeIygeQ2b11SG
         uwrHf8WPz2NITjFDdkjLnCJFH+eD9ZqQD4wssZgt2ESJFqKUcRgwAr9jjj6K2PejG0Mw
         qaOBTzc2Y1v0LsHhOWpWPBut061UxwhXmfQnwlwtae6k7XanhJ1wI1mDouJaJre3ZpMe
         hC+ErUP942VXXZjbA4F5IrBCD6thl7niVlTcXrFbQTE5+1gmIdQvxW6iwFyZmmB9pKep
         nkHo0u5JfBoq5bZEKF4E6P0PnZWa6lpjOPydhOscF+bqHCwpfxs4lcMXlvGQd74HpTsa
         06xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896419; x=1788501219;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Ajix6pSP3dD5mSuyEhKRU4hsb+gmrjX44fsDah3OII=;
        b=Q+xOqDR74ANAUEOseh1ARcg21L9zgqrn2j/rCftHj/OEGCAs+W5CshcwyzwsHLmyvT
         zAuYHjgp7LrW6pkcqQF8Q3H+Jc/MmNduQrDamCR3MmdNt15a9C90BNx62YddMrqMyfv0
         60/fkwHp5Zaqfh9nQecRmvt/8U/95Xsu4vip1TjiMcc6BqNKFY9evucTJKJVFVgdZ9wD
         DnSU7RdNvsH+h8huQjckTK7r7kb3zqpxYcCTTBT2WJgM4bqYgZmSlGphkSuheqx9zJu6
         Nt9F6hMrNTpTinquDg+29CYOVTuu48/MMGaq5bauGYMMZ1pwEHp5CC4DXtEn7Rnwaug+
         I1FA==
X-Forwarded-Encrypted: i=1; AHgh+Rph7Ai9CHhUNkGlvp8uodUmpDP9MKIYTSoFSNh9vfTJm6GUKGWVM96e44V8J48/qErYB73KuXKOmgScWL0=@vger.kernel.org
X-Gm-Message-State: AFuF++nGIV5W5xpcQOSXBA1fXmZC1QvaVUvwi5w3Wqsc8/oi12xHsjX+
	YFfRIZWSOy/tSFra0+Vh2YTJrSqwMo1LZ2VSM7C0kVGz8BOe5ODECSIgcDLlFd5qjnBa100W4sM
	zm1fhRiXp7HN7YEI3Z/9eE/stHylyssc+oF3GERP4
X-Gm-Gg: AR+sD13omObg0HwKOq0WzhxD5grJy0SuONvkfuNc1gGEzhRfsj+XBExCqtckhWSc55L
	cUcevLo9l/TAlsSJdzU4P8CmTuUYwLeBIm8Q/8S9Najj8SZfzewPn6tZraxwy4v4WqV1xQ1mkbx
	Pa98pz2VO7JrZZF6phLKLETvtHikHqdJPptl2txaQHq6Slx1N/T3IzbbKTCn4gVIBXQBW18Z2Xm
	LxJhIcyYdazXXM89myAORaDm1PLgv+GofkjBYgJRzaGd0jUXdGAErr3SjnCdwfR3L8yCsEQM/V5
	+9ky7MmMx7OMRGPAIvtwez1AiRXQEg82GZxSI53o7gAHZYKHfve1aG/yKuPoyUETnV7nNS3MxI3
	HOSIpeiwMSUK0Yi2u3D3yVXzjlkPFdbF8
X-Received: by 2002:a17:902:f693:b0:2d7:4bc8:41a4 with SMTP id
 d9443c01a7336-2d74cdb922amr46484225ad.10.1787896417858; Thu, 27 Aug 2026
 22:53:37 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:53:36 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:53:36 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:53:36 +0000
X-Gm-Features: AcwNN1XuBPWoPSWLXoMRUh4L35STvJf21tDRay3RqU4hvbKFfNsN2N54C3_w-do
Message-ID: <CA+0ovCh9MQE6BZD-8vqWMcrVS8Bj-tYY47HqeASvE7_b9QP-ZQ@mail.gmail.com>
Subject: [BUG] WARNING: refcount bug in gsm_mux_net_start_xmit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: falemi@asu.edu, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/199-warning-refcount-bug-in-gsm-mux-net-start-xmit/

  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110
lib/refcount.c:25, CPU#0: kworker/u8:1/14
  Workqueue: ipv6_addrconf addrconf_dad_work
  Call Trace:
   refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
   __refcount_inc include/linux/refcount.h:366 [inline]
   refcount_inc include/linux/refcount.h:383 [inline]
   kref_get include/linux/kref.h:45 [inline]
   muxnet_get drivers/tty/n_gsm.c:3938 [inline]
   gsm_mux_net_start_xmit+0x3af/0x440 drivers/tty/n_gsm.c:3951
   __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
   dev_hard_start_xmit+0x23b/0x620 net/core/dev.c:3904
   __dev_queue_xmit+0x160b/0x3250 net/core/dev.c:4831
   ip6_finish_output2+0xfd4/0x19b0 net/ipv6/ip6_output.c:136
   mld_sendpack+0x820/0xe00 net/ipv6/mcast.c:1855
   ipv6_mc_dad_complete+0x85/0x470 net/ipv6/mcast.c:2279

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
