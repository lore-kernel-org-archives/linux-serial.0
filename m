Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com [101.71.155.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849240B6F4;
	Mon, 19 Oct 2026 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404675; cv=none; b=ch+7w+SRvmvPsL+eBG+7hAAMkzLloJ6Emqa93AmhDARZxhewB0wx9lTfbOES7SWCG6NPFu5FGIoboIGihCaEXpFfzm5gduny1j42XJMeYq+j9pm3Bh4vIJN6jfZ+U+bxoKVz3dmRoCHdlL+DotLEZTnaeIjP3WOlutp5wAE+Gm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404675; c=relaxed/simple;
	bh=P5ZOGYNyg8L4aWfSSNCbwWmwvGqHOzjsLvZxi1qWtsQ=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=MCrCA6x7wzUHNQ4Fha7ctnG/tSON0qTE9eVz8lmk2t3Ucpzq8sevVIuMRjjXUpOGpdQkBSWpkPpMXvAFUDC+2TP2y2kMWpV86N5tIvIxVHX9yEUyz/xBDUvDMVzKHgo4I/sDU/dU8KG+rYJgh19RuJDh/eyHDlGPncqWU52Qg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn; spf=pass smtp.mailfrom=hdu.edu.cn; dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b=k0Qyk3oV; arc=none smtp.client-ip=101.71.155.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b="k0Qyk3oV"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AEMA9QCuLOMl3el2RGWf44oE.1.1792404355168.Hmail.252270051@hdu.edu.cn>
To: linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: jirislaby@kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?dHR5OiBodmM6IHBvc3NpYmxlIHVzZS1hZnRlci1mcmVlIGluIHJlc2l6ZSB3b3JrIGR1cmluZyBodmNfcmVtb3ZlKCk=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 252270051@hdu.edu.cn( [183.157.177.89] ) by ajax-webmail ( [127.0.0.1] ) ; Mon, 19 Oct 2026 18:05:55 +0800 (GMT+08:00)
From: LI xiao <lixiao0@hdu.edu.cn>
Date: Mon, 19 Oct 2026 18:05:55 +0800 (GMT+08:00)
X-HM-Tid: 0aa153977f1fd458kusy54270f56bd31
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUseVk1DGUNKQ08fHk0ZH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSk5MVUpMTFVDQllXWRYaDxIVHRRZQVlLVUtVS1
	VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=k0Qyk3oVsTrpeNVuKRQr2fS4IJnAzD50uPkztkH0qmMGQP1VEmw6oY6yfNmzOUtxYS8IIOJVQM86Yzw0UFr4Y40vqi5HnhJoEpDwNhGU401hC8HUHFnaWZ0KgnLqAg59V7LGQZXoh5+vrcGdMxXQfiFQbBO0y55q2XXpee1S0NU=; s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1;
	bh=P5ZOGYNyg8L4aWfSSNCbwWmwvGqHOzjsLvZxi1qWtsQ=;
	h=date:mime-version:subject:message-id:from;

SGksCgpJIGZvdW5kIGEgcG9zc2libGUgdXNlLWFmdGVyLWZyZWUgaW52b2x2aW5nIHRoZSBIVkMg
cmVzaXplIHdvcmsuCgpBIHF1ZXVlZCBodmNfc2V0X3dpbnN6KCkgY2FuIGFjY2VzcyBocCBhZnRl
ciBodmNfcmVtb3ZlKCkgZHJvcHMgdGhlIGZpbmFsIHR0eV9wb3J0IHJlZmVyZW5jZSBhbmQgaHZj
X3BvcnRfZGVzdHJ1Y3QoKSBmcmVlcyB0aGUgY29udGFpbmluZyBodmNfc3RydWN0LgoKSSByZXBy
b2R1Y2VkIHRoaXMgb24gTGludXggbWFpbmxpbmUgY29tbWl0IGMwM2MxYTE0NTA3ZGZhZjhiODU2
YzI2MDhmOWFjMjE2MDIxZmMyMjIsIHVzaW5nIGEgS0FTQU4tZW5hYmxlZCB4ODZfNjQga2VybmVs
IGluIGEgMi12Q1BVIFFFTVUgZ3Vlc3QuCgpUaGUgcmVwcm9kdWNlciBpcyBhbiBvdXQtb2YtdHJl
ZSB0ZXN0IG1vZHVsZSB3aG9zZSByZW1vdmFsIHRocmVhZCBjYWxscyBodmNfcmVtb3ZlKCkgY29u
Y3VycmVudGx5IHdpdGggYSBxdWV1ZWQgaHZjX3Jlc2l6ZSgpIG9wZXJhdGlvbi4gS0FTQU4gcmVw
b3J0cyB0aGF0IHRoZSBxdWV1ZWQgaHZjX3NldF93aW5zeigpIHdvcmsgYWNjZXNzZXMgdGhlIGZy
ZWVkIEhWQyBvYmplY3QuIFRoaXMgcmVwcm9kdWNlcyB0aGUgSFZDIEFQSS1sZXZlbCBsaWZldGlt
ZSBpc3N1ZSwgYnV0IGRvZXMgbm90IHlldCBleGVyY2lzZSB0aGUgZnVsbCB2aXJ0aW8tY29uc29s
ZSBob3QtdW5wbHVnIHBhdGguCgpSZWxldmFudCBLQVNBTiByZXBvcnQ6CgpCVUc6IEtBU0FOOiBz
bGFiLXVzZS1hZnRlci1mcmVlIGluIHR0eV9wb3J0X3R0eV9nZXQrMHhhOC8weGIwClJlYWQgb2Yg
c2l6ZSA4IGF0IGFkZHIgZmYxMTAwMDAwYTU1YTQ4OCBieSB0YXNrIGt3b3JrZXIvMDowLzkKV29y
a3F1ZXVlOiBldmVudHMgaHZjX3NldF93aW5zegpDYWxsIFRyYWNlOgp0dHlfcG9ydF90dHlfZ2V0
KzB4YTgvMHhiMApodmNfc2V0X3dpbnN6KzB4NmUvMHgxMTAKcHJvY2Vzc19vbmVfd29yaysweDY4
Yy8weDExODAKd29ya2VyX3RocmVhZCsweDRiNy8weGIzMAoKQWxsb2NhdGVkIGJ5IHRhc2sgNjQ6
Cl9fa21hbGxvY19ub3Byb2YrMHgxY2QvMHg0YTAKaHZjX2FsbG9jKzB4MmUxLzB4YTIwCmh2Y19s
aWZldGltZV9yZXByb19pbml0KzB4NjAvMHhmZjAgW2h2Y19saWZldGltZV9yZXByb10KCkZyZWVk
IGJ5IHRhc2sgNjY6CmtmcmVlKzB4MTI3LzB4M2IwCmh2Y19yZW1vdmUrMHhlYS8weDE1MApyZW1v
dmVfaHZjX3BvcnQrMHgxYy8weDQwIFtodmNfbGlmZXRpbWVfcmVwcm9dCgpUaGUgcmVwcm9kdWNl
ciBhbHNvIGNhcHR1cmVkIHRoZSBmb2xsb3dpbmcgd29yay1xdWV1ZWluZyBzdGFjazoKCl9fcXVl
dWVfd29yaysweDcwZC8weDExZjAKcXVldWVfd29ya19vbisweDU5LzB4NjAKaHZjX2xpZmV0aW1l
X3JlcHJvX2luaXQrMHgxMGQvMHhmZjAgW2h2Y19saWZldGltZV9yZXByb10KCktBU0FOIGFsc28g
cmVwb3J0ZWQgYSB3cml0ZSB0byB0aGUgc2FtZSBmcmVlZCBvYmplY3Qgd2hpbGUgdGhlIGNhbGxi
YWNrIHdhcyBleGVjdXRpbmc6CgpCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluCl9y
YXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweDY2LzB4ODAKV3JpdGUgb2Ygc2l6ZSAxIGF0IGFk
ZHIgZmYxMTAwMDAwYTU1YTRhOCBieSB0YXNrIGt3b3JrZXIvMDowLzkKV29ya3F1ZXVlOiBldmVu
dHMgaHZjX3NldF93aW5zegpDYWxsIFRyYWNlOgpfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUr
MHg2Ni8weDgwCnR0eV9wb3J0X3R0eV9nZXQrMHg3Ny8weGIwCmh2Y19zZXRfd2luc3orMHg2ZS8w
eDExMApwcm9jZXNzX29uZV93b3JrKzB4NjhjLzB4MTE4MAp3b3JrZXJfdGhyZWFkKzB4NGI3LzB4
YjMwCgpUaGUgb2JqZWN0IHdhcyBhbGxvY2F0ZWQgZnJvbSBrbWFsbG9jLTUxMiwgYW5kIHRoZSBy
ZXBvcnRlZCByZWFkIHdhcyAxMzYgYnl0ZXMgaW50byB0aGUgZnJlZWQgNTEyLWJ5dGUgcmVnaW9u
LgoKVGhlIHJlcHJvZHVjZXIgcmVxdWlyZXMgcm9vdCBwcml2aWxlZ2VzIHRvIGxvYWQgaXRzIG91
dC1vZi10cmVlIG1vZHVsZSwgd2hpY2ggdGFpbnRzIHRoZSBrZXJuZWwuCgpDb3VsZCB5b3UgY29u
ZmlybSB3aGV0aGVyIHRoaXMgaXMgYSB2YWxpZCBidWc/CgpUaGFua3MsCkxJIFhpYW8=
