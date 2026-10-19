Received: from mail-m10313119137.xmail.ntesmail.com (mail-m10313119137.xmail.ntesmail.com [103.131.191.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2E48F826;
	Mon, 19 Oct 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.131.191.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402906; cv=none; b=UllspSHUC/KakWnHDi1U/OXw6feMA+NxzyhzD+Ar0wSmuA/p9sfbD9t2dT+h4hV1qkTrw+HW3hw2/3YIZnd0g+LSe8pc0FZcx+SJd/W+RNzwmmKQDv1vqqomkOSs0PzMgK2VAozRnMUMOnwG6mOuMgnUzJeVFlJsx4ifNbJ2YdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402906; c=relaxed/simple;
	bh=XlIrVZpnCWBbE1TRwGCT69Jev2IMGbA2127pX1TocR0=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=eZ3k+G6zPSceDUh5uCON/CsUlbM1MxDBVBtSBNZGPvx9IdBpJ98Wf9hTjIw+Z1skyXLfqQDCSukeuhOSHUkFOvALH/gfO3GB1Cml9EmcSCyUepADtOcK4QqiVvRsC+Uf0Omo3ImR6KUC9sjy0lp5EpXMSejBQnOPDzhym8bvzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn; spf=pass smtp.mailfrom=hdu.edu.cn; dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b=euqASJC7; arc=none smtp.client-ip=103.131.191.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b="euqASJC7"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAoAPQC*LLYlOtD-w3m9zaph.1.1792402892829.Hmail.252270051@hdu.edu.cn>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: =?UTF-8?B?c2VyaWFsOiBwY2hfdWFydDogcG9zc2libGUgUlggRE1BIGJ1ZmZlciB1c2UtYWZ0ZXItZnJlZSBkdXJpbmcgc2h1dGRvdw==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 252270051@hdu.edu.cn( [183.157.177.89] ) by ajax-webmail ( [127.0.0.1] ) ; Mon, 19 Oct 2026 17:41:32 +0800 (GMT+08:00)
From: LI xiao <lixiao0@hdu.edu.cn>
Date: Mon, 19 Oct 2026 17:41:32 +0800 (GMT+08:00)
X-HM-Tid: 0aa153826413d458kusy44e252b6bc37
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUJDVhkeGEkYTh8aShlIS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSk5MVUpMTFVDQllXWRYaDxIVHRRZQVlPS0hVSk
	tISkxDSlVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=euqASJC7QJi6+LCJnSbiVNt9FtghZznmJDLcCG2JDqc2Y9oyqJVhblBepRycZN9QhY8biDHQRfo3ElVK8cwhDUn/WNfbx/lWxutvgpgN01p8Vph8uJ/f9vDX0EOW86Szau1r9qTaUt6hj2QRXEh5bbxfz6Y5nhyT7AWn+y9poeI=; s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1;
	bh=XlIrVZpnCWBbE1TRwGCT69Jev2IMGbA2127pX1TocR0=;
	h=date:mime-version:subject:message-id:from;

SGVsbG8sCgpJIGZvdW5kIGEgcG9zc2libGUgcmFjZSBpbiB0aGUgUENIIFVBUlQgZHJpdmVyJ3Mg
c2h1dGRvd24gcGF0aCBhbmQgd291bGQgYXBwcmVjaWF0ZSB5b3VyIGFkdmljZSBvbiB3aGV0aGVy
IHRoZSBjdXJyZW50IG9yZGVyaW5nIGlzIHNhZmUuCgpJbiBkcml2ZXJzL3R0eS9zZXJpYWwvcGNo
X3VhcnQuYywgcGNoX3VhcnRfc2h1dGRvd24oKSBkaXNhYmxlcyB0aGUgVUFSVCBpbnRlcnJ1cHRz
IGFuZCByZXNldHMgdGhlIEZJRk8sIHRoZW4gY2FsbHMgcGNoX2ZyZWVfZG1hKCkgYmVmb3JlIGZy
ZWVfaXJxKCk6CgpwY2hfdWFydF9oYWxfZGlzYWJsZV9pbnRlcnJ1cHQocHJpdiwgUENIX1VBUlRf
SEFMX0FMTF9JTlQpOwpwY2hfdWFydF9oYWxfZmlmb19yZXNldChwcml2LCBQQ0hfVUFSVF9IQUxf
Q0xSX0FMTF9GSUZPKTsKLi4uCnBjaF9mcmVlX2RtYShwb3J0KTsKZnJlZV9pcnEocHJpdi0+cG9y
dC5pcnEsIHByaXYpOwoKV2hlbiBETUEgaXMgZW5hYmxlZCwgcGNoX2ZyZWVfZG1hKCkgcmVsZWFz
ZXMgdGhlIFJYIERNQSBjaGFubmVsIGFuZCBmcmVlcyB0aGUgY29oZXJlbnQgUlggYnVmZmVyIHVz
aW5nIGRtYV9mcmVlX2NvaGVyZW50KCkuCgpIb3dldmVyLCB0aGUgSVJRIGhhbmRsZXIgcGNoX3Vh
cnRfaW50ZXJydXB0KCkgYWNxdWlyZXMgdWFydF9wb3J0X2xvY2soJnByaXYtPnBvcnQpIGFuZCBt
YXkgY2FsbCBkbWFfaGFuZGxlX3J4KCksIHdoaWNoIGFjY2Vzc2VzIHByaXYtPnJ4X2J1Zl92aXJ0
IHRvIGNvbnN0cnVjdCB0aGUgc2NhdHRlcmxpc3QuIEkgZG8gbm90IHNlZSBwY2hfdWFydF9zaHV0
ZG93bigpIGFjcXVpcmluZyB0aGUgc2FtZSBwb3J0IGxvY2sgYmVmb3JlIHJlbGVhc2luZyB0aGUg
RE1BIHJlc291cmNlcy4KCk15IGNvbmNlcm4gaXMgdGhhdCBhbiBJUlEgaGFuZGxlciBhbHJlYWR5
IGV4ZWN1dGluZyBvbiBhbm90aGVyIENQVSBjb3VsZCBzdGlsbCBhY2Nlc3MgdGhlIFJYIGJ1ZmZl
ciB3aGlsZSBwY2hfZnJlZV9kbWEoKSBmcmVlcyBpdC4gVGhlIHN1YnNlcXVlbnQgZnJlZV9pcnEo
KSBvY2N1cnMgb25seSBhZnRlciB0aGUgYnVmZmVyIGhhcyBiZWVuIGZyZWVkLCBhbmQgdGhlIHNl
cmlhbCBjb3JlIGNhbGxzIHN5bmNocm9uaXplX2lycSgpIGFmdGVyIHRoZSBkcml2ZXIncyBzaHV0
ZG93biBjYWxsYmFjayByZXR1cm5zLgoKQ291bGQgeW91IGNvbmZpcm0gd2hldGhlciB0aGlzIG9y
ZGVyaW5nIGNhbiByZXN1bHQgaW4gYSByYWNlIHdoZXJlIHRoZSBJUlEgaGFuZGxlciBhY2Nlc3Nl
cyB0aGUgZnJlZWQgUlggYnVmZmVyLCBvciB3aGV0aGVyIGFuIGV4aXN0aW5nIGxvY2tpbmcgb3Ig
bGlmZWN5Y2xlIGd1YXJhbnRlZSBtYWtlcyB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBzYWZl
PwoKSSBoYXZlIG5vdCByZXByb2R1Y2VkIHRoaXMgaXNzdWUgYXQgcnVudGltZS4gVGhlIFFFTVUg
ZW52aXJvbm1lbnQgYXZhaWxhYmxlIHRvIG1lIGRvZXMgbm90IGVtdWxhdGUgdGhlIFBDSCBFRzIw
VCBVQVJULCBhbmQgSSBkbyBub3QgaGF2ZSBtYXRjaGluZyBoYXJkd2FyZSBmb3IgYSBLQVNBTiB0
ZXN0LgoKSSBvYnNlcnZlZCB0aGlzIG9yZGVyaW5nIGluIExpbnV4IDYuMTguMSBhbmQgdmVyaWZp
ZWQgdGhhdCB0aGUgcmVsZXZhbnQgY29kZSBpbiB0aGUgY3VycmVudCBtYWlubGluZSBzb3VyY2Ug
cmVtYWlucyB1bmNoYW5nZWQgZnJvbSBjb21taXQgYzAzYzFhMTQ1MDdkZmFmOGI4NTZjMjYwOGY5
YWMyMTYwMjFmYzIyMi4KCkkgaGF2ZSBub3QgcHJlcGFyZWQgYSBwYXRjaCBiZWNhdXNlIEkgd291
bGQgZmlyc3QgbGlrZSB0byBjb25maXJtIHdoZXRoZXIgdGhpcyByYWNlIGlzIHBvc3NpYmxlLgoK
VGhhbmtzLApMSSBYaWFv
