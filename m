Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCBA4071E3
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763940; cv=none; b=MtVegqtUK91tnwHYT2vetMEot3e3LwVtlUZJXNmC5QMlMDYEqnStcZDvJvdGW2k1F3ldIPQIEVTpbYwa/yz163P/Og20e5m3QQrYBOrM0uoQ/4NQzfmcO/KTg/Yvif+dc0SCQW0P+AagJ4Ek4OH8n0Brlh01e246Ti53S/tc6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763940; c=relaxed/simple;
	bh=kumiUlRz7JsyiKthWciBMIW1fQxBHennQS9s5scomyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoP741ebelRhVyLMxy6/u1dxUWfooPi1GMSPBEI3qhoieVex4XErj3fj/GFRqA/swdoHbKcqWWKeQG61fCUngYRxbfJwrW1hJ3UjhOnQWOUACQa2VQeieDF2PKmtMHMpYaBR2tAUQbd3oDRRj+C6qBfXCbBlu0auwgapI1kUFaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biplsEOG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biplsEOG"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so3300302a12.2
        for <linux-serial@vger.kernel.org>; Sun, 06 Sep 2026 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763938; x=1789368738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0keQuQDh3GWYquu5tDAaSwyIzlXxpUqzOXBgn/Zoyak=;
        b=biplsEOGD06UFI0ZWIjUe4UKaz69lRnhn2wsrfBDN5BsCBX1Vy23ielJINwadYTb9y
         BudNnqKZjSHNPvLiJI1ZUrnePMPSbVvS5tgoNMpV5DU+qWxOnXJ9IToSYSM2W4y1IdRJ
         dptODbOaDAjLGfUCDS4IfnRUokD4sk/8diRqme56Mov+ae58x/rxTyJRtODDWgsT1X/H
         J2aC/5etlILkI80w3OBKdE5UlSsZ/Lldxsd0MOwQcFFTv+Zrvkqbo7mhTrz8q+xd/jY9
         GI7UFurqwiFoT3EDOoPyzvEmn15NK5D1ahRfrF9a4ylPOiCNNR4yCc2bsR4jYGkMJonM
         Ax3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763938; x=1789368738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0keQuQDh3GWYquu5tDAaSwyIzlXxpUqzOXBgn/Zoyak=;
        b=JqtppVnIdMeRE5AuAE4mHyietfHe3IXh329i1hDjil0UNKglq0pZZN9DiZPOVAnTNu
         5FpjjUmulp7Zegxvo7Ip7YMvuU9vpK7X8q1WyjW8fzjeoZUlx6KnEWnYbE3PMggnK4kn
         4pS35ats9smbRX6j58Ol1EtEL1rO2zhc19b3s31l4CaP0e1kCL7lSYO2JVejf+JecC3g
         3o9iVKZXmOpbcKyTUHQq1C/DJH1qvSmi/hx1RPt1uSIrMICCBlLg5eaQMW0LVoSJGHRb
         FYexiXthdVhQE6Oh8Z/kNDIAXh8wmZP5+15s63wEXwOzttM/4UAQ1HE7rMQSaQezq/dg
         ZpaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw25TmsCviaCQ3Fa4+qApy/5pOWB8HT+5t34mSAa/Lbhz0ZmhfLHCed9iVlh/NcodJ9rx0mpXt/ROavluA=@vger.kernel.org
X-Gm-Message-State: AFuF++nUv8Bul8QOSfcwFKlbtqdDaWN/7tKlskPzUwNKKH89dIos4xir
	5SoEZBFoP+EtJeIEglCboGJAEgflCjg2o/22eBtHQAmfa317RZzXccG5
X-Gm-Gg: AYBFou0Ns6cpfSJx4H87LVz83LofFUooMu4r+qBED6cYBRJpy5DrUZh1gB12QjLRM7K
	t07Y8rjJoAtbwj4EJOuy/RRnxEhZwd13Mh1o7nwBr4hqoCDXcYFMJMxzNuOFAwPf5g+m95oQxln
	zaSbnnra6uZC1qHJd3gOjfTGjWkVCEqSjUrUIloLCUYUEPzwfmCyacex32LaX9HBNgsL5jgfg6Y
	gN6qKR6Sx512Wr4F/e7XWw3foDGcmP9I2P3nz9FlMv7MlBUgQPzkx8a0W4UKRz+T1BZlGAF8yc4
	ySk1wJaHbnl5UKUAhpHqhhWKd5xet43ScuVRcmH4/hBSsCDhab6J7HRdQ03ifXiEmn+LrAn6yNu
	vruuibnG47AAZSsXUD0b//fSupTLd5DPnFQ1exde0Moa4xJgUP8Lvo0Dcipcv+RIrDKfNTnMxLz
	6CT1Iod4wF+h0Y/MynmSSLnLAzLsxZaI7caUDBBzkU0uVrh86RcAc/OweiicKTmktAn9kuhkLXt
	lPSx7wXfm2YZtcj5xprdRM/
X-Received: by 2002:a05:6a21:15cf:b0:3cc:ec12:a788 with SMTP id adf61e73a8af0-3da39b57e15mr33996691637.4.1788763938332;
        Sun, 06 Sep 2026 23:52:18 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm28825941eec.21.2026.09.06.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:52:17 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] powerpc: fix repeated words in comments
Date: Mon,  7 Sep 2026 12:21:53 +0530
Message-ID: <20260907065153.33578-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907065153.33578-1-hemanth.selam@gmail.com>
References: <20260907065153.33578-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/powerpc/kernel/paca.c             | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0e263b97e016..2e0c5bac250d 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -101,7 +101,7 @@ static void *__init alloc_shared_lppaca(unsigned long size, unsigned long limit,
 /*
  * See asm/lppaca.h for more detail.
  *
- * lppaca structures must must be 1kB in size, L1 cache line aligned,
+ * lppaca structures must be 1kB in size, L1 cache line aligned,
  * and not cross 4kB boundary. A 1kB size and 1kB alignment will satisfy
  * these requirements.
  */
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index c3fa539a9898..c2486b43c5cc 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -384,7 +384,7 @@ int xics_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	 * the corresponding descriptor bits mind you but those will in turn
 	 * affect the resend function when re-enabling an edge interrupt.
 	 *
-	 * Set set the default to edge as explained in map().
+	 * Set the default to edge as explained in map().
 	 */
 	if (flow_type == IRQ_TYPE_DEFAULT || flow_type == IRQ_TYPE_NONE)
 		flow_type = IRQ_TYPE_EDGE_RISING;
