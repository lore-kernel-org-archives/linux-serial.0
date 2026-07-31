Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A048987A;
	Fri, 31 Jul 2026 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485189; cv=none; b=h71iKbHeLYmzEL3Q7pplJr4IECS19xl51ORCa7qQp4B5h5xNVw7qDsi4ud9Oiu7Y0QAcwMA75Xww4YoIsxicemLwKznfdUcOYullDCWrmNcvkRxOyM84HcxzUYeB8sjqdI1MHPaSaOqN1Ou/hPgnn+CzL63WWNnruv0pHRkZeio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485189; c=relaxed/simple;
	bh=37nqpR+azVh2OVGc7/pp81BmEUGzX/o39f+HrKsGLBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=srTkm1dcSMuQXi9mYOgXcfl2UT8UxbU5nibjQm7e9t2oibEa9Bc9rAvoQae06T+REYbf4EXReGtQKzm3+fjoicxw/3YjVrn1RE+Alx1VPbuqgwUiJXHFPQIuxLjrgum3Gsi7LEsvsSNFUhd6vHlPyIOmRfoSANEfh8Rp24spGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T5pkToVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T5pkToVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5981F000E9;
	Fri, 31 Jul 2026 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785485187;
	bh=9CB+C730bVk+LZSGDTLoPdtpEiK95ycCVPEUzrYXrFA=;
	h=From:Subject:Date:To:Cc;
	b=T5pkToVV7hqtC4a7v/zXa7dFpFHiliDiznyYYkE6IWoof780gXrJzskDBJk4mAgaT
	 h97nCzpU/mzq8S+F/F+etfBB05SJ6FiFMGoIELemA1nTlCP+RNCvA1/AuKhk80pcaY
	 wF+qprT/MbWJ+n1ohWgnRyzdPujfy8goyJMk5kho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] serdev: Some small serdev bugfixes found by code scans
Date: Fri, 31 Jul 2026 10:06:08 +0200
Message-Id: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB2IFox4leJiNBMdEVsyMbSId
 2+qy7f4/wDlIKzQFQcETqLy2jKqsoBxpm1iFJcNtakbYx8VkujKGOMXc+k4YTtYR+QNWd9Azt6
 BvXyu5bO/rfuw8Bj/HzjPH9EM82x0AAAA
X-Change-ID: 20260731-aisle-tty-serdev-8b7daaf0a7f6
To: Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joshua Rogers <linux@joshua.hu>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=704;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=37nqpR+azVh2OVGc7/pp81BmEUGzX/o39f+HrKsGLBI=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk54aV5rO+XvV2jeevJm5ITt1pmsH4U5+w5dYDVaGu4i
 9xcNqulHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRmOkMC+ZaB28vPvNtYt4K
 wz/7ci7/cZnj/YNhwewzK0QSJ2rWHkq6dktEKTJPJOzABQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Joshua at AISLE has been kind enough to run a bunch of scans on the
tty/serial code and here are two minor fixes for the vt code that the
tools found.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Joshua Rogers (2):
      serdev: fix race between tty-port unregister and in-flight callbacks
      serdev: use tty_port_tty_get() in ttyport_write_buf() to prevent UAF

 drivers/tty/serdev/serdev-ttyport.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)
---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260731-aisle-tty-serdev-8b7daaf0a7f6

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>

