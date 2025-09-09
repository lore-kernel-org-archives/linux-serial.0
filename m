Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F4E1172A;
	Tue,  9 Sep 2025 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379397; cv=none; b=r+E3ioDQPdeWkuBc0nZfLHNjhtUPh7tslG4L4p/siRYRoHeHXdqFuph6bWgyQn4y74CsgqS1HUs79vAvqgw0dtyEcdAsPkjsf6LEMHm9iudl0HNK5XlRZ8hVQJ9yNdIiI3OAL71Nu4KPtqxt2hhj113MECOyBrPxRd6+AUnjpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379397; c=relaxed/simple;
	bh=XhzBiDGiol9wyvPgh5vh1KhcYsg2UGW9ydEq1dGZiSY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lohc2djSdpeD84r9xVla/3Gp/35UtzOvZF0ct3qyMgVhRwdptnkqNCmzyyq/lFuDcs1FF3aycbAUnCb6GB6dFWjZ4mMXLHh1sR/HlQPHI5rTV8CFNLUysqndR5A0nKJm7fZeqnipz/O31h6MIGDQBnEKUafeMYpn9SFKOberGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MpqrQSd3; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MpqrQSd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757379084; bh=Cb68Jn2uwxC6pyB6/FvUvwuMpp16nWNi6ZZMlRAV/Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MpqrQSd3azuZ/JfXiGdjf11PaOprBxinwsHTmzarYFVm5Eb+o2DwUxl0uL/8KIfxE
	 cWVjP1OTQrZWXrej8sn8HmBMSUu6wWBF/nh+ATZeRiC4Js13Dnth5zkjtrZO9qCTWl
	 JqKDDyepxK13JVYjEfbR2EMIaXhpVsmHiavUZnt4=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id CD6896F1; Tue, 09 Sep 2025 08:51:22 +0800
X-QQ-mid: xmsmtpt1757379082t7h96ve00
Message-ID: <tencent_CAD45DB31906CF890DBB25AB0DED12205D07@qq.com>
X-QQ-XMAILINFO: OeFOmPvKThpBxl2fsSe77dJmC11yOuJLqXTDzULnTvHALyPR/iVM2407KuSVK5
	 sTLIyIjFPySfBBaw1PF2+d0n3j2x0JmtsPIWBMTZc7sHtq+Gs4D2mD96rR6dwScE4fhE9RdiSU62
	 beGTpIrVsodIIMkkCJuLPTZxUXLxY6dj6p9gRW4sppCIylsvjIJpicobhtOmxW1g49ig/Dxq/boN
	 iO0kAvxYAWr3rNMSFb2eanLwKjHPUSyAioyBbGe53+VWEmUL5/d1hSw0+Zv32Vbn3Ll4/3KZgJWy
	 tTRYHKMg6dOHL/TXmeXm7kaC1a+vINNr8ISyE2L6ZJEUHu1bVGgwWLXlVpJU0nhnbbsHJISRkqn/
	 IvV8b9740zzhGc6wAOAsnrukhkWfy8Xub4EqZp0PacpTwXznzP6ldUSoUL3s4UNoHHsTjuj2iQyv
	 MEgvOJyxk6FY3NxiXjRup8Dox856WE2ST/eBWEd7XHBqKvJgp0ebQgoMcp99MC+C8FTj4hwoYjX3
	 pSHUlw841PM+tZ+i5g38W3vuNdukEoDyizfx3Kd9tSAmRKF+ImFYpagXagiKoSIHbZXrI7FBb90J
	 h16SVzpok1kCx9Gmu+YLrUi7V5GX77igEYvJxAbecue02aN/BUWQIyysT8V7UmFRvB/hLNbeNOg8
	 B7oGeV2+QorCbXHj7c+nUOXQtZOHpHEbhIGQefJMg3XNbhnNUglAHEuZzLlYzkMI7RZqcSLQFNuf
	 h+CC8jtyhcd5sR+zmext8CJZnLiGNxgjMgri/snxuIsnTcJqykLVCmAUWfb6t5f4n+8fMi54wS+u
	 NMBl2gqwnTwwsw5MnHS25aX6QVqOBOaz0y4PqujOVB9T1GrBWA6DLpfA2DnU/hS9NaCmu4uqSrQN
	 WUngRaffc93x546UlleVSejV7crGioIy0FZK5XCmKnwS+s1vV+oSlj029m4t/RWiZ3nb5T2A4Yz1
	 55If3/JESvDYxybebbmYmUXcit/JDGVerdDAI/xLAT2gI7ZSQ81S2ATctg/nC/
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH Next] vt: move vc_saved_screen to within tty allocated judgment
Date: Tue,  9 Sep 2025 08:51:22 +0800
X-OQ-MSGID: <20250909005121.2757067-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68bf244a.050a0220.192772.0882.GAE@google.com>
References: <68bf244a.050a0220.192772.0882.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Everything starts with the assumption that a tty has been allocated.
Therefore, Move it to within the tty allocation check.

Fixes: 23743ba64709 ("vt: add support for smput/rmput escape codes")
Reported-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6cb41c144427dc0796a
Tested-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/tty/vt/vt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 1d9abcfac4c9..6e0089b85c27 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1341,10 +1341,10 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 		vc_uniscr_set(vc, NULL);
 		kfree(vc->vc_screenbuf);
 		vc_cons[currcons].d = NULL;
-	}
-	if (vc->vc_saved_screen != NULL) {
-		kfree(vc->vc_saved_screen);
-		vc->vc_saved_screen = NULL;
+		if (vc->vc_saved_screen != NULL) {
+			kfree(vc->vc_saved_screen);
+			vc->vc_saved_screen = NULL;
+		}
 	}
 	return vc;
 }
-- 
2.43.0

