Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B876D53C
	for <linux-serial@vger.kernel.org>; Thu, 29 Feb 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244935; cv=none; b=bOhF0RKR/XH2OdZjw9vxiUmneqoOD4IvQyJMQxHmHblUvubqcukYz2JpoumZ5QKMIzrKUvQQKiuihQicDWJAdpYkybLPACx7p13yzqV8ahavPf0b3p0tMIjtj2nJ+H5gh6iMJDRY0xM8SAr+Z1937hegIUx6OZCpyBwmnSw+bSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244935; c=relaxed/simple;
	bh=S7y88vjucnP1Eh33YdK3uXxoNAbnV3owuIt5M1esEQg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Cd9vHUh25Nm1cVWa+dbLK9+CVi0Rs9WH7xqVNuu/TsHQUg0Io0jzYr1CE6fAGkarEMQ0dImxPBj6mJRSE9IaWRwyYYZtwSijr/EpIgRv8Qu+qkqW6VVMxkYGcorb9LRPNaLwFCaVvioT6QWmJhtWbFJf9ZBillSq32JafThjx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oeQZjP/S; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=ZuKYj5Dk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oeQZjP/S";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ZuKYj5Dk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D072370A8;
	Thu, 29 Feb 2024 17:15:33 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
	S7y88vjucnP1Eh33YdK3uXxoNAbnV3owuIt5M1esEQg=; b=oeQZjP/Sn5+VxVRa
	Hsx8hCtC1sJeC7RkBfBb2xICJ48DEz8MBEtHJoRlWAKW1xtWyg3g4U9o3pS8rudo
	TepxsF4ATYb2sSAqMz0u/XIPlsSClP6tbR7tDT7VY62iTYIqVqjeZ1dVDwG1rWWZ
	cQFA0AfMj1phupo3MEOOiDDodAo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4678A370A6;
	Thu, 29 Feb 2024 17:15:33 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=S7y88vjucnP1Eh33YdK3uXxoNAbnV3owuIt5M1esEQg=;
 b=ZuKYj5Dk2oZ5UnfxfijHxXaBp+wypvZm7j4bmMToFJUGj7ean+ICiYxMzLxmHdKlF7iv4Aq9YpkvMRYZaRwkgt36w4Sj0s86PaTmrDa2fHuf00k47fNsmXr8DI4GbcTBq3qFOElmgzZwAM7zeM/Q1pNGd2imWi9PXIFCNWynI+M=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48858370A4;
	Thu, 29 Feb 2024 17:15:29 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 1B6B9B878A1;
	Thu, 29 Feb 2024 17:15:27 -0500 (EST)
Date: Thu, 29 Feb 2024 17:15:27 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-serial@vger.kernel.org
Subject: [PATCH v2] vt: fix unicode buffer corruption when deleting
 characters
Message-ID: <sn184on2-3p0q-0qrq-0218-895349s4753o@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 0BF6A43C-D750-11EE-9F97-F515D2CDFF5E-78420484!pb-smtp20.pobox.com

This is the same issue that was fixed for the VGA text buffer in
commit 39cdb68c64d8 ("vt: fix memory overlapping when deleting chars
in the buffer"). The cure is also the same i.e. replace memcpy() with
memmove() due to the overlaping buffers.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Cc: <stable@kernel.org>
---

From v1: spell out the actual change in the commit log.

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c8..38a765eadb 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -381,7 +381,7 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 		u32 *ln = vc->vc_uni_lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
-		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
+		memmove(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
 		memset32(&ln[cols - nr], ' ', nr);
 	}
 }
-- 
2.44.0

