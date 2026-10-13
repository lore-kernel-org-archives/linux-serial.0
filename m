Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA814156C9
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855355; cv=none; b=HRaPFT3CSuVv6f7C0mkPrODroA3+6MhXt2K87qt5L7GQpZ7n5t124z3CKuS90R3NufXHR9qs5xqZp0gNVoBZSu+YT2ajm3GGAfHqrKIgN9DiIn+yPw8nikOPFZgedxlwCwnsqzqO1+ReQvVVqeO44Ut3mr5H5ypOTgxZasoW0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855355; c=relaxed/simple;
	bh=sFJ72AgPE1Tu7+0QasszMAieCLJI86cGxQyysbzgmZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBuC3yVdRjedOyxPUJL4jwUkm946PZ8eKJtsINuLxhFYE9R9r3Yr5Z3qPCjsMCdH5ZvGznH/er8a8Z4mh6sBldlK/QpCgJTNd+7Jzpmn9YLPXr5i/Nvpo2G2s7qqinYUoK5Bt6P0EPbgQXSSv6fw5DTLHFOxEU/xQHIc8uSuMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com; spf=pass smtp.mailfrom=timdoug.com; dkim=pass (2048-bit key) header.d=timdoug.com header.i=@timdoug.com header.b=QRx/vrQj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kswQaqdR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timdoug.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timdoug.com header.i=@timdoug.com header.b="QRx/vrQj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kswQaqdR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32B711400114
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 21:35:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 12 Oct 2026 21:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timdoug.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791855352; x=
	1791941752; bh=T9DPR+2n3dWm0xXe4jJx+wMjBkoYkR/+x3n7hyULjmY=; b=Q
	Rx/vrQjGS4aIvL+6atXZ/EJgExF6J+Cpo76zfb03yrOM+60+6v7uArudhJ+H1QeJ
	xTZtgktnMh6WvThrLqhTXso1BF7bQHcoqmFpIwfeA2EYsEuL7UeNQG8VSuHLDkFj
	Vz13RXcyWWMIDw5qeqNVObJAl6bntLhuCADRyqXfBVKOPGF/8qa8W0lvAQ0LRAy3
	KHVhtmpcf56SgpG/0kUQAgp0iSpM3e6gKBNpnUdNEQATnr4+MMqqTPc5yGcT00IT
	ZXVlFVTe4vs255+MyjvnURFRbE/cIe8Yy5oxnLaROPr5Qu8WiZhI2hvEKzWHeXf5
	ibBIaLPHlUaY4YEZms93g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791855352; x=1791941752; bh=T
	9DPR+2n3dWm0xXe4jJx+wMjBkoYkR/+x3n7hyULjmY=; b=kswQaqdR1CqvQNd/j
	DH3k9yIBZLtSSbmKqpxBQHajK++XFzKM/ugzlbHMR/rA31MdaSryaFu1GiuY42TQ
	aLBGFBMPEj+J/oFMadW+rwjaopWKzSHEAUVYcEN9kKgF6tds+hA3ze5y4sPCbb7H
	ZQMycuW3IBD85U7Ry5D7T3qDquIhOS7MMCjngongwHztRjjvvu4vpCgOGScgUajG
	VnZ9iATREWoQAri6WJrrsZ0PDIh2IK4ceVi9onA8KzGm1seB1UkNbRuHX5tFXxmB
	wognCfNqhPxY4KR5klcgGYtdNEcY4Wswk3ntTpP/dLmsugCNhHeQrQ+92CeiQSpg
	y3yrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=timdoug.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791855352; d=timdoug.com;
	mf=PG1lQHRpbWRvdWcuY29tPg==;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kWAs/ZXAOcRnQiL5Ipt6r9X1b2z64tei2DGzJJBL0idliiv
	8sdTUjlr6kPQtoNVLiwlBkDeCWo0+KBf9cdcSUejN4UReFwOMK+/urqkyGrzoQQY
	qIlhtCx7A6KN40m4zB5f3ZahhGUfccgzMjQ2ZTgvmc3CMTIWpi7c6gCITx+fxtGw
	+aVLPL5EG3K+vLdsM8nJf6CUoigNH7V9Ifnk5XvwSN0XT8cvWsaqUFp0Zyz9uRee
	qGbwEviOpLPwkDImFR9OGJXAMGGNFgP/FAU+z73IEuzErdsbFP3iKQMoBNmf9FPr
	Citu+Y1CbNbeyLtDEa2wNbK0cq+vLvFCi7MNqcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PrJ717gr86u/8jEwEDf0Kba/XI0ZzKRLKWY3qUAP+p4=:sFJ72AgPE1Tu7+0QasszMAieCLJI86cGxQyysbzgmZo=;
X-ME-Sender: <xms:94rNauaQUoD4JYgxey6jAGfgXwXq7ZwhbOJ7SD71hJhzS9MwxQr0Tg>
    <xme:94rNavrb1jt46q3lHthhH0uc8hRbTYWNliNU0GYLm4Z3Y4NwVBkcG5FPBxCw0S3n6
    ERSkWNzuV0fbDUE9wCCDS3f-6rqTKguZmjyMu2zS2p8zW9Jv34ksRY>
X-ME-Received: <xmr:94rNaiSJ5BEQlHH_nOhrcLzEtCQn_-o1x45EfkBPZNP6iXl6cJ8_gpplsQwy>
X-ME-Proxy-Cause: dmFkZTGNbHk6fXAkhTsvEfU2amaovOmEajQYoQOBQ1jMMVTp78asCsTJKEOp2KUEoCfFhn
    jYQALR5baaW2Zmb2DSGiJU/TnUm2SfI3WostCaGFlcqIuQLSHsZ9RdgXfBjYku/rYSwytg
    gG+1Aavqm07SB9Nn6UC7/pwAlSnVJ/PwqLx0Zmi8Ps17l4MBClYGyctPQiDIoTu2tkkI4I
    +6r+oLdSUUBoLun+FPRvQnzwVjLQxo28j78W4Y4bg5ruy1wHbYTNmkWF91Y2zTMHrsLkbj
    qi0arGzxtkYavMM9fPhINZUuIXe1wxSlfZK0MTfoZfYvKJ5SD5BpIp5OQ6fEuy6blOsuKw
    nW3eLSjF2BND2Vjd97g59nD2DKqYZQu+JlfKwLQE9lwE88zee9wSf4CNj8n9SzXihMKcpZ
    Zs4p6+rzdHsFXI7syolFYyNB5I91mkE9iGE9b2x16B2MmkCHxTb8By+z7HsxsTcQ9rW4x+
    416IK9L8AYd4buUMJu6+7LDzkBydq0YrPQCwv2Vdj6Cv6beKVo5eL5egddT1MitD2oxa6L
    6US4AknzJ8UIp+SokIdMhItMdbeJRTd9GzV0GWOvk15FOcu61RhAyrpm4kcpP48hL4X5Oo
    FflG0RpWyZK/HpbuK0AJwUxFkUlqg5WuyC8qypY8zrSBHuFCOWKh43VBacmg
X-ME-Proxy: <xmx:94rNajqPmY2ZSWPPxJfXqCyJ4D_fTjfL20eEeGabkwpZxUCeAInFiQ>
    <xmx:94rNas0yU2ZDS9Gfi176s1AAZ8sPdDTqo2UdfoTW6shA7C3aRNV-jg>
    <xmx:94rNai46Pqk-WOfb_rXbsFNnQs5-L-hxY3Lk0NqXWjSVg1pYHXFkzg>
    <xmx:94rNagRTfUbBCTDIEh2OT5ePTQzYybdIDgD3ySg7vRHrQWaLcdjjzg>
    <xmx:-IrNahQ6Ea3zrp06XyzDGRg_fYH7RaJg4fHN_GzfuQ9EmBgTChCaQ2yH>
Feedback-ID: i12bc4175:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 21:35:50 -0400 (EDT)
From: Tim Douglas <me@timdoug.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	Tim Douglas <me@timdoug.com>
Subject: [PATCH 2/2] serial: pmac_zilog: report received breaks
Date: Mon, 12 Oct 2026 21:35:41 -0400
Message-ID: <20261013013541.4535-3-me@timdoug.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013013541.4535-1-me@timdoug.com>
References: <20261013013541.4535-1-me@timdoug.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmz_status_handle() sets PMACZILOG_FLAG_BREAK from RR0, and
pmz_receive_chars() clears it on the null character that ends the
break without marking that character, then tests BRK_ABRT in RR1,
where the SCC does not set it in asynchronous mode. Breaks therefore
arrive as plain NULs: brk is never counted and BRKINT, PARMRK and SysRq
never see them.

Set BRK_ABRT in r1 for that character, as sunzilog does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Tim Douglas <me@timdoug.com>
---
 drivers/tty/serial/pmac_zilog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index f49d605..a612f1d 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -233,6 +233,7 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 		ch &= uap->parity_mask;
 		if (ch == 0 && uap->flags & PMACZILOG_FLAG_BREAK) {
 			uap->flags &= ~PMACZILOG_FLAG_BREAK;
+			r1 |= BRK_ABRT;
 		}
 
 #if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
-- 
2.54.0 (Apple Git-157)

